-- ��������: ������ ���������� ����� ������� ���� main.wlua ��� ���
if not did_we_load_the_main_file then
	print("��������, �� �� ������ ��������� ������ MAIN.WLUA")
	os.exit(0)
end
-------------------������� ����-------------------
o_ptichi = deepcopy(predok)
o_ptichi.name = "�����"
o_ptichi.typ = "�����"
o_ptichi.chto_est = '�����'
o_ptichi.ed_pitaniya = 1
o_ptichi.max_vozrast = 120
o_ptichi.cikl_pitaniya = 20
o_ptichi.sitost = 70
o_ptichi.cikl_razmn = 20
o_ptichi.d_razmn = o_chervi.cikl_razmn
o_ptichi.deti = 2 -- ������� 2 �������
o_ptichi.othodi = 1
o_ptichi.cikl_videl = 6 -- ����� ������� ������ �������� ����� � �����
o_ptichi.d_videl = o_chervi.cikl_videl -- ������� �� ���������� ����� ��������� ������
o_ptichi.zaderzhka_v_go = 1 -- ������� ���� ������ �� ���������� ����
o_ptichi.d_go = o_ptichi.zaderzhka_v_go
o_ptichi.statys = '��������'
o_ptichi.razmnvoz = false -- ����� ������������ 1 ���.
o_ptichi.edagertva = nil

function o_ptichi:eda()
	if (self.sitost < 50) and (self.statys ~= '�����') and (self.statys ~= '����������') then
		for i = 1, table.maxn(life) do
			if (life[i].typ == self.chto_est) and (life[i].x==self.x) and (life[i].y==self.y) then
				printlog('������� ���� �������.\n')
				life[i]:umri(true) -- �������� ��� = ������� ����� ������� � ������
				self.sitost = 100
				self.edagertva = nil
				self.statys = '��������'
				return
			elseif self.sitost < 0 then
				self:umri()
			end
		end
	end
	grid.redraw = 'ALL'
end

function o_ptichi:poisk_edi()
	--local x1 = nil
	--local y1 = nil
	if (self.statys ~= '�����') and (self.statys ~= '����������') then
--		iup.Message('root',"(self.statys ~= '�����') and (self.statys ~= '����������')")
		if (self.edagertva == nil) then
--			iup.Message('root',"(self.edagertva == nil)")
			for i = 1, table.maxn(life) do
				if (life[i].typ == self.chto_est) and (life[i] ~= self)
					and (life[i].statys~='�����') and (life[i].statys~='����������') then
					self.edagertva = life[i]
					--x1 = life[i].x
					--y1 = life[i].y
--					iup.Message('root','1; self.edagertva = '..self.edagertva.name)
					return --x1,y1
				end
			end
--[[		elseif (self.edagertva.x ~= x1) and (self.edagertva ~= y1) then
			x1,y1 = self:poisk_edi()
]]		else
			--iup.Message('root',"(self.edagertva ~= nil)")
			--x1 = self.edagertva.x
			--y1 = self.edagertva.y
			--iup.Message('root','2; x1,y1 = '..x1..y1)
--			iup.Message('root','2; self.edagertva = '..self.edagertva.name)
			return --x1,y1
		end
	end
	return --x1,y1
end
function o_ptichi:razmn()
	if (self.d_razmn < 1) and (self.deti > 0) and (self.statys ~= '�����') and (self.statys ~= '����������') then
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
function o_ptichi:param()
	if (self.statys ~= '�����') and (self.statys ~= '����������') then
		self.vozrast = self.vozrast + 1
		self.sitost = self.sitost - 2
		if self.d_razmn > 0 then
			self.d_razmn = self.d_razmn - 1
		end
	end
end
function o_ptichi:umri()
	if (self.statys ~= '�����') and (self.statys ~= '����������') then
		self.statys = '�����'
		if self.para~=nil then
--			iup.Message('root','������ ���� '..self.name..' - '..self.para.name)
			self.para.para = nil
			self.para = nil
--			iup.Message('root',self.para.name..self.para.para.name)
		end
		printlog(self.name..' ����.\n')
		st_dead = st_dead + 1
		st_alive = st_alive - 1
	end
end

function o_ptichi:zhivi()
	if (self.statys ~= '�����') and (self.statys ~= '����������') then
		self:draw(cnv)
		self:umiraet_or_not()
		self:info()
		self:poisk_pari()
		self:go()
		self:eda()
		self:razmn()
		self:param()
		self:ydobrenie()
		if mode == 0 then grid:setcell(self.x,self.y,grid:getcell(self.x,self.y)..' '..string.sub(self.name,1,1)..string.sub(self.name,string.len(self.name),string.len(self.name))) end
	else
		self:death()
	end
	return
end

function o_ptichi:go()
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

			elseif (self.statys == '���� ����') then
				--x1,y1 =
				self:poisk_edi()

				if self.edagertva ~= nil then
					-- �� ����� ������! � ���� � ���

--					iup.Message("root",'���������� ������: '.. self.edagertva.x .. "," .. self.edagertva.y)
					if self.x < self.edagertva.x then
						self.sx = 1
					elseif self.x > self.edagertva.x then
						self.sx = -1
					else
						self.sx = 0
					end
					if self.y < self.edagertva.y then
						self.sy = 1
					elseif self.y > self.edagertva.y then
						self.sy = -1
					else
						self.sy = 0
					end
				else
					-- ����� �� �� ����� ������ � ������� ��������� ������!
					self.statys = '��������'
					-- �� ������� ��� �� ������� � �� ������� ���� �����
				end

				-- �� ����� �� �� ���� ����
				if (self.x + self.sx < 1) or (self.x + self.sx > g_h) then self.sx = 0 end
				if (self.y + self.sy < 1) or (self.y + self.sy > g_w) then self.sy = 0 end
				-- ������ ���
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
				if (self.sitost <= 50) then self.statys = '���� ����' end
			end
		else -- ���, ������ ��� ������

			self.d_go = self.d_go - 1

			if (self.sitost > 50) and (self.statys ~= '����� ����') then
				self.statys = '��������'
			end

			if (self.sitost <= 50) then
				self.statys = '���� ����'
			end

		end
		--[[if (self.statys~='����� ����') and (self.statys~='���� ����') then
			if (self.vozrast > (self.max_vozrast/2)) and (self.razmnvoz == false) then
				self.statys = '����� ����'
--					iup.Message('��� ����',self.name..' ���� ����!')
			end
		end]]

	end
end

--[[
function o_chervi:go()
	if (self.statys ~= '�����') and (self.statys ~= '����������') then
		-- ��� ����� ������ ��� ?
		if (self.d_go <= 1) then -- ��, �����
			if (self.statys == '��������') then
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
				--m_prover_kletki
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
			elseif	self.statys == '����� ����' then -- ���� �� �� �������, ��� ���� ����, �� ������ ��������
				self:poisk_pari()-- �� ���� ���� ������ ������
			end
		else -- ���, ������ ��� ������
			self.d_go = self.d_go - 1
			if (self.sitost <= self.cikl_pitaniya - (self.cikl_pitaniya/2)) then
				self.statys = '���� ����'
			end
			if (self.sitost > self.cikl_pitaniya - (self.cikl_pitaniya/2)) then
				self.statys = '����� ����'
			end
		end
	end
end
]]

function o_ptichi:ydobrenie()
	if self.d_videl == 0 then
		gumus[self.x][self.y] = gumus[self.x][self.y] + self.othodi
		d_videl = cikl_videl
	end
end

-- �������
function o_ptichi:draw(cnv)
	if mode == 1 then
		canvas:Foreground(cd.EncodeColor(self.c1,self.c2,self.c3))
		canvas:Line(self.x*10-5,self.y*10-5, self.x*10+5,self.y*10+5)
	end
end
------------------/������� ����-------------------
