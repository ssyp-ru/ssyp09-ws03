-- проверка: запуск произведен через главный файл main.wlua или нет
if not did_we_load_the_main_file then
	print("Извините, но вы должны запускать только MAIN.WLUA")
	os.exit(0)
end
-------------------Функции дождевого червя----------------
o_d_cherv = deepcopy(o_chervi)
o_d_cherv_n = 0
o_d_cherv.name = 'Дождевой червь'
o_d_cherv.vid = 'дождевой червь'
o_d_cherv.deti = 1

function o_d_cherv:create(x,y)
	o_d_cherv_n = o_d_cherv_n + 1
	tmp_obj = deepcopy(o_d_cherv)
	tmp_obj.name = 'Дождевой червь-'..o_d_cherv_n
	tmp_obj.typ = 'Дождевой червь'
	tmp_obj.x = x
	tmp_obj.y = y
	life[table.maxn(life)+1] = tmp_obj
	iup.SetAttribute(list, table.maxn(life), tmp_obj.name)
	st_alive = st_alive + 1
end
function o_d_cherv:razmn()
	if (self.d_razmn < 1) and (self.deti > 0) then
		self.status = 'Размножение'
		for i = 1, table.maxn(life) do
			if (life[i].vid==self.vid) and (life[i].name~=self.name) and (life[i].x==self.x) and (life[i].y==self.y) then
				printlog('Сегодня день размножения.\n')
				for j = 1, self.deti do
					local x = math.random(self.x-1,self.x+1)
					if x<1 then x = 1 end
					if x>g_h then x = g_h end
					local y = math.random(self.y-1,self.y+1)
					if y<1 then y = 1 end
					if y>g_w then y = g_w end
					self:create(x,y)
				end
--				printlog('Воспроизвёл потомков: '..self.deti..'\n')
				self.d_razmn = self.cikl_razmn
			end
		end
	end
end
function o_d_cherv:poisk_pari()
	local min = 20000
	for i = 1,table.maxn(life) do
		if life[i].typ == self.typ then
		local b = rasst(life[i])
			if b < min then
				min = b
				local c = i
			end
		end
	end
	if min == 20000 then
		self.statys = 'Прогулка'
		return
	end
	local d = self:vizhu_object(life[i])
	if d == false then
		self.statys = 'Прогулка'
		return
	elseif d == true then
		self:go_to_obj(life[i].x,life[i].y)
	end
	return
end

function o_d_cherv:go_to_obj(x1,y1)
	if (self.statys ~= 'Мертв') and (self.statys ~= 'Разложился') then
		-- уже можно делать ШАг ?
		if (self.d_go <= 1) then -- ДА, можно
			if (self.statys == 'Поиск пары') then
				if self.x < x1 then
					self.x = self.x+1
				elseif self.x > x1 then
					self.x = self.x - 1
				end
				if self.y < y1 then
					self.y = self.y+1
				elseif self.y > y1 then
					self.y = self.y - 1
				end
				self.d_go = self.zaderzhka_v_go -- шаг сделан, надо обновить кол-во циклов до след ШАГА
				elseif (self.statys == 'Хочу есть') then
				for x = self.x-1,self.x+1 do
					for y = self.y-1,self.y+1 do

						if x<1 or x>g_h or y<1 or y>g_w then
							break -- пропустим циксл, т.к. точка ВНЕ поля
						end

						if (gumus[x][y] >= self.ed_pitaniya) then
							self.x = x
							self.y = y
							self.d_go = self.zaderzhka_v_go -- шаг сделан, надо обновить кол-во циклов до след ШАГА
							break
						end
					end
				end
			end
		else -- НЕТ, нельзя еще шагать
			self.d_go = self.d_go - 1
			if (self.sitost <= self.cikl_pitaniya - (self.cikl_pitaniya/2)) then
				self.statys = 'Хочу есть'
			end
			if (self.sitost > self.cikl_pitaniya - (self.cikl_pitaniya/2)) then
				self.statys = 'Поиск пары'
			end
		end
	end
end

--[[function o_d_cherv:go()
	if (self.statys ~= 'Мертв') and (self.statys ~= 'Разложился') then
		-- уже можно делать ШАг ?
		if (self.d_go <= 1) then -- ДА, можно
			if (self.statys == 'Прогулка') then
				local x = math.random(self.x-1,self.x+1)
				if x<1 then x = 1 end
				if x>g_h then x = g_w end
				local y = math.random(self.y-1,self.y+1)
				if y<1 then y = 1 end
				if y>g_w then y = g_w end
				self.x = x
				self.y = y
				self.d_go = self.zaderzhka_v_go -- шаг сделан, надо обновить кол-во циклов до след ШАГА
			elseif (self.statys == 'Хочу есть') then
				for x = self.x-1,self.x+1 do
					for y = self.y-1,self.y+1 do

						if x<1 or x>g_h or y<1 or y>g_w then
							break -- пропустим циксл, т.к. точка ВНЕ поля
						end

						if (gumus[x][y] >= self.ed_pitaniya) then
							self.x = x
							self.y = y
							self.d_go = self.zaderzhka_v_go -- шаг сделан, надо обновить кол-во циклов до след ШАГА
							break
						end
					end
				end
			elseif self.statys == 'Поиск пары' then
				self:poisk_pari()
			else -- если не те статусы, что были выше, то делаем прогулку
				self.statys = 'Прогулка' -- на след ходу начнет гулять
			end
		else -- НЕТ, нельзя еще шагать
			self.d_go = self.d_go - 1
			if (self.sitost <= self.cikl_pitaniya - (self.cikl_pitaniya/2)) then
				self.statys = 'Хочу есть'
			end
			if (self.sitost > self.cikl_pitaniya - (self.cikl_pitaniya/2)) then
				self.statys = 'Прогулка'
			end
		end
	end
end]]
------------------/Функции дождевого червя----------------
