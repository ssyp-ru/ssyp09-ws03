-- ��������: ������ ���������� ����� ������� ���� main.wlua ��� ���
if not did_we_load_the_main_file then
	print("��������, �� �� ������ ��������� ������ MAIN.WLUA")
	os.exit(0)
end
----------------------- ����������� ���� ����� �������-----------------------
predok = {typ = "������", -- ������� �����, �� �������� ������� ��������
		vid = '��������', --��� ����� ��� �����������
		x = 1, -- � ������� ������ ������� ���� ����������
		y = 1,
		sx = 0, -- ������ �������� (���� �� �������� � ���� ����������� � ���� ���)
		sy = 0,
		name = "��� �����", -- ������ ����� ������� ���������� ���. ����� ��� ����������� ��� ��� ���� ����
		zhiv = true, -- ��� �� ������
		vozrast = 0, -- ������� ������� ������� � ������
		max_vozrast = 40, -- ����������� ��������� ������� ������� (� ������)
		ed_pitaniya = 0, -- ������� ����� ������ ����� ��� 100% �������
		kaloriinost = 0, -- ������� ������� � 100% ����� ������� (��� ������� ��� ��� ����� ��� ���������)
		sitost = 0, --
		razl = false, --
		chto_est = '������',
		cikl_razmn = 0, -- � ������. ����� ������� ������ �������� ���������
		d_razmn = 0, -- �������� �� ��� �����������
		deti = 0, -- ������� ������ �������� ����� (��� �����)
		zrenie = 0, -- ������� �������� �� ������� ������ ��� ������
		vr_razl = 2, -- ����������. �������. ������ ������!
		statys = '��������', --
		-- �������: ̸���, ��������, ���� ����, ����� � �����������, ���� �����, ����������
		dom_x = 0, -- ���������� ��� ���� (������. ������ ������������ ���� ����� ��� ��� ��� �����������)
		dom_y = 0,
		parent_name = '�� ��� ������',
		c1 = 255, --����� - �������, �������, �����
		c2 = 0,
		c3 = 0,
		para = nil, --������ �� ����
		death_coef = 1 --����������� (��������� ����� ��� ���)
	}

-- ����� �� ��� ������ �
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
		return 10000 -- ���������� �� ���� 100000+
	end
	return math.sqrt( (self.x - o.x)*(self.x - o.x)+(self.y - o.y)*(self.y - o.y) )
end

function predok:umiraet_or_not()
	if (self.vozrast >= self.max_vozrast or self.sitost <= 0)
		and (self.statys ~= "�����") and (self.statys ~= "����������") then
		self:umri()
		return
	end
	return
end

function predok:getinfo()
	local p = ''
	local t = ''
	if self.para == nil then
		p = '��� ����'
	else
		p = '��� ����: '..self.para.name
	end

	t = '������: '..self.statys.. '\n���: '..self.typ ..
				'\n���: '..self.vid..
				'\n����������: '..self.x..','..self.y.." ������ �������:"..self.sx..','..self.sy..
				'\n���������� ����: '..self.dom_x..','..self.dom_y..
				'\n�������: '..self.vozrast.." �� "..self.max_vozrast..
				'\n�������: '..self.sitost..
				'\n��� ���: '..self.chto_est..
				'\n������ ������: '..self.zrenie..
				'\n'..p

	if self.edagertva == nil then
		t = t..'\n�� ������� ������ �� ��������'
	else
		t = t..'\n��� ���: '..self.edagertva.name.." "..self.edagertva.x..","..self.edagertva.y
	end
	iup.Message(self.name..' - ����������',t)
end


function predok:info()
	printlog (self.name)
	printlog ("������� - "..self.vozrast..'\n')
	printlog ("�������� ���� - "..self.max_vozrast - self.vozrast..'\n')
	printlog ("������� - "..self.sitost..'\n')
	printlog ("������ - "..self.statys..'\n')
end

function predok:death()
	if self.statys == '�����' then
		if self.vr_razl >= 0 then
			self.vr_razl = self.vr_razl - 1
		else
			gumus[self.x][self.y] = math.ceil(gumus[self.x][self.y]+(self.kaloriinost+self.vozrast+self.sitost)/10)*self.death_coef
			printlog(self.name..' ����������.\n����� ��� � �����: '..gumus[self.x][self.y]..'\n')
			self.statys = '����������'
		end
	end
end

-- �������
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
-----------------------����������� ���� ����� �������-----------------------