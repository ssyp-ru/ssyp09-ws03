-- ��������: ������ ���������� ����� ������� ���� main.wlua ��� ���
if not did_we_load_the_main_file then
	print("��������, �� �� ������ ��������� ������ MAIN.WLUA")
	os.exit(0)
end
----------------------- ����������� ���� ����� �������-----------------------
predok = {typ = "������", -- ������� �����, �� �������� ������� ��������
		x = 1, -- � ������� ������ ������� ���� ����������
		y = 1,
		--num = 0,
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
		statys = '̸���', --
		-- �������: ̸���, ��������, ���� ����, ����� � �����������, ���� �����, ����������
		dom_x = 0, -- ���������� ��� ���� (������. ������ ������������ ���� ����� ��� ��� ��� �����������)
		dom_y = 0,
		parent_name = '�� ��� ������',
	}

-- ����� �� ��� ������ �
function predok:vizhu_object(o)
	if self.zrenie <= math.sqrt( (self.x - o.x)*(self.x - o.x)+(self.y - o.y)*(self.y - o.y) ) then
		return true
	end
	return false
end

function predok:umiraet_or_not()
	if (self.vozrast >= self.max_vozrast) then
		self:umri()
		return
	end
end

function predok:getinfo()
	if self.zhiv then
		zh = '���'
	else
		zh = '�����'
	end
	iup.Message(self.name..' - ����������',zh..
				'\n����������: '..self.x..','..self.y..
				'\n������� - '..self.vozrast..
				'\n������� - '..self.sitost..
				'\n��� '..self.chto_est..
				'\n������������ ������ '..self.cikl_razmn..' ������'..
				'\n������ ������ - '..self.zrenie
				)
end
-----------------------/����������� ���� ����� �������-----------------------
