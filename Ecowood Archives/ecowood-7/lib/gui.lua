-- проверка: запуск произведен через главный файл main.wlua или нет
if not did_we_load_the_main_file then
	print("Извините, но вы должны запускать только MAIN.WLUA")
	os.exit(0)
end
-------------------GUI-------------------
--- Версия 1.01

g_w = 10 --ширина поля
g_h = 10 --высота поля

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
			gumus[i][j] = math.random(1,5) --Создаём гумус
			grid:setcell(i,j,gumus[i][j])
		end
	end
	grid.resizematrix = "YES"
end
function new()
	iup.SetAttribute(list, 1, nil)
	log1.value = ''
	st.title = ''
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
	o_sornyachok_n = 0
	o_romashka_n = 0
	o_cherv_n = 0
	o_odyvanchik_n = 0
	--o_sornyachok:create(math.random(1,g_h),math.random(1,g_w))
	--o_romashka:create(math.random(1,g_h),math.random(1,g_w))
	o_cherv:create(math.random(1,g_h),math.random(1,g_w))
	--o_odyvanchik:create(math.random(1,g_h),math.random(1,g_w))
end
function cycle()
	if day == nil then
		new()
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
		new()
	else
		for i = 1, 10 do
			cycle()
		end
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
	st.title ='Цикл: '..day-1 ..'\nЖивых: '..st_alive..'\nМертвых: '..st_dead..'\n\n'
end
function clean_logs()
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
for i = 1,g_w  do
	grid:setcell(0,i,i)
end
for i = 1,g_h  do
	grid:setcell(i,0,i)
end
log1 = iup.multiline{value=''; SIZE='300x300'}
st = iup.label{title=''; SIZE='100x30',bgcolor = "255 255 0",alignment = "ACENTER" }
list = iup.list{dropdown="NO"; SIZE = '100x400'}
function list:action(t,i,v)
	for l = 1, table.maxn(life) do
		if life[l].name == t then
			life[l]:getinfo()
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
			grid,
			iup.hbox
			{
				log1,
				st
			}
		},
		list
	}
	;title='Эколес (GUI)',size = "640x400", expand='HORIZONTAL'
}
tgui:show()

--Эти 3 строчки нужно запускать, чтобы приложение WLUA с открытым диалогом не закрылось, а ждало команд
if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end
------------------/GUI-------------------
