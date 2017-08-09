require( "iuplua" )
require( "iupluacontrols" )

------------------program------------------

function create_grass(num,xc,yc,p4,p5,p6,p8,p10,p11)
st_alive = st_alive + 1
trava[num] = {}
trava[num].x = xc
trava[num].y = yc
trava[num].name = '�����-'..num
trava[num].zhiv = true
trava[num].vozrast = 0
trava[num].max_vozrast = p4
trava[num].cikl_pit = p5
trava[num].ed_pit = p6
trava[num].sitost = 1
trava[num].cikl_razmn = p8
trava[num].d_razmn = p8
trava[num].sem = p10
trava[num].vr_razl = p11
trava[num].razl = false
end

function check_die(t)
	if t.vozrast >= t.max_vozrast then
		die(t)
		return
	end
end

function info(t)
	io.write ('\n'..t.name..'\n')
	io.write ("������� - "..t.vozrast..'\n')
	io.write ("�������� ���� - "..t.max_vozrast - t.vozrast..'\n')
	io.write ("������� - "..t.sitost..'\n')
end

function eda(t)
	if t.sitost < 1 then
		io.write('������� ���� �������.\n')
		io.write('��� � ����� - '..gumus[t.x][t.y]..'\n')
		if gumus[t.x][t.y] > 0 then
			gumus[t.x][t.y] = gumus[t.x][t.y] - t.ed_pit
			t.sitost = t.cikl_pit
			io.write('�������� ��� � ����� - '..gumus[t.x][t.y]..'\n')
			net:setcell(t.x,t.y,gumus[t.x][t.y])
		else
			die(t)
		end
	end
end

function razmn(t)
	if (t.d_razmn < 1) and (t.sem > 0) then
		io.write('������� ���� �����������.\n')
		for j = 1, t.sem do
			create_grass(table.maxn(trava)+1,5,5,math.random(45,65),math.random(8,10),1,math.random(21,35),math.random(1,2),math.random(2,4))
		end
		io.write('���������� ��������: '..t.sem..'\n')
		t.d_razmn = t.cikl_razmn
	end
end

function param(t)
	t.vozrast = t.vozrast + 1
	t.sitost = t.sitost - 1
	t.d_razmn = t.d_razmn - 1
end

function die(t)
	t.zhiv = false
	io.write(t.name..' ������.\n')
	st_dead = st_dead + 1
end
function death(t)
	if not t.razl then
		if t.vr_razl >= 0 then
			t.vr_razl = t.vr_razl - 1
		else
			gumus[t.x][t.y] = gumus[t.x][t.y] + 2 + t.vozrast
			io.write(t.name..' �����������.\n����� ��� � �����: '..gumus[t.x][t.y]..'\n')
			t.razl = true
		end
	end
end

function trava_zhivi(t)
	if t.zhiv then
		info(t)
		eda(t)
		razmn(t)
		param(t)
		check_die(t)
	else
		death(t)
	end
	return
end



-------------GUI-------------

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
			net:setcell(i,j,gumus[i][j])
		end
	end
	net.resizematrix = "YES"
end
function new()
	clean_logs()
	trava = {}
	eda_v_poch = 15
	day = 1
	st_alive = 0
	st_dead = 0
	gumus_r()
	create_grass(1,5,5,65,9,1,28,2,3)
	cycle()
end
function cycle()
	if day == nil then
		iup.Message('������','��� �����; �������� "������ ����� ����������".')
		return
	end
	statistics()
	io.write('\n\n--------\n���� '..day..'\n--------\n')
	for k = 1, table.maxn(trava) do
		trava_zhivi(trava[k])
	end
	day = day + 1
	net.redraw = 'OLD'
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
	stat = '����: '..day..'\n�����: '..st_alive..'\n�������: '..st_dead..'\n\n'
	st.value = st.value..stat
end
function clean_logs()
	log1.value = ''
	st.value = ''
	return
end

net = iup.matrix {numcol=10, numlin=10, numcol_visible=10, numlin_visible=10, widthdef=34, border='no'}
log1 = iup.multiline{value=''; SIZE='300x150'}
st = iup.multiline{value=''; SIZE='100x150'}
tgui = iup.dialog
{
	iup.vbox
	{
		iup.hbox
		{
			iup.button{title='���. ����������'; size='85x15', action=new},
			iup.button{title='����. ����'; SIZE='60x15', action=cycle},
			iup.button{title='10 ������'; SIZE='50x15', action=cycle10},
			iup.button{title='�������� ����'; size='70x15', action=clean_logs},
			iup.button{title='�����'; SIZE='50x15', action=exit},
		},
		net,
		iup.hbox
		{
			log1,
			st
		}
	}
	;title='����� ����� (GUI)'
}


for i = 1, 10 do
	net:setcell(i,0,i)
	net:setcell(0,i,i)
end
tgui:show()
if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end
