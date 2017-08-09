-- ��������: ������ ���������� ����� ������� ���� main.wlua ��� ���
if not did_we_load_the_main_file then
	print("��������, �� �� ������ ��������� ������ MAIN.WLUA")
	os.exit(0)
end
-------------------GUI-------------------
--- ������ 1.02
function refill() -- ���������� ���-�� ������ � �������
	if mode == 0 then
		for i = 1, g_h do
			for j = 1, g_w do
				grid:setcell(i,j,gumus[i][j])
			end
		end
	end
end

function gumus_r() -- ��������� ��������� ���� �������
	gumus = {}
	for i = 1, g_h do
		gumus[i] = {}
	end
	for i = 1, g_h do
		for j = 1, g_w do
			gumus[i][j] = math.random(2,7) --������ �����
			if mode == 0 then grid:setcell(i,j,gumus[i][j]) end
		end
	end
	if mode == 0 then grid.resizematrix = "YES" end
end

function new() -- ������ ����� ����������
	iup.SetAttribute(list, 1, nil)
	log1.value = ''
	st.title = ''
	math.randomseed(os.time()) -- ��� ������������� ������� ��������� �����
	math.random() -- ����
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
	o_datel_n = 0

	--o_sornyachok:create(math.random(1,g_h),math.random(1,g_w))
	--o_romashka:create(math.random(1,g_h),math.random(1,g_w))
	--o_cherv:create(10,10,math.random(32,223),math.random(32,223),math.random(32,223))
	o_d_cherv:create(math.random(1,g_h),math.random(1,g_w),math.random(32,223),math.random(32,223),math.random(32,223))
	o_d_cherv:create(math.random(1,g_h),math.random(1,g_w),math.random(32,223),math.random(32,223),math.random(32,223))
	o_datel:create(math.random(1,g_h),math.random(1,g_w),math.random(32,223),math.random(32,223),math.random(32,223))
	--o_d_cherv:create(math.random(1,g_h),math.random(1,g_w))
	--o_odyvanchik:create(math.random(1,g_h),math.random(1,g_w))
end

function cycle() -- ��������������� 1 ���� ����� ���� ��������
	if day == nil then
		new()
	end
	printlog('\n\n------------\n���� '..day..'\n------------\n')
	refill()
	for i = 1, table.maxn(life) do
		life[i]:zhivi()
	end
	if mode == 0 then grid.redraw = 'ALL' end
	day = day + 1
	statistics()
	if mode == 1 then cnv:action() end
	return
end
function cycle10() -- 10 ������ ���������������
	clean_logs()
	if day == nil then
		new()
	else
		for i = 1, 10 do
			cycle()
		end
	end
end

function exit() -- ����� � �������
	os.exit(0)
	return
end

function logging(text) -- ������ ����� � ���1
	log1.value = log1.value..text
	-- ���� ������ 10 �� �����, �� ������� ���������
	if string.len(log1.value) > 10000 then
		clean_logs()
	end
	return
end
function statistics() -- ���������� � ���-� ������
	st.title ='����: '..day-1 ..'\n�����: '..st_alive..'\n�������: '..st_dead..'\n\n'
end
function clean_logs() -- �������� ����
	log1.value = ''
	return
end
function log_export()
	f_sv = iup.filedlg{dialogtype = 'SAVE', title = '��������� ����',
						filter = "*.txt", filterinfo = "��������� ���������(*.txt)"}
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
	mode = 1
	res, g_w, g_h, mode = iup.GetParam('������� ������ � ������ ����:',nil,'������: %i\n'..'������: %i\n'..'����������: %l|�������|�����|\n',g_w,g_h,mode)
	if mode == 0 then
		grid = iup.matrix {numcol=g_w, numlin=g_h, numcol_visible=g_w, numlin_visible=g_h, widthdef=40, border='no'}
		for i = 1,g_w  do
			grid:setcell(0,i,i)
		end
		for i = 1,g_h  do
			grid:setcell(i,0,i)
		end
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
	if mode == 0 then
		mode_ = grid
	else
		mode_ = cnv
	end
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
					iup.button{title='�������� ���'; size='70x15', action=clean_logs},
					iup.button{title='������� ����...'; size='75x15', action=log_export},
					iup.button{title='�����'; SIZE='50x15', action=exit},
				},
				mode_,
				iup.hbox
				{
					log1,
					st
				}
			},
			list
		}
		;title='������ (GUI)',size = "640x400"--, expand='HORIZONTAL'
	}
	tgui:show()
end

startup()
--��� 3 ������� ����� ���������, ����� ���������� WLUA � �������� �������� �� ���������, � ����� ������
if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end
------------------/GUI-------------------
