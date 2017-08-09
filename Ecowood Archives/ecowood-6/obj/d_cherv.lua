-- проверка: запуск произведен через главный файл main.wlua или нет
if not did_we_load_the_main_file then
	print("Извините, но вы должны запускать только MAIN.WLUA")
	os.exit(0)
end
-------------------Функции дождевого червя----------------
o_d_cherv = deepcopy(o_chervi)
o_d_cherv_n = 0
o_d_cherv.name = "Дождевой червь"
o_d_cherv.typ = 'Дождевой червь'
o_d_cherv.deti = 1

function o_cherv:create(x,y)
	o_cherv_n = o_cherv_n + 1
	tmp_obj = deepcopy(o_cherv)
	tmp_obj.name = 'Червячок-'..o_cherv_n
	tmp_obj.x = x
	tmp_obj.y = y
	life[table.maxn(life)+1] = tmp_obj
	iup.SetAttribute(list, table.maxn(life), tmp_obj.name)
	st_alive = st_alive + 1
end

------------------/Функции дождевого червя----------------
