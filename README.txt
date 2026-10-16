ZZ-01 – kompaktní žákovské testy + oprava hodnocení učitelů

Frontend:
- otázky jsou kompaktní řádky
- odpovědi A–D jsou vedle sebe na desktopu, 2x2 na menších displejích
- výrazné zvýraznění zvolené odpovědi
- odevzdání je povoleno až po vyplnění všech otázek
- před finálním odevzdáním se zobrazí potvrzovací dialog
- průběžně se ukazuje počet zodpovězených otázek

Backend:
- v Supabase byla opravena chyba "column reference available_points is ambiguous"
  ve funkci student_cast_teacher_feedback
- stejným způsobem byla preventivně opravena i funkce student_invest_game_score
