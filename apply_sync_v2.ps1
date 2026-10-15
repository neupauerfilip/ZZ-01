$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$index = Join-Path $root "index.html"

if (-not (Test-Path $index)) {
  Write-Host ""
  Write-Host "CHYBA: index.html nebyl nalezen vedle patch skriptu." -ForegroundColor Red
  Write-Host "Zkopiruj apply_sync_v2.bat a apply_sync_v2.ps1 do korenove slozky projektu ZZ-01 vedle index.html a spust BAT znovu."
  exit 1
}

$html = [System.IO.File]::ReadAllText($index, [System.Text.Encoding]::UTF8)

if ($html.Contains("SYNC V2: server-first bootstrap")) {
  Write-Host "SYNC V2 uz je aplikovan." -ForegroundColor Yellow
  exit 0
}

$backup = Join-Path $root "index.before_sync_v2.html"
Copy-Item $index $backup -Force

function Replace-Between([string]$text,[string]$start,[string]$end,[string]$replacement) {
  $s = $text.IndexOf($start)
  if ($s -lt 0) { throw "Nenalezen zacatek bloku: $start" }
  $e = $text.IndexOf($end,$s)
  if ($e -lt 0) { throw "Nenalezen konec bloku: $end" }
  return $text.Substring(0,$s) + $replacement + $text.Substring($e)
}

$subjectStart = "  async function syncCurrentTeacherSubjectsDirect(){"
$subjectEnd   = "  async function fetchRemoteSchoolStructureRows(){"
$subjectFn = @'
  async function syncCurrentTeacherSubjectsDirect({allowDeletes=true}={}){
    if(!remoteSchoolStructureEnabled()) return false;
    const schoolId=state.school.id;
    const {data:sessionData,error:sessionError}=await supabaseClient.auth.getSession();
    if(sessionError) throw sessionError;
    const teacherId=sessionData?.session?.user?.id;
    if(!teacherId) throw new Error('Chybí přihlášený Supabase uživatel.');

    const [classesRes,subjectsRes,catalogRes,classSubjectRes]=await Promise.all([
      supabaseClient.from('school_classes').select('id,client_key').eq('school_id',schoolId),
      supabaseClient.from('subjects').select('id,name').eq('school_id',schoolId),
      supabaseClient.from('teacher_subjects').select('school_id,teacher_id,subject_id').eq('school_id',schoolId).eq('teacher_id',teacherId),
      supabaseClient.from('teacher_class_subjects').select('school_id,class_id,teacher_id,subject_id').eq('school_id',schoolId).eq('teacher_id',teacherId)
    ]);
    const failed=[classesRes,subjectsRes,catalogRes,classSubjectRes].find(r=>r.error);
    if(failed) throw failed.error;

    const classMap=new Map((classesRes.data||[]).map(r=>[r.client_key,r.id]));
    const subjectMap=new Map((subjectsRes.data||[]).map(r=>[r.name,r]));
    const names=[...new Set([
      ...classesForCurrentTeacher().flatMap(c=>classSubjectsForTeacher(c,currentTeacherId())),
      ...state.questionSets.filter(q=>(q.teacherId||currentTeacherId())===currentTeacherId()).map(q=>q.subject)
    ].map(x=>String(x||'').trim()).filter(Boolean))];

    const missing=names.filter(name=>!subjectMap.has(name));
    if(missing.length){
      const rows=missing.map(name=>({school_id:schoolId,name,active:true,created_by:teacherId,updated_at:new Date().toISOString()}));
      const {data,error}=await supabaseClient.from('subjects').insert(rows).select('id,name');
      if(error) throw error;
      (data||[]).forEach(r=>subjectMap.set(r.name,r));
    }

    const desiredSubjectIds=new Set(names.map(name=>subjectMap.get(name)?.id).filter(Boolean));
    const remoteCatalogIds=new Set((catalogRes.data||[]).map(r=>r.subject_id));
    const catalogAdds=[...desiredSubjectIds].filter(id=>!remoteCatalogIds.has(id))
      .map(subject_id=>({school_id:schoolId,teacher_id:teacherId,subject_id}));
    if(catalogAdds.length){
      const {error}=await supabaseClient.from('teacher_subjects').insert(catalogAdds);
      if(error) throw error;
    }
    if(allowDeletes){
      const catalogRemovals=[...remoteCatalogIds].filter(id=>!desiredSubjectIds.has(id));
      if(catalogRemovals.length){
        const {error}=await supabaseClient.from('teacher_subjects')
          .delete().eq('school_id',schoolId).eq('teacher_id',teacherId).in('subject_id',catalogRemovals);
        if(error) throw error;
      }
    }

    const desiredPairs=new Map();
    classesForCurrentTeacher().forEach(c=>{
      const classId=classMap.get(c.id); if(!classId)return;
      classSubjectsForTeacher(c,currentTeacherId()).forEach(name=>{
        const subjectId=subjectMap.get(name)?.id; if(!subjectId)return;
        desiredPairs.set(`${classId}::${subjectId}`,{school_id:schoolId,class_id:classId,teacher_id:teacherId,subject_id:subjectId});
      });
    });

    const remotePairs=new Map((classSubjectRes.data||[]).map(r=>[`${r.class_id}::${r.subject_id}`,r]));
    const classAdds=[...desiredPairs.entries()].filter(([key])=>!remotePairs.has(key)).map(([,row])=>row);
    if(classAdds.length){
      const {error}=await supabaseClient.from('teacher_class_subjects').insert(classAdds);
      if(error) throw error;
    }

    if(allowDeletes){
      const classRemovals=[...remotePairs.entries()].filter(([key])=>!desiredPairs.has(key)).map(([,row])=>row);
      for(const row of classRemovals){
        const {error}=await supabaseClient.from('teacher_class_subjects')
          .delete()
          .eq('school_id',schoolId)
          .eq('teacher_id',teacherId)
          .eq('class_id',row.class_id)
          .eq('subject_id',row.subject_id);
        if(error) throw error;
      }
    }
    return true;
  }

'@
$html = Replace-Between $html $subjectStart $subjectEnd $subjectFn

$oldAssign = @'
      // Přiřazení tříd k učiteli synchronizujeme aditivně.
      // Díky tomu starší zařízení nesmaže třídu, kterou mezitím přiřadil admin nebo jiné zařízení.
      {
        const rows=classesForCurrentTeacher().map(c=>classMap.get(c.id)).filter(Boolean).map(rc=>({school_id:schoolId,class_id:rc.id,teacher_id:teacherId}));
        if(rows.length){
          const {error}=await supabaseClient.from('teacher_class_assignments').upsert(rows,{onConflict:'class_id,teacher_id'});
          if(error) throw error;
        }
      }

'@
$newAssign = @'
      // Přiřazení tříd k učiteli synchronizujeme aditivně.
      // Existující vazby neposíláme znovu přes UPSERT; přidáváme jen chybějící.
      {
        const existingClassIds=new Set((remote.teacherClasses||[])
          .filter(row=>row.teacher_id===teacherId)
          .map(row=>row.class_id));
        const rows=classesForCurrentTeacher()
          .map(c=>classMap.get(c.id))
          .filter(rc=>rc && !existingClassIds.has(rc.id))
          .map(rc=>({school_id:schoolId,class_id:rc.id,teacher_id:teacherId}));
        if(rows.length){
          const {data,error}=await supabaseClient.from('teacher_class_assignments')
            .insert(rows).select('school_id,class_id,teacher_id,created_at');
          if(error) throw error;
          remote.teacherClasses=[...(remote.teacherClasses||[]),...(data||[])];
        }
      }

'@
if (-not $html.Contains($oldAssign)) { throw "Nenalezen blok teacher_class_assignments." }
$html = $html.Replace($oldAssign,$newAssign)

$assignPos = $html.IndexOf($newAssign)
$managePos = $html.IndexOf("      if(can('manageSubjects')){",$assignPos)
$statePos  = $html.IndexOf("      state.ui=state.ui||{};",$managePos)
if ($managePos -lt 0 -or $statePos -lt 0) { throw "Nenalezen blok obecne synchronizace predmetu." }

$newGeneric = @'
      // Background sync je konzervativní: může doplnit chybějící vazby,
      // ale nesmí ze serveru mazat podle potenciálně staré lokální kopie.
      if(can('manageSubjects')){
        await syncCurrentTeacherSubjectsDirect({allowDeletes:false});
      }

'@
$html = $html.Substring(0,$managePos) + $newGeneric + $html.Substring($statePos)

$oldInit = @'
  async function initializeSupabaseSchoolStructure(){
    if(!remoteSchoolStructureEnabled()) return;
    state.ui=state.ui||{};
    const firstForSchool=state.ui.schoolStructureRemoteSchoolId!==state.school.id;
    if(firstForSchool || state.ui.schoolStructureDirty===true) await syncSupabaseSchoolStructure();
    await pullSupabaseSchoolStructure();
  }
'@
$newInit = @'
  async function initializeSupabaseSchoolStructure(){
    if(!remoteSchoolStructureEnabled()) return;
    state.ui=state.ui||{};
    const firstForSchool=state.ui.schoolStructureRemoteSchoolId!==state.school.id;

    // Při prvním otevření školy je Supabase zdroj pravdy.
    // Nejdřív načteme server, aby stará lokální kopie nemohla přepsat školní strukturu.
    if(firstForSchool){
      await pullSupabaseSchoolStructure();
      return;
    }

    // U známé školy můžeme dorovnat lokální přídavky; background sync nic plošně nemaže.
    if(state.ui.schoolStructureDirty===true) await syncSupabaseSchoolStructure();
    await pullSupabaseSchoolStructure();
  }
'@
if (-not $html.Contains($oldInit)) { throw "Nenalezena funkce initializeSupabaseSchoolStructure." }
$html = $html.Replace($oldInit,$newInit)

$version = "  const APP_VERSION = 'ZZ-01 / EXAM SCENE E / BAKED FRAMES';"
if (-not $html.Contains($version)) { throw "Nenalezen APP_VERSION." }
$html = $html.Replace($version,$version + "`r`n  // SYNC V2: server-first bootstrap + differential teacher subject links.")

if ($html.Contains("from('teacher_subjects').delete().eq('school_id',schoolId).eq('teacher_id',teacherId);")) { throw "Stary plosny delete teacher_subjects zustal v kodu." }
if ($html.Contains("from('teacher_class_subjects').delete().eq('school_id',schoolId).eq('teacher_id',teacherId);")) { throw "Stary plosny delete teacher_class_subjects zustal v kodu." }
if ($html.Contains("teacher_class_assignments').upsert(rows")) { throw "Stary upsert teacher_class_assignments zustal v kodu." }

[System.IO.File]::WriteAllText($index,$html,(New-Object System.Text.UTF8Encoding($false)))

Write-Host ""
Write-Host "HOTOVO: ZZ-01 Sync V2 aplikovan." -ForegroundColor Green
Write-Host "Zaloha: index.before_sync_v2.html"
Write-Host ""
Write-Host "Doporuceny commit:"
Write-Host "stabilizace synchronizace skolni struktury"
