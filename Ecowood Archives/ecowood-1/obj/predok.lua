-- проверка: запуск произведен через главный файл main.wlua или нет
if not did_we_load_the_main_file then
	print("»звините, но вы должны запускать только MAIN.WLUA")
	os.exit(0)
end
----------------------- ѕрародитель всех живых существ-----------------------
predok = {typ = "предок",
		x = 1,
		y = 1,
		num = 0,
		name = "без имени",
		zhiv = true,
		vozrast = 0,
		max_vozrast = 40,
		ed_pitaniya = 0,
		kaloriinost = 0,
		sitost = 0,
		razl = false,
		chto_est = 'ничего',
		cikl_razmn = 0,
		d_razmn = 0,
		deti = 0,
		zrenie = 0,
		statys = 0,
		dom_x = 0,
		dom_y = 0,
		parent_name = 'јз есм первый'
	}
function predok:umiraet_or_not()
	if (self.vozrast >= self.max_vozrast) then
--		umri()
		return
	end
end
-----------------------/ѕрародитель всех живых существ-----------------------
