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
o_chervi.ed_pitaniya = 1
o_chervi.max_vozrast = 360
o_chervi.cikl_pitaniya = 20
o_chervi.sitost = 70
o_chervi.cikl_razmn = 20
o_chervi.d_razmn = o_chervi.cikl_razmn
o_chervi.deti = 2 -- ������� 2 �������
o_chervi.othodi = 1
o_chervi.cikl_videl = 15 -- ����� ������� ������ �������� ����� � �����
o_chervi.d_videl = o_chervi.cikl_videl -- ������� �� ���������� ����� ��������� ������
o_chervi.zaderzhka_v_go = 4 -- ������� ���� ������ �� ���������� ����
o_chervi.d_go = o_chervi.zaderzhka_v_go
o_chervi.statys = '��������'
o_chervi.razmnvoz = false -- ����� ������������ 1 ���.

function o_chervi:eda()
	if (self.sitost < 10) and (self.statys ~= '�����') and (self.statys ~= '����������') then
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
	if (self.vozrast >= (self.max_vozrast/2)) and (self.razmnvoz  == false) and (self.deti > 0) and (self.statys ~= '�����') and (self.statys ~= '����������') then
		printlog('������� ���� �����������.\n')
		for j = 1, self.deti do
			local x = math.random(self.x-1,self.x+1)
			if x<1 then x = 1 end
			if x>g_h then x = g_h end
			local y = math.random(self.y-1,self.y+1)
			if y<1 then y = 1 end
			if y>g_w then y = g_w end
			c1 = self.c1 + math.random('-8', '8')
			c2 = self.c2 + math.random('-8', '8')
			c3 = self.c3 + math.random('-8', '8')
			self:create(x,y,c1,c2,c3)
		end
		printlog('���������� ��������: '..self.deti..'\n')
		self.razmnvoz = true
--		self.d_razmn = self.cikl_razmn
	end
end
function o_chervi:param()
	if (self.statys ~= '�����') and (self.statys ~= '����������') then
		self.vozrast = self.vozrast + 1
		self.sitost = self.sitost - 5
		if self.d_razmn > 0 then
			self.d_razmn = self.d_razmn - 1
		end
	end
end
function o_chervi:umri(sjeli)
	if (self.statys ~= '�����') and (self.statys ~= '����������') then
		self.statys = '�����'
		if sjeli then self.death_coef = 0 end
		if self.para~=nil then
			self.para.para = nil
			self.para = nil
		end
		for i = 1, table.maxn(life) do
			if life[i].edagertva == self then
				life[i].edagertva = nil
			end
		end
		printlog(self.name..' ����.\n')
		st_dead = st_dead + 1
		st_alive = st_alive - 1
	end
end

function o_chervi:zhivi()
	if (self.statys ~= '�����') and (self.statys ~= '����������') then
		--if mode == 1 then self:draw(cnv) end
		self:umiraet_or_not()
		self:info()
		self:eda()
		self:poisk_pari()
		self:go()
		self:razmn()
		self:param()
		self:ydobrenie()
		if mode == 0 then grid:setcell(self.x,self.y,grid:getcell(self.x,self.y)..' '..string.sub(self.name,1,1)..string.sub(self.name,string.len(self.name),string.len(self.name))) end
	else
		self:death()
	end
	return
end

function o_chervi:go()
	if (self.statys ~= '�����') and (self.statys ~= '����������') then
		-- ��� ����� ������ ��� ?
		if (self.d_go <= 1) then -- ��, �����
			if (self.statys == '����� ����') then
				if self.x < x1 then
					self.sx = 1
				elseif self.x > x1 then
					self.sx = -1
				else
					self.sx = 0
				end
				if self.y < y1 then
					self.sy = 1
				elseif self.y > y1 then
					self.sy = -1
				else
					self.sy = 0
				end

				if self.x + self.sx < 1 or self.x + self.sx > g_h then self.sx = 0 end
				if self.y + self.sy < 1 or self.y + self.sy > g_w then self.sy = 0 end

				self.x = self.x + self.sx
				self.y = self.y + self.sy
				self.d_go = self.zaderzhka_v_go -- ��� ������, ���� �������� ���-�� ������ �� ���� ����
			elseif (self.statys == '��������') then
				if math.random(100)<50 then
					local sx = math.random(-1,1)
					local sy = math.random(-1,1)

					self.sx = sx
					self.sy = sy
				end
				if self.x + self.sx < 1 or self.x + self.sx > g_h then self.sx = 0 end
				if self.y + self.sy < 1 or self.y + self.sy > g_w then self.sy = 0 end

				self.x = self.x + self.sx
				self.y = self.y + self.sy
				self.d_go = self.zaderzhka_v_go -- ��� ������, ���� �������� ���-�� ������ �� ���� ����
			elseif (self.statys == '���� ����') then
				local j = math.random(9)
				for i = j, j+9 do
						-- ��������� ����, �.�. ����� ��� ����
					if self.x+m_prover_kletki[i].sx<1 or self.x+m_prover_kletki[i].sx>g_h then
						break
					end
					if self.y+m_prover_kletki[i].sy<1 or self.y+m_prover_kletki[i].sy>g_w then
						break
					end

					if (gumus[self.x+m_prover_kletki[i].sx][self.y+m_prover_kletki[i].sy] >= self.ed_pitaniya) then
						self.sx = m_prover_kletki[i].sx
						self.sy = m_prover_kletki[i].sy

						self.x = self.x + self.sx
						self.y = self.y + self.sy
						self.d_go = self.zaderzhka_v_go -- ��� ������, ���� �������� ���-�� ������ �� ���� ����
						break
					end
				end
			end
		else -- ���, ������ ��� ������
			self.d_go = self.d_go - 1
			if (self.sitost <= (self.cikl_pitaniya/2)) then
				self.statys = '���� ����'
			end

			if (self.statys~='����� ����') and (self.statys~='���� ����') then
				if (self.vozrast > (self.max_vozrast/2)) and (self.razmnvoz == false) then
					self.statys = '����� ����'
--					iup.Message('��� ����',self.name..' ���� ����!')
				end

				if (self.sitost > (self.cikl_pitaniya/2)) then
					self.statys = '��������'
				end
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
