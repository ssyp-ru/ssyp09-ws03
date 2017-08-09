-- проверка: запуск произведен через главный файл main.wlua или нет
if not did_we_load_the_main_file then
	print("Извините, но вы должны запускать только MAIN.WLUA")
	os.exit(0)
end
----------------------- Прародитель всех живых существ-----------------------
predok = {typ = "предок", -- Главный класс, из которого создаем потомков
		vid = 'бактерия', --вид нужен для РАЗМНОЖЕНИЯ
		x = 1, -- у каждого живого объекта есть координаты
		y = 1,
		sx = 0, -- вектор движения (план на движение в этом направлении в след ход)
		sy = 0,
		name = "без имени", -- здесть можно хранить уникальное имя. Нужно для определения кто был МАМА ПАПА
		zhiv = true, -- жив ли объект
		vozrast = 0, -- текущий возраст объекта в циклах
		max_vozrast = 40, -- максимально возможный возраст объекта (в циклах)
		ed_pitaniya = 0, -- сколько нужно единиц корма для 100% сытости
		kaloriinost = 0, -- сколько калорий в 100% живом объекте (для расчета его как КОРМА или УДОБРЕНИЯ)
		sitost = 0, --
		razl = false, --
		chto_est = 'ничего',
		cikl_razmn = 0, -- в циклах. Через сколько циклов принести потомство
		d_razmn = 0, -- осталось ДО дня размножения
		deti = 0, -- сколько должно родиться детей (или семян)
		zrenie = 0, -- сколько клеточек от объекта видимо для поиска
		vr_razl = 2, -- Разложение. процесс. убрать отсюда!
		statys = 'Прогулка', --
		-- Статусы: Мёртв, Прогулка, Хочу есть, Готов к размножению, Хочу спать, Разложение
		dom_x = 0, -- координаты его дома (гнезда. Должен возвращаться туда когда сыт или для размножения)
		dom_y = 0,
		parent_name = 'Аз есм первый',
		c1 = 255, --Цвета - красный, зеленый, синий
		c2 = 0,
		c3 = 0,
		para = nil, --Ссылка на пару
		death_coef = 1 --коэффициент (добавлять гумус или нет)
	}

-- Видит ли наш объект О
function predok:vizhu_object(o)
	if o == self then
		return false
	end
	if self.zrenie <= math.sqrt( (self.x - o.x)*(self.x - o.x)+(self.y - o.y)*(self.y - o.y) ) then
		return true
	end
	return false
end

function predok:rasst(o)
if o == self then
		return 10000 -- расстояние до себя 100000+
	end
	return math.sqrt( (self.x - o.x)*(self.x - o.x)+(self.y - o.y)*(self.y - o.y) )
end

function predok:umiraet_or_not()
	if (self.vozrast >= self.max_vozrast or self.sitost <= 0)
		and (self.statys ~= "Мертв") and (self.statys ~= "Разложился") then
		self:umri()
		return
	end
	return
end

function predok:getinfo()
	local p = ''
	local t = ''
	if self.para == nil then
		p = 'Нет пары'
	else
		p = 'Имя пары: '..self.para.name
	end

	t = 'Статус: '..self.statys.. '\nТип: '..self.typ ..
				'\nВид: '..self.vid..
				'\nКоординаты: '..self.x..','..self.y.." Вектор двжения:"..self.sx..','..self.sy..
				'\nКоординаты дома: '..self.dom_x..','..self.dom_y..
				'\nВозраст: '..self.vozrast.." из "..self.max_vozrast..
				'\nСытость: '..self.sitost..
				'\nЧто ест: '..self.chto_est..
				'\nРадиус зрения: '..self.zrenie..
				'\n'..p

	if self.edagertva == nil then
		t = t..'\nНе выбрана жертва на съедение'
	else
		t = t..'\nИмя еды: '..self.edagertva.name.." "..self.edagertva.x..","..self.edagertva.y
	end
	iup.Message(self.name..' - информация',t)
end


function predok:info()
	printlog (self.name)
	printlog ("Возраст - "..self.vozrast..'\n')
	printlog ("Осталось жить - "..self.max_vozrast - self.vozrast..'\n')
	printlog ("Сытость - "..self.sitost..'\n')
	printlog ("Статус - "..self.statys..'\n')
end

function predok:death()
	if self.statys == 'Мертв' then
		if self.vr_razl >= 0 then
			self.vr_razl = self.vr_razl - 1
		else
			gumus[self.x][self.y] = math.ceil(gumus[self.x][self.y]+(self.kaloriinost+self.vozrast+self.sitost)/10)*self.death_coef
			printlog(self.name..' разложился.\nСтало еды в почве: '..gumus[self.x][self.y]..'\n')
			self.statys = 'Разложился'
		end
	end
end

-- Нарисуй
function predok:draw(cnv)
	cnv:Pixel(self.x*10,self.y*10,cd.EncodeColor(self.c1,self.c2,self.c3))
end

--[[function range()
	math.sqrt( (self.x - o.x)*(self.x - o.x)+(self.y - o.y)*(self.y - o.y) )
	return
end

for i = 1,5 do
	m[i].r = range(x,y,m[i].x,m[i].y)
end

for i = 1,5 do
	if m[i].r < min then
		min = m[i].r
	end
end]]
-----------------------Прародитель всех живых существ-----------------------
