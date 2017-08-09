-- проверка: запуск произведен через главный файл main.wlua или нет
if not did_we_load_the_main_file then
	print("Извините, но вы должны запускать только MAIN.WLUA")
	os.exit(0)
end
-------------------Функции одуванчика----------------
o_odyvanchik = deepcopy(o_trava)
o_odyvanchik_n = 0
o_odyvanchik.name = "Одуванчик"
o_odyvanchik.deti = 2
o_odyvanchik.max_vozrast = 32
o_odyvanchik.sitost = 2
o_odyvanchik.cikl_razmn = 10

function o_odyvanchik:create(x,y)
	o_odyvanchik_n = o_odyvanchik_n + 1
	tmp_obj = deepcopy(o_odyvanchik)
	tmp_obj.name = 'Одуванчик-'..o_odyvanchik_n
	tmp_obj.x = x
	tmp_obj.y = y
	tmp_obj.chto_est = 'гумус'
	life[table.maxn(life)+1] = tmp_obj
	st_alive = st_alive + 1
--	grid:setcell(x,y,grid:getcell(x,y)..' '..string.sub(self.name,1,1)..string.sub(tmp_obj.name,string.len(tmp_obj.name),string.len(tmp_obj.name)))
end

function o_odyvanchik:razmn()
	if (self.d_razmn < 1) and (self.deti > 0) then
		--printlog('Сегодня день размножения.\n')
		for j = 1, self.deti do
			local x = math.random(self.x-10,self.x+10)
			if x<1 then x = 1 end
			if x>g_h then x = g_h end
			local y = math.random(self.y-10,self.y+10)
			if y<1 then y = 1 end
			if y>g_w then y = g_w end
			self:create(x,y)
		end
		printlog('Воспроизвёл потомков: '..self.deti..'\n')
		self.d_razmn = self.cikl_razmn
	end

end


------------------/Функции одуванчика----------------

