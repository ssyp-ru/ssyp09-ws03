-- ��������: ������ ���������� ����� ������� ���� main.wlua ��� ���
if not did_we_load_the_main_file then
	print("��������, �� �� ������ ��������� ������ MAIN.WLUA")
	os.exit(0)
end
-------------------������� �����-------------------
o_trava = deepcopy(predok)
o_trava.name = "������"
o_trava.typ = "��������"
o_trava.chto_est = '�����'
o_trava.cikl_pitaniya = 12
o_trava.deti = 5
o_trava.ed_pitaniya = 1
o_trava.max_vozrast = 72
o_trava.sitost = 2
o_trava.cikl_razmn = 35
o_trava.d_razmn = o_trava.cikl_razmn

function o_trava:info()
	printlog ('\n'..self.name..'\n')
	printlog ("������� - "..self.vozrast..'\n')
	printlog ("�������� ���� - "..self.max_vozrast - self.vozrast..'\n')
	printlog ("������� - "..self.sitost..'\n')
end

function o_trava:eda()
	if self.sitost < 1 then
		printlog('������� ���� �������.\n')
		if self.chto_est == '�����' then
			printlog('��� � ����� - '..gumus[self.x][self.y]..'\n')
			if gumus[self.x][self.y] > 0 then
				gumus[self.x][self.y] = gumus[self.x][self.y] - self.ed_pitaniya
				self.sitost = self.cikl_pitaniya
			else
--[[			for i = self.x - 1, self.x + 1 do
					for j = self.y - 1, self.y + 1 do
						gumus[i][j] = gumus[i][j] - self.ed_pitaniya
						self.sitost = self.cikl_pitaniya
					end
				end
]]				self:umri()
			end
		end
	end
	grid.redraw = 'ALL'
	return
end
function o_trava:razmn()
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

function o_trava:param()
	self.vozrast = self.vozrast + 1
	self.sitost = self.sitost - 1
	self.d_razmn = self.d_razmn - 1
end

function o_trava:umri()
	self.zhiv = false
	printlog(self.name..' ����.\n')
	st_dead = st_dead + 1
	st_alive = st_alive - 1
	gumus[self.x][self.y] = gumus[self.x][self.y]+(self.kaloriinost+self.vozrast+self.sitost)/10
end

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
		--refill()
		self:umiraet_or_not()
		self:info()
		self:eda()
		self:razmn()
		self:param()
		grid:setcell(self.x,self.y,grid:getcell(self.x,self.y)..' '..string.sub(self.name,1,1)..string.sub(self.name,string.len(self.name),string.len(self.name)))
		--grid:setcell(self.x,self.y,grid:getcell(x,y)..' *')
--		printlog('�������� ��� � ����� - '..gumus[tmp_obj.x][tmp_obj.y]..'\n')
	else
		self:death()
	end
	return
end
------------------/������� �����-------------------
