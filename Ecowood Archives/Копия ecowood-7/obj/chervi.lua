-- ��������: ������ ���������� ����� ������� ���� main.wlua ��� ���
if not did_we_load_the_main_file then
	print("��������, �� �� ������ ��������� ������ MAIN.WLUA")
	os.exit(0)
end
-------------------������� ������-------------------
o_chervi = deepcopy(predok)
o_chervi.name = "�����"
o_chervi.typ = "�����"
o_chervi.chto_est = '�����'
o_chervi.ed_pitaniya = 3
o_chervi.max_vozrast = 36
o_chervi.cikl_pitaniya = 20
o_chervi.sitost = 70
o_chervi.cikl_razmn = 20
o_chervi.d_razmn = o_chervi.cikl_razmn
o_chervi.deti = 2 -- ������� 2 �������
o_chervi.othodi = 1
o_chervi.cikl_videl = 6 -- ����� ������� ������ �������� ����� � �����
o_chervi.d_videl = o_chervi.cikl_videl -- ������� �� ���������� ����� ��������� ������
o_chervi.zaderzhka_v_go = 4 -- ������� ���� ������ �� ���������� ����
o_chervi.d_go = o_chervi.zaderzhka_v_go

o_chervi.statys = '��������'
function o_chervi:info()
	printlog ('\n'..self.name..'\n')
	printlog ("������� - "..self.vozrast..'\n')
	printlog ("�������� ���� - "..self.max_vozrast - self.vozrast..'\n')
	printlog ("������� - "..self.sitost..'\n')
	printlog ("������ - "..self.statys..'\n')
end
function o_chervi:eda()
	if (self.sitost < 10) then
		if self.chto_est == '�����' then
			printlog('��� � ����� - '..gumus[self.x][self.y]..'\n')
			if gumus[self.x][self.y] >= self.ed_pitaniya then
				gumus[self.x][self.y] = gumus[self.x][self.y] - self.ed_pitaniya
				self.sitost = 100
				grid:setcell(self.x,self.y,gumus[self.x][self.y]..' '..string.sub(self.name,1,1)..string.sub(self.name,string.len(self.name),string.len(self.name)))
			elseif gumus[self.x][self.y] > 0 then
				gumus[self.x][self.y] = 0
				self.sitost = self.sitost + math.ceil((gumus[self.x][self.y] / self.ed_pitaniya) * 100)
				grid:setcell(self.x,self.y,gumus[self.x][self.y]..' '..string.sub(self.name,1,1)..string.sub(self.name,string.len(self.name),string.len(self.name)))
			else
				self:umri()
			end
		end
	end
	grid.redraw = 'ALL'
end
function o_chervi:razmn()
	if (self.d_razmn < 1) and (self.deti > 0) then
		printlog('������� ���� �����������.\n')
		for j = 1, self.deti do
			local x = math.random(self.x-1,self.x+1)
			if x<1 then x = 1 end
			if x>g_h then x = g_h end
			local y = math.random(self.y-1,self.y+1)
			if y<1 then y = 1 end
			if y>g_w then y = g_w end
			self:create(x,y)
		end
		printlog('���������� ��������: '..self.deti..'\n')
		self.d_razmn = self.cikl_razmn
	end
end
function o_chervi:param()
	if (self.statys ~= '�����') and (self.statys ~= '����������') then
		self.vozrast = self.vozrast + 1
		self.sitost = self.sitost - 5
		self.d_razmn = self.d_razmn - 1
	end
end
function o_chervi:umri()
	if (self.statys ~= '�����') and (self.statys ~= '����������') then
		self.statys = '�����'
		printlog(self.name..' ����.\n')
		st_dead = st_dead + 1
		st_alive = st_alive - 1
	end
end
function o_chervi:death()
	if self.statys ~= '����������' then
		if self.vr_razl >= 0 then
			self.vr_razl = self.vr_razl - 1
		else
			gumus[self.x][self.y] = math.ceil(gumus[self.x][self.y]+(self.kaloriinost+self.vozrast+self.sitost)/10)
			printlog(self.name..' ����������.\n����� ��� � �����: '..gumus[self.x][self.y]..'\n')
			self.statys = '����������'
		end
	end
end
function o_chervi:zhivi()
	if (self.statys ~= '�����') and (self.statys ~= '����������') then
		self:umiraet_or_not()
		self:info()
		self:eda()
		self:razmn()
		self:go()
		self:param()
		self:ydobrenie()
		grid:setcell(self.x,self.y,grid:getcell(self.x,self.y)..' '..string.sub(self.name,1,1)..string.sub(self.name,string.len(self.name),string.len(self.name)))
	else
		self:death()
	end
	return
end

-- ���� ������������ �������
function o_chervi:go()
	if (self.statys ~= '�����') and (self.statys ~= '����������') then
		-- ��� ����� ������ ��� ?
		if (self.d_go <= 1) then -- ��, �����
			if (self.statys == '��������') then
				local x = math.random(self.x-1,self.x+1)
				if x<1 then x = 1 end
				if x>g_h then x = g_w end
				local y = math.random(self.y-1,self.y+1)
				if y<1 then y = 1 end
				if y>g_w then y = g_w end
				self.x = x
				self.y = y
				self.d_go = self.zaderzhka_v_go -- ��� ������, ���� �������� ���-�� ������ �� ���� ����
			elseif (self.statys == '���� ����') then
				for x = self.x-1,self.x+1 do
					for y = self.y-1,self.y+1 do

						if x<1 or x>g_h or y<1 or y>g_w then
							break -- ��������� ����, �.�. ����� ��� ����
						end

						if (gumus[x][y] >= self.ed_pitaniya) then
							self.x = x
							self.y = y
							self.d_go = self.zaderzhka_v_go -- ��� ������, ���� �������� ���-�� ������ �� ���� ����
							break
						end
					end
				end
			else -- ���� �� �� �������, ��� ���� ����, �� ������ ��������
				self.statys = '��������' -- �� ���� ���� ������ ������
			end
		else -- ���, ������ ��� ������
			self.d_go = self.d_go - 1
			if (self.sitost <= self.cikl_pitaniya - (self.cikl_pitaniya/2)) then
				self.statys = '���� ����'
			end
			if (self.sitost > self.cikl_pitaniya - (self.cikl_pitaniya/2)) then
				self.statys = '��������'
			end
		end
	end
end
function o_chervi:ydobrenie()
	if self.d_videl == 0 then
		gumus[self.x][self.y] = gumus[self.x][self.y] + self.othodi
		d_videl = cikl_videl
	end
end
------------------/������� ������-------------------
