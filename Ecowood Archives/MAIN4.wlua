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
		num = 0,
		name = "��� �����",
		zhiv = true,
		vozrast = 0,
		max_vozrast = 40,
		ed_pitaniya = 0,
		kaloriinost = 0,
		sitost = 5,
		cikl_razmn = 30,
		d_razmn = 30,
		deti = 0,
		zrenie = 0,
		statys = 0,
		dom_x = 0,
		dom_y = 0,
		parent_name = '�� ��� ������'
	}
function predok:umiraet_or_not()
	if (self.vozrast >= self.max_vozrast) then
--		umri()
		return
	end
end
-----------------------/����������� ���� ����� �������-----------------------
function printlog(text)
	log1.value = log1.value..text
	return
end

-------------------������� �����-------------------
o_trava = deepcopy(predok)
o_trava.name = "������"
o_trava.typ = "��������"
o_trava.cikl_pitaniya = 10
o_trava.deti = 5

function o_trava:info()
	printlog ('\n'..self.name..'\n')
	printlog ("������� - "..self.vozrast..'\n')
	printlog ("�������� ���� - "..self.max_vozrast - self.vozrast..'\n')
	printlog ("������� - "..self.sitost..'\n')
end

function o_trava:eda()
	if self.sitost < 1 then
		printlog('������� ���� �������.\n')
		printlog('��� � ����� - '..gumus[self.x][self.y]..'\n')
		if gumus[self.x][self.y] > 0 then
			gumus[self.x][self.y] = gumus[self.x][self.y] - self.ed_pitaniya
			self.sitost = self.cikl_pitaniya
			net:setcell(self.x,self.y,gumus[self.x][self.y])
		else
			self:umri()
		end
	end
	net.redraw = 'OLD'
end
--������� ������. ����������.
function o_trava:razmn()
	if (self.d_razmn < 1) and (self.deti > 0) then
		printlog('������� ���� �����������.\n')
		for j = 1, self.deti do
			local x = math.random(self.x-1,self.x+1)
			if x<1 then x = 1 end
			if x>10 then x = 10 end
			local y = math.random(self.y-1,self.y+1)
			if y<1 then y = 1 end
			if y>10 then y = 10 end
			o_sornyachok:create(x,y)
		end
		printlog('���������� ��������: '..self.deti..'\n')
		self.d_razmn = self.cikl_razmn
	end
end

function o_trava:param()
	self.vozrast = self.vozrast + 1
	self.sitost = self.sitost - 1
	self.d_razmn = self.d_razmn - 1
end

--������ � �������� ��������
function o_trava:umri()
	self.zhiv = false
	printlog(self.name..' ����.\n')
	st_dead = st_dead + 1
	gumus[self.x][self.y] = gumus[self.x][self.y]+(self.kaloriinost+self.vozrast+self.sitost)/10
end

--������� ������, ����������.

function o_trava:death()
	if not self.razl then
		if self.vr_razl >= 0 then
			self.vr_razl = self.vr_razl - 1
		else
			gumus[self.x][self.y] = gumus[self.x][self.y] + 2 + self.vozrast
			printlog(self.name..' �����������.\n����� ��� � �����: '..gumus[self.x][self.y]..'\n')
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
		printlog('�������� ��� � ����� - '..gumus[tmp_obj.x][tmp_obj.y]..'\n')
	else
		self:death()
	end
	return
end
------------------/������� �����-------------------

-- �������� ����� ��������� �� ������ ������ �����
o_sornyachok = deepcopy(o_trava)
o_sornyachok_n = 0
o_sornyachok.name = "��������"
o_sornyachok.deti = 2

-------------------������� ��������----------------
function o_sornyachok:create(a,b)
	o_sornyachok_n = o_sornyachok_n + 1
	tmp_obj = deepcopy(o_sornyachok)
	tmp_obj.name = '��������-'..o_sornyachok_n
	tmp_obj.x = a
	tmp_obj.y = b
	life[table.maxn(life)+1] = tmp_obj
	st_alive = st_alive + 1
end
------------------/������� ��������----------------

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
	life = {}
	tmp_obj = {}
	day = 1
	st_alive = 0
	st_dead = 0
	o_sornyachok:create(5,5)
	gumus_r()
	cycle()
end
function cycle()
	if day == nil then
		iup.Message('������','��� �����; �������� "������ ����� ����������".')
		return
	end
	statistics()
	io.write('\n\n------------\n���� '..day..'\n------------\n')
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
	stat = '����: '..day..'\n�����: '..st_alive..'\n�������: '..st_dead..'\n\n'
	st.value = stat
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
for i = 1, 10 do
	net:setcell(i,0,i)
	net:setcell(0,i,i)
end
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
tgui:show()
if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end
