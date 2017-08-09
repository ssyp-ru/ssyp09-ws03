-- проверка: запуск произведен через главный файл main.wlua или нет
if not did_we_load_the_main_file then
	print("Извините, но вы должны запускать только MAIN.WLUA")
	os.exit(0)
end
-------------------GUI-------------------
--- Версия 1.02
--[[
g_w = 10 --ширина поля
g_h = 10 --высота поля]]
function refill() -- отрисовать кол-во гумуса в матрице
	for i = 1, g_h do
		for j = 1, g_w do
			grid:setcell(i,j,gumus[i][j])
		end
	end
end

function gumus_r() -- начальное насыщение поля гумусом
	gumus = {}
	for i = 1, g_h do
		gumus[i] = {}
	end
	for i = 1, g_h do
		for j = 1, g_w do
			gumus[i][j] = math.random(2,7) --Создаём гумус
			grid:setcell(i,j,gumus[i][j])
		end
	end
	grid.resizematrix = "YES"
end

function new() -- Начать новое наблюдение
	iup.SetAttribute(list, 1, nil)
	log1.value = ''
	st.title = ''
	math.randomseed(os.time()) -- для инициализации датчика случайных чисел
	math.random() -- тоже
	clean_logs()
	trava = {}
	life = {}
	tmp_obj = {}
	day = 1
	st_alive = 0
	st_dead = 0
	gumus_r()
	o_sornyachok_n = 0
	o_romashka_n = 0
	o_cherv_n = 0
	o_d_cherv_n = 0
	o_odyvanchik_n = 0
	--o_sornyachok:create(math.random(1,g_h),math.random(1,g_w))
	--o_romashka:create(math.random(1,g_h),math.random(1,g_w))
	o_cherv:create(math.random(1,g_h),math.random(1,g_w))
	o_d_cherv:create(math.random(1,g_h),math.random(1,g_w))
	--o_d_cherv:create(math.random(1,g_h),math.random(1,g_w))
	--o_odyvanchik:create(math.random(1,g_h),math.random(1,g_w))
end

function cycle() -- Промоделировать 1 цикл жизни всех объектов
	if day == nil then
		new()
	end
	printlog('\n\n------------\nЦикл '..day..'\n------------\n')
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

function cycle10() -- 10 циклов промоделировать
	if day == nil then
		new()
	else
		for i = 1, 10 do
			cycle()
		end
	end
end

function exit() -- Выход в Виндовз
	os.exit(0)
	return
end

function logging(text) -- запись логов в лог1
	log1.value = log1.value..text
	-- если больше 10 Кб логов, то очистим автоматом
	if string.len(log1.value) > 10000 then
		clean_logs()
	end
	return
end
--io.write = logging -- это убрать потом!

function statistics() -- статистика в отд-м окошке
	st.title ='Цикл: '..day-1 ..'\nЖивых: '..st_alive..'\nМертвых: '..st_dead..'\n\n'
end
function clean_logs() -- очистить логи
	log1.value = ''
	return
end
function log_export()
	f_sv = iup.filedlg{dialogtype = 'SAVE', title = 'Сохранить файл',
						filter = "*.txt", filterinfo = "Текстовые документы(*.txt)"}
	f_sv:popup (iup.ANYWHERE, iup.ANYWHERE)
	if f_sv.status ~= '-1' then
		h_filesv = io.open(f_sv.value, "w")
		h_filesv:write(log1.value)
		h_filesv:close()
	end
end
grid = iup.matrix {numcol=g_w, numlin=g_h, numcol_visible=g_w, numlin_visible=g_h, widthdef=30, border='no'}
function startup()
	g_w = 10
	g_h = 10
	res, g_w, g_h = iup.GetParam('Введите ширину и высоту поля:',nil,'Ширина: %i\n'..'Высота: %i\n',g_w,g_h)
	grid = iup.matrix {numcol=g_w, numlin=g_h, numcol_visible=g_w, numlin_visible=g_h, widthdef=40, border='no'}
	for i = 1,g_w  do
		grid:setcell(0,i,i)
	end
	for i = 1,g_h  do
		grid:setcell(i,0,i)
	end
	log1 = iup.multiline{value=''; SIZE='300x240'}
	st = iup.label{title=''; SIZE='100x30',bgcolor = "255 255 0",alignment = "ACENTER" }
	list = iup.list{dropdown="NO"; SIZE = '100x350'}
	function list:action(t,i,v)
		if v ~= 0 then
			for l = 1, table.maxn(life) do
				if life[l].name == t then
					life[l]:getinfo()
				end
			end
		end
	end

	tgui = iup.dialog
	{
		iup.hbox
		{
			iup.vbox
			{
				iup.hbox
				{
					iup.button{title='Нов. наблюдение'; size='85x15', action=new},
					iup.button{title='След. цикл'; SIZE='60x15', action=cycle},
					iup.button{title='10 циклов'; SIZE='50x15', action=cycle10},
					iup.button{title='Очистить лог'; size='70x15', action=clean_logs},
					iup.button{title='Экспорт лога...'; size='75x15', action=log_export},
					iup.button{title='Выход'; SIZE='50x15', action=exit},
				},
				cnv,
				grid,
				iup.hbox
				{
					log1,
					st
				}
			},
			list
		}
		;title='Эколес (GUI)',size = "640x400"--, expand='HORIZONTAL'
	}
	tgui:show()
end

startup()
--Эти 3 строчки нужно запускать, чтобы приложение WLUA с открытым диалогом не закрылось, а ждало команд
if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end
------------------/GUI-------------------
