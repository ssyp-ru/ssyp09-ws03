-- проверка: запуск произведен через главный файл main.wlua или нет
if not did_we_load_the_main_file then
	print("Извините, но вы должны запускать только MAIN.WLUA")
	os.exit(0)
end
-------------------Функции червей-------------------
o_chervi = deepcopy(predok)
o_chervi.name = "Червь"
o_chervi.typ = "червь"
o_chervi.chto_est = 'гумус'
o_chervi.ed_pitaniya = 1
o_chervi.max_vozrast = 36
o_chervi.cikl_pitaniya = 20
o_chervi.sitost = 70
o_chervi.cikl_razmn = 20
o_chervi.d_razmn = o_chervi.cikl_razmn
o_chervi.deti = 2 -- родится 2 ребенка
o_chervi.othodi = 1
o_chervi.cikl_videl = 6 -- через сколько циклов выделяет ГУМУС в почву
o_chervi.d_videl = o_chervi.cikl_videl -- сколько до следующего цикла выделения ГУМУСА
o_chervi.zaderzhka_v_go = 4 -- сколько ждет циклов до следующего шага
o_chervi.d_go = o_chervi.zaderzhka_v_go
o_chervi.statys = 'Прогулка'


function o_chervi:eda()
	if (self.sitost < 10) then
		if self.chto_est == 'гумус' then
			printlog('Еды в почве - '..gumus[self.x][self.y]..'\n')
			if gumus[self.x][self.y] >= self.ed_pitaniya then
				gumus[self.x][self.y] = gumus[self.x][self.y] - self.ed_pitaniya
				self.sitost = 100
				grid:setcell(self.x,self.y,gumus[self.x][self.y]..' '..string.sub(self.name,1,1)..string.sub(self.name,string.len(self.name),string.len(self.name)))
			elseif gumus[self.x][self.y] > 0 then
				gumus[self.x][self.y] = 0
				self.sitost = self.sitost + math.ceil((gumus[self.x][self.y] / self.ed_pitaniya) * 100)
				grid:setcell(self.x,self.y,gumus[self.x][self.y]..' '..string.sub(self.name,1,1)..string.sub(self.name,string.len(self.name),string.len(self.name)))
			else
				self:umri()
			end
		end
	end
	grid.redraw = 'ALL'
end

function o_chervi:razmn()
	if (self.d_razmn < 1) and (self.deti > 0) then
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
		printlog('Воспроизвёл потомков: '..self.deti..'\n')
		self.d_razmn = self.cikl_razmn
	end
end
function o_chervi:param()
	if (self.statys ~= 'Мертв') and (self.statys ~= 'Разложился') then
		self.vozrast = self.vozrast + 1
		self.sitost = self.sitost - 5
		if self.d_razmn > 0 then
			self.d_razmn = self.d_razmn - 1
		end
	end
end
function o_chervi:umri()
	if (self.statys ~= 'Мертв') and (self.statys ~= 'Разложился') then
		self.statys = 'Мертв'
		printlog(self.name..' умер.\n')
		st_dead = st_dead + 1
		st_alive = st_alive - 1
	end
end

function o_chervi:zhivi()
	if (self.statys ~= 'Мертв') and (self.statys ~= 'Разложился') then
		self:umiraet_or_not()
		self:info()
		self:eda()
		self:razmn()
		if statys == 'Поиск пары' then
			self:poisk_pari()
		else
			self:go()
		end
		self:param()
		self:ydobrenie()
		grid:setcell(self.x,self.y,grid:getcell(self.x,self.y)..' '..string.sub(self.name,1,1)..string.sub(self.name,string.len(self.name),string.len(self.name)))
	else
		self:death()
	end
	return
end

-- функ ПЕРЕДВИЖЕНИЯ объекта
function o_chervi:go()
	if (self.statys ~= 'Мертв') and (self.statys ~= 'Разложился') then
		-- уже можно делать ШАг ?
		if (self.d_go <= 1) then -- ДА, можно
			if (self.statys == 'Прогулка') then
				if math.random(100)<50 then
					local sx = math.random(-1,1)
					local sy = math.random(-1,1)

					self.sx = sx
					self.sy = sy
				end
				if self.x + self.sx < 1 or self.x + self.sx > g_h then self.sx = 0 end
				if self.y + self.sy < 1 or self.y + self.sy > g_w then self.sy = 0 end

				self.x = self.x + self.sx
				self.y = self.y + self.sy
				self.d_go = self.zaderzhka_v_go -- шаг сделан, надо обновить кол-во циклов до след ШАГА
			elseif (self.statys == 'Хочу есть') then
				--m_prover_kletki
				local j = math.random(9)
				for i = j, j+9 do
						-- пропустим цикл, т.к. точка ВНЕ поля
					if self.x+m_prover_kletki[i].sx<1 or self.x+m_prover_kletki[i].sx>g_h then
						break
					end
					if self.y+m_prover_kletki[i].sy<1 or self.y+m_prover_kletki[i].sy>g_w then
						break
					end

					if (gumus[self.x+m_prover_kletki[i].sx][self.y+m_prover_kletki[i].sy] >= self.ed_pitaniya) then
						self.sx = m_prover_kletki[i].sx
						self.sy = m_prover_kletki[i].sy

						self.x = self.x + self.sx
						self.y = self.y + self.sy
						self.d_go = self.zaderzhka_v_go -- шаг сделан, надо обновить кол-во циклов до след ШАГА
						break
					end
				end
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
end

function o_chervi:ydobrenie()
	if self.d_videl == 0 then
		gumus[self.x][self.y] = gumus[self.x][self.y] + self.othodi
		d_videl = cikl_videl
	end
end

-- Нарисуй
function o_chervi:draw(cnv)

	--canvas:Box (10, 55, 10, 55)
	canvas:Foreground(cd.EncodeColor(255, 32, 140))
	canvas:Line(self.x*10-5,self.y*10-5, self.x*10+5,self.y*10+5)
	--cnv:Pixel(self.x*10,self.y*10,cd.EncodeColor(255,0,0))
end
------------------/Функции червей-------------------
