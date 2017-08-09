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
o_chervi.cikl_pitaniya = 12
o_chervi.deti = 2
o_chervi.ed_pitaniya = 3
o_chervi.max_vozrast = 36
o_chervi.sitost = 2
o_chervi.cikl_razmn = 20
o_chervi.othodi = 1
o_chervi.cikl_videl = 6
o_chervi.d_videl = 8
o_chervi.zaderzhka_v_go = 4
o_chervi.d_go = 4
o_chervi.d_razmn = o_chervi.cikl_razmn

function o_chervi:info()
	printlog ('\n'..self.name..'\n')
	printlog ("Возраст - "..self.vozrast..'\n')
	printlog ("Осталось жить - "..self.max_vozrast - self.vozrast..'\n')
	printlog ("Сытость - "..self.sitost..'\n')
end

function o_chervi:eda()
	if self.sitost < 1 then
		printlog('Сегодня день питания.\n')
		if self.chto_est == 'гумус' then
			printlog('Еды в почве - '..gumus[self.x][self.y]..'\n')
			if gumus[self.x][self.y] > 0 then
				gumus[self.x][self.y] = gumus[self.x][self.y] - self.ed_pitaniya
				self.sitost = self.cikl_pitaniya
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
	self.vozrast = self.vozrast + 1
	self.sitost = self.sitost - 1
	self.d_razmn = self.d_razmn - 1
end

function o_chervi:umri()
	self.zhiv = false
	printlog(self.name..' умер.\n')
	st_dead = st_dead + 1
	gumus[self.x][self.y] = gumus[self.x][self.y]+(self.kaloriinost+self.vozrast+self.sitost)/10
end

function o_chervi:death()
	if not self.razl then
		if self.vr_razl >= 0 then
			self.vr_razl = self.vr_razl - 1
		else
			gumus[self.x][self.y] = gumus[self.x][self.y] + 2 + self.vozrast
			printlog(self.name..' разложился.\nСтало еды в почве: '..gumus[self.x][self.y]..'\n')
			self.razl = true
		end
	end
end



function o_chervi:zhivi()
	if self.zhiv then
		--refill()
		self:umiraet_or_not()
		self:info()
		self:eda()
		self:razmn()
		self:go()
		self:param()
		self:ydobrenie()
		grid:setcell(self.x,self.y,grid:getcell(self.x,self.y)..' '..string.sub(self.name,1,1)..string.sub(self.name,string.len(self.name),string.len(self.name)))
	else
		self:death()
	end
	return
end
function o_chervi:go()
	if self.d_go <= 1 then
		local x = math.random(self.x-1,self.x+1)
		if x<1 then x = 1 end
		if x>g_h then x = g_w end
		local y = math.random(self.y-1,self.y+1)
		if y<1 then y = 1 end
		if y>g_w then y = g_w end
		self.x = x
		self.y = y
		self.d_go = self.zaderzhka_v_go
	end
	self.d_go = self.d_go - 1
end

function o_chervi:ydobrenie()
	if self.d_videl == 0 then
		gumus[self.x][self.y] = gumus[self.x][self.y] + self.othodi
		d_videl = cikl_videl
	end
end
------------------/Функции червей-------------------

