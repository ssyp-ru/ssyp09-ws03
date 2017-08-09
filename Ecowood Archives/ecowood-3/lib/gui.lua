-- ��������: ������ ���������� ����� ������� ���� main.wlua ��� ���
if not did_we_load_the_main_file then
	print("��������, �� �� ������ ��������� ������ MAIN.WLUA")
	os.exit(0)
	--dofile("..//MAIN.wlua")
end
-------------------GUI-------------------
--- ������ 1.01

g_w = 10 --������ ����
g_h = 10 --������ ����

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
			gumus[i][j] = math.random(10,20) --������ �����
			grid:setcell(i,j,gumus[i][j])
		end
	end
	grid.resizematrix = "YES"
end
function new()
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
	o_sornyachok:create(math.random(1,g_h),math.random(1,g_w))
	o_romashka:create(math.random(1,g_h),math.random(1,g_w))
	o_cherv:create(math.random(1,g_h),math.random(1,g_w))
	o_odyvanchik:create(math.random(1,g_h),math.random(1,g_w))
end
function cycle()
	if day == nil then
		new()
	end

	io.write('\n\n------------\n���� '..day..'\n------------\n')
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
	st.title ='����: '..day-1 ..'\n�����: '..st_alive..'\n�������: '..st_dead..'\n\n'
end
function clean_logs()
	log1.value = ''
	return
end


function log_export()
pstring = "grasss_log.txt"
plist = 0
ret, pstring, plist =
      iup.GetParam("�������",nil,
                  "������� ����, ��� � ���������� �����: %s\n"..
                  "�������� ����� ��� ��������: %l|�������� ���|����������|\n",
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
grid = iup.matrix {numcol=g_w, numlin=g_h, numcol_visible=g_w, numlin_visible=g_h, widthdef=30, border='no'}
for i = 1,g_w  do
	grid:setcell(0,i,i)
end
for i = 1,g_h  do
	grid:setcell(i,0,i)
end
log1 = iup.multiline{value=''; SIZE='300x130'}
st = iup.label{title=''; SIZE='100x30',bgcolor = "255 255 0",alignment = "ACENTER" }
list = iup.list{dropdown="NO"; SIZE = '100x400'}
--list.appenditem = "eee"

tgui = iup.dialog
{
	iup.hbox
	{
		iup.vbox
		{
			iup.hbox
			{
				iup.button{title='���. ����������'; size='85x15', action=new},
				iup.button{title='����. ����'; SIZE='60x15', action=cycle},
				iup.button{title='10 ������'; SIZE='50x15', action=cycle10},
				iup.button{title='�������� ����'; size='70x15', action=clean_logs},
				iup.button{title='�������...'; size='60x15', action=log_export},
				iup.button{title='�����'; SIZE='50x15', action=exit},
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
	;title='������ (GUI)',size = "640x400"
}
tgui:show()

--��� 3 ������� ����� ���������, ����� ���������� WLUA � �������� �������� �� ���������, � ����� ������
if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end
------------------/GUI-------------------
