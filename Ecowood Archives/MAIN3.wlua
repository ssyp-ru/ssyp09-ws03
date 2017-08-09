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


----------------------- ����������� ���� ����� �������-----------------------
predok = {typ = "������",
		x = 1,
		y = 1,
		name = "��� �����",
		zhiv = true,
		vozrast = 0,
		max_vozrast = 40,
		ed_pitaniya = 0,
		kaloriinost = 0,
		sitost = 1,
		cikl_razmn = 30,
		d_razmn = 0,
		deti = 0,
		zrenie = 0,
		statys = 0,
		dom_x = 0,
		dom_y = 0,
		parent_name = '�� ��� ������'
	}
function predok:umiraet_or_not()
	if (self.vozrast >= self.max_vozrast) then
		umri()
		return
	end
end
-----------------------/����������� ���� ����� �������-----------------------
--function printlog(text)
--	log1.value = log1.value..text
--	return
--end

-- ����� �������
--[[
function create(num,xc,yc,p4,p5,p6,p8,p10,p11)
local m = {}
m = deepcopy(parent_name)
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
]]



-------------------������� �����-------------------
function info(t)
	print ('\n'..t.name..'\n')
	print ("������� - "..t.vozrast..'\n')
	print ("�������� ���� - "..t.max_vozrast - t.vozrast..'\n')
	print ("������� - "..t.sitost..'\n')
end

function eda(t)
	if t.sitost < 1 then
		print('������� ���� �������.\n')
		print('��� � ����� - '..gumus[t.x][t.y]..'\n')
		if gumus[t.x][t.y] > 0 then
			gumus[t.x][t.y] = gumus[t.x][t.y] - t.ed_pitaniya
			t.sitost = t.cikl_pit
			print('�������� ��� � ����� - '..gumus[t.x][t.y]..'\n')
--			net:setcell(t.x,t.y,gumus[t.x][t.y])
		else
			umri()
		end
	end
end
--������� ������. ����������.
function razmn()
	if (self.d_razmn < 1) and (self.deti > 0) then
		print('������� ���� �����������.\n')
		for j = 1, self.deti do
			local x = math.random(self.x-1,self.x+1)
			if x<1 then
			x = 1
			end
			if x>10 then
			x = 10
			end
			local y = math.random(self.y-1,self.y+1)
			if y<1 then
			y = 1
			end
			if y>10 then
			y = 10
			end
--			create_grass(table.maxn(trava)+1,x,y,math.random(45,65),math.random(8,10),1,math.random(21,35),math.random(1,2),math.random(2,4))
			print('���������� ������� � �����������: x-'..x..', y-'..y..'.\n')
		end
		print('���������� ��������: '..t.deti..'\n')
		self.d_razmn = self.cikl_razmn
	end
end

function param()
	self.vozrast = self.vozrast + 1
	self.sitost = self.sitost - 1
	self.d_razmn = self.d_razmn - 1
end

--������ � �������� ��������
function umri()
	self.zhiv = false
	print(self.name..' ����.\n')
	st_dead = st_dead + 1
	gumus[t.x][t.y] = gumus[t.x][t.y]+(self.kaloriinost+self.vozrast+self.sitost)/10
end

--������� ������, ����������.

function death(t)
	if not self.razl then
		if self.vr_razl >= 0 then
			self.vr_razl = self.vr_razl - 1
		else
			gumus[t.x][t.y] = gumus[t.x][t.y] + 2 + self.vozrast
			print(self.name..' �����������.\n����� ��� � �����: '..gumus[t.x][t.y]..'\n')
			self.razl = true
		end
	end
end



------------------/������� �����-------------------
-- �������� ����� ����� �� ������ ������ �����������

o_trava = deepcopy(predok)
o_trava.name = "�����-�� ��������"
o_trava.typ = "��������"
o_trava.cikl_pitaniya = 10
o_trava.deti = 5

-- ������� �����
function o_trava:zhivi(t)
	if self.zhiv then
		self.umiraet_or_not()
		self.info()
		self.eda()
		self.razmn()
		self.param()
	else
		self.death()
	end
	return
end

-- �������� ����� ������� �� ������ ������ �����
o_romashka = deepcopy(o_trava)
o_romashka.name = "� �������"
o_romashka.deti = 8

-- �������� ����� ��� �� ������ ������ �����
o_roza = deepcopy(o_trava)
o_roza.name = "� �������"
o_roza.deti = 5


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
			net:setcell(i,j,gumus[i][j])
		end
	end
	net.resizematrix = "YES"
end
function new()
	math.randomseed(os.time())
	math.random()
	math.random()
	clean_logs()
	trava = {}
	day = 1
	st_alive = 0
	st_dead = 0
	gumus_r()
	local x = math.random(1,10)
	local y = math.random(1,10)
	local my_trava = {}
	my_trava = deepcopy(o_trava)
	o_trava:zhivi(my_trava)
--	io.write('���� ������� � ����������� �-'..x..', y-'..y..'\n')
	cycle()
end
function cycle()
	if day == nil then
		iup.Message('������','��� �����; �������� "������ ����� ����������".')
		return
	end
	statistics()
	io.write('\n\n----------\n���� '..day..'\n----------\n')
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


function log_export()
--[[
local v1 = 0
local v2 = 'grasss_log.txt'
res,logname,filename = iup.GetParam(
			'������� ���� � ����',nil,
			'�������� ����� ��� ��������: %l|�������� ���|����������|\n'..
			'������� ����, ��� � ���������� �����: %s\n',
--			'��������! ������ ������ � ����� ����� ���� ��������.',
			v1,v2)
if (ret == 0) then
  return
end
io.output(filename)
if logname == 0 then
	io.write(log1.value)
else
	io.write(st.value)
end
io.output()]]
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
	io.open(pstring, 'w+')
	if plist == 0 then
		file.write(log1.value)
	else
		file.write(st.value)
	end
	io.close(pstring)
	if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
		iup.MainLoop()
	end
end
net = iup.matrix {numcol=10, numlin=10, numcol_visible=10, numlin_visible=10, widthdef=34, border='no'}
log1 = iup.multiline{value=''; SIZE='300x300'}
st = iup.multiline{value=''; SIZE='100x300'}
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
--			iup.button{title='�������...'; size='70x15', action=log_export},
			iup.button{title='�����'; SIZE='50x15', action=exit},
		},
		net,
		iup.hbox
		{
			log1,
			st
		}
	}
	;title='������ (GUI)'
}

for i = 1, 10 do
	net:setcell(i,0,i)
	net:setcell(0,i,i)
end
tgui:show()
if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end
