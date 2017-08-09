-- проверка: запуск произведен через главный файл main.wlua или нет
if not did_we_load_the_main_file then
	print("Извините, но вы должны запускать только MAIN.WLUA")
	os.exit(0)
end
-------------------GUI-------------------
--- Версия 1.01
--[[
g_w = 15 --ширина поля
g_h = 20 --высота поля]]

function refill()
	for i = 1, g_h do
		for j = 1, g_w do
			grid:setcell(i,j,gumus[i][j])
		end
	end
end
function gumus_r()
	gumus = {}
	for i = 1, g_h do
		gumus[i] = {}
	end
	math.random()
	math.random()
	for i = 1, g_h do
		for j = 1, g_w do
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
	o_sornyachok:create(math.random(1,g_h),math.random(1,g_w))
	o_romashka:create(math.random(1,g_h),math.random(1,g_w))
	o_cherv:create(math.random(1,g_h),math.random(1,g_w))
	o_odyvanchik:create(math.random(1,g_h),math.random(1,g_w))
	cycle()
	return
end
function cycle()
	if day == nil then
		iup.Message('Ошибка','Нет травы; выберите "начать новое наблюдение".')
		return
	end

	io.write('\n\n------------\nЦикл '..day..'\n------------\n')
	refill()
	for i = 1, table.maxn(life) do
		tmp_obj = life[i]

		tmp_obj:zhivi()
		grid.redraw = 'ALL'
	end
	day = day + 1
	statistics()
	return
end
function cycle10()
	if day == nil then
		iup.Message('Ошибка','Нет травы; выберите "начать новое наблюдение".')
		return
	else
		for i = 1, 10 do
			cycle()
		end
	end
	--statistics()
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
function startup()
	g_w = 10
	g_h = 10
	res, g_w, g_h = iup.GetParam('Введите ширину и высоту поля:',nil,'Ширина: %i\n'..'Высота: %i\n',g_w,g_h)
	grid = iup.matrix {numcol=g_w, numlin=g_h, numcol_visible=g_w, numlin_visible=g_h, widthdef=60, border='no'}
	for i = 1,g_w  do
		grid:setcell(0,i,i)
	end
	for i = 1,g_h  do
		grid:setcell(i,0,i)
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
end

startup()
--Эти 3 строчки нужно запускать, чтобы приложение WLUA с открытым диалогом не закрылось, а ждало команд
if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end
------------------/GUI-------------------
