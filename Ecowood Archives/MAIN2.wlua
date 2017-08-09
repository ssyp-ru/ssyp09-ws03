require( "iuplua" )
require( "iupluacontrols" )
iup.SetLanguage('ENGLISH')

function deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end


----------------------- Прародитель всех живых существ-----------------------
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
		sitost = 5,
		chto_est = 'ничего',
		cikl_razmn = 30,
		d_razmn = 30,
		deti = 0,
		zrenie = 0,
		statys = 0,
		dom_x = 0,
		dom_y = 0,
		parent_name = 'Аз есм первый'
	}
function predok:umiraet_or_not()
	if (self.vozrast >= self.max_vozrast) then
--		umri()
		return
	end
end
-----------------------/Прародитель всех живых существ-----------------------
function printlog(text)
	log1.value = log1.value..text
	return
end

-------------------Функции травы-------------------
o_trava = deepcopy(predok)
o_trava.name = "травка"
o_trava.typ = "растение"
o_trava.chto_est = 'гумус'
o_trava.cikl_pitaniya = 10
o_trava.deti = 5
o_trava.ed_pitaniya = 1

function o_trava:info()
	printlog ('\n'..self.name..'\n')
	printlog ("Возраст - "..self.vozrast..'\n')
	printlog ("Осталось жить - "..self.max_vozrast - self.vozrast..'\n')
	printlog ("Сытость - "..self.sitost..'\n')
end

function o_trava:eda()
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
--функция Травки. переписать.
function o_trava:razmn()
	if (self.d_razmn < 1) and (self.deti > 0) then
		printlog('Сегодня день размножения.\n')
		for j = 1, self.deti do
			local x = math.random(self.x-1,self.x+1)
			if x<1 then x = 1 end
			if x>10 then x = 10 end
			local y = math.random(self.y-1,self.y+1)
			if y<1 then y = 1 end
			if y>10 then y = 10 end
			self:create(x,y)
		end
		printlog('Воспроизвёл потомков: '..self.deti..'\n')
		self.d_razmn = self.cikl_razmn
	end
end

function o_trava:param()
	self.vozrast = self.vozrast + 1
	self.sitost = self.sitost - 1
	self.d_razmn = self.d_razmn - 1
end

--Смерть с формулой перегноя
function o_trava:umri()
	self.zhiv = false
	printlog(self.name..' умер.\n')
	st_dead = st_dead + 1
	gumus[self.x][self.y] = gumus[self.x][self.y]+(self.kaloriinost+self.vozrast+self.sitost)/10
end

--функция Травки, переписать.
function o_trava:death()
	if not self.razl then
		if self.vr_razl >= 0 then
			self.vr_razl = self.vr_razl - 1
		else
			gumus[self.x][self.y] = gumus[self.x][self.y] + 2 + self.vozrast
			printlog(self.name..' разложилась.\nСтало еды в почве: '..gumus[self.x][self.y]..'\n')
			self.razl = true
		end
	end
end



function o_trava:zhivi()
	if self.zhiv then
		self:umiraet_or_not()
		self:info()
		self:eda()
		self:razmn()
		self:param()
		printlog('Осталось еды в почве - '..gumus[tmp_obj.x][tmp_obj.y]..'\n')
	else
		self:death()
	end
	return
end
------------------/Функции травы-------------------

-- Создадим класс Сорнячков на основе класса ТРАВЫ
o_sornyachok = deepcopy(o_trava)
o_sornyachok_n = 0
o_sornyachok.name = "Сорнячок"
o_sornyachok.deti = 2

-------------------Функции сорнячка----------------
function o_sornyachok:create(x,y)
	o_sornyachok_n = o_sornyachok_n + 1
	tmp_obj = deepcopy(o_sornyachok)
	tmp_obj.name = 'Сорнячок-'..o_sornyachok_n
	tmp_obj.x = x
	tmp_obj.y = y
	tmp_obj.chto_est = 'гумус'
	life[table.maxn(life)+1] = tmp_obj
	st_alive = st_alive + 1
	grid:setcell(x,y,grid:getcell(x,y)..' '..string.sub(self.name,1,1)..string.sub(tmp_obj.name,string.len(tmp_obj.name),string.len(tmp_obj.name)))
end
------------------/Функции сорнячка----------------

-- Создадим класс Ромашек на основе класса ТРАВЫ
o_romashka = deepcopy(o_trava)
o_romashka_n = 0
o_romashka.name = "Ромашка"
o_romashka.deti = 1
-------------------Функции ромашки----------------
function o_romashka:create(x,y)
	o_romashka_n = o_romashka_n + 1
	tmp_obj = deepcopy(o_romashka)
	tmp_obj.name = 'Ромашка-'..o_romashka_n
	tmp_obj.x = x
	tmp_obj.y = y
	tmp_obj.chto_est = 'гумус'
	life[table.maxn(life)+1] = tmp_obj
	st_alive = st_alive + 1
	grid:setcell(x,y,grid:getcell(x,y)..' '..string.sub(self.name,1,1)..string.sub(tmp_obj.name,string.len(tmp_obj.name),string.len(tmp_obj.name)))
end
------------------/Функции ромашки----------------


-------------------GUI-------------------

function gumus_r()
	gumus = {}
	for i = 1, 10 do
		gumus[i] = {}
	end
	math.randomseed(os.time())
	math.random()
	math.random()
	for i = 1, 10 do
		for j = 1, 10 do
			gumus[i][j] = math.random(5,15)
			grid:setcell(i,j,gumus[i][j])
		end
	end
	grid.resizematrix = "YES"
end
function new()
	math.randomseed(os.time())
	math.random()
	math.random()
	clean_logs()
	trava = {}
	life = {}
	tmp_obj = {}
	day = 1
	st_alive = 0
	st_dead = 0
	gumus_r()
	o_sornyachok:create(5,5)
	o_romashka:create(7,8)
	cycle()
end
function cycle()
	if day == nil then
		iup.Message('Ошибка','Нет травы; выберите "начать новое наблюдение".')
		return
	end
	statistics()
	io.write('\n\n------------\nЦикл '..day..'\n------------\n')
	for i = 1, table.maxn(life) do
		tmp_obj = life[i]
		tmp_obj:zhivi()
	end
	day = day + 1

	return
end
function cycle10()
	for c = 1, 10 do
		cycle()
	end
end
function exit()
	os.exit(0)
	return
end
function logging(text)
	log1.value = log1.value..text
	return
end
io.write = logging
function statistics()
	stat = 'Цикл: '..day..'\nЖивых: '..st_alive..'\nМертвых: '..st_dead..'\n\n'
	st.value = stat
end
function clean_logs()
	log1.value = ''
	st.value = ''
	return
end


function log_export()
pstring = "grasss_log.txt"
plist = 0
ret, pstring, plist =
      iup.GetParam("Экспорт",nil,
                  "Введите путь, имя и расширение файла: %s\n"..
                  "Выберите текст для экспорта: %l|Основной лог|Статистика|\n",
                  pstring, plist)
	if (ret == 0) then
		return
	end
	file, err = io.open(pstring,'w')
--	if err == 0 then
		if plist == 0 then
			iup.Message('root',log1.value)
			file:write(log1.value)
		else
			file:write(st.value)
		end
		file:close()
--	end
end
grid = iup.matrix {numcol=10, numlin=10, numcol_visible=10, numlin_visible=10, widthdef=60, border='no'}
for i = 1, 10 do
	grid:setcell(i,0,i)
	grid:setcell(0,i,i)
end

log1 = iup.multiline{value=''; SIZE='300x300'}
st = iup.multiline{value=''; SIZE='100x300'}
tgui = iup.dialog
{
	iup.vbox
	{
		iup.hbox
		{
			iup.button{title='Нов. наблюдение'; size='85x15', action=new},
			iup.button{title='След. цикл'; SIZE='60x15', action=cycle},
			iup.button{title='10 циклов'; SIZE='50x15', action=cycle10},
			iup.button{title='Очистить логи'; size='70x15', action=clean_logs},
			iup.button{title='Экспорт...'; size='60x15', action=log_export},
			iup.button{title='Выход'; SIZE='50x15', action=exit},
		},
		grid,
		iup.hbox
		{
			log1,
			st
		}
	}
	;title='Эколес (GUI)'
}
tgui:show()
if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end
