-- ��������: ������ ���������� ����� ������� ���� main.wlua ��� ���
if not did_we_load_the_main_file then
	print("��������, �� �� ������ ��������� ������ MAIN.WLUA")
	os.exit(0)
end
-------------------������� ��������� �����----------------
o_d_cherv = deepcopy(o_chervi)
o_d_cherv_n = 0
o_d_cherv.name = '�������� �����'
o_d_cherv.vid = '�������� �����'
o_d_cherv.max_vozrast = 100
o_d_cherv.deti = 1
o_d_cherv.c1 = 255
o_d_cherv.c2 = 16
o_d_cherv.c3 = 16

function o_d_cherv:create(x,y,c1,c2,c3)
	o_d_cherv_n = o_d_cherv_n + 1
	tmp_obj = deepcopy(o_d_cherv)
	tmp_obj.name = '�������� �����-'..o_d_cherv_n
	tmp_obj.typ = '�������� �����'
	tmp_obj.x = x
	tmp_obj.y = y
	tmp_obj.razmnvoz = false
	life[table.maxn(life)+1] = tmp_obj
	iup.SetAttribute(list, table.maxn(life), tmp_obj.name)
	st_alive = st_alive + 1
	self.statys = '��������'
	self.c1 = c1
	self.c2 = c2
	self.c3 = c3
end

function o_d_cherv:razmn()
	if (self.deti > 0) and (self.para~=nil) and (self.razmnvoz == false) then
		self.status = '�����������'
		for i = 1, table.maxn(life) do
			if (life[i].vid==self.vid) and (life[i].name~=self.name) and (life[i].x==self.x) and (life[i].y==self.y) then
				printlog('������� ���� �����������.\n')
				for j = 1, self.deti do
					local x = math.random(self.x-1,self.x+1)
					if x<1 then x = 1 end
					if x>g_h then x = g_h end
					local y = math.random(self.y-1,self.y+1)
					if y<1 then y = 1 end
					if y>g_w then y = g_w end
					c1 = (self.c1 + life[i].c1)/2 + math.random(-8, 8)
					c2 = (self.c2 + life[i].c2)/2 + math.random(-8, 8)
					c3 = (self.c3 + life[i].c3)/2 + math.random(-8, 8)
					self:create(x,y,c1,c2,c3)
				end
				printlog('���������� ��������: '..self.deti..'\n')
--				self.d_razmn = self.cikl_razmn
				self.razmnvoz = true
			end
		end
	end
end

function o_d_cherv:poisk_pari()
	if (self.para == nil) and (self.vozrast > 16--[[(self.max_vozrast/2)]])--[[ and (self.razmnvoz == false)]] then
		for i = 1, table.maxn(life) do
			if (life[i]~=self) and (life[i].vid == self.vid) and (life[i].para == nil) then
				self.para = life[i]
				life[i].para = self
				self.statys = '����� ����'
				x1 = self.para.x
				y1 = self.para.y
				--self:go_to_obj(life[i].x,life[i].y)
				return
			end
		end
		if self.para == nil then
			self.statys = '��������'
			return
		end
	end
end

--[[
function o_d_cherv:go_to_obj(x1,y1)
	if (self.statys ~= '�����') and (self.statys ~= '����������') then
		-- ��� ����� ������ ��� ?
		if (self.d_go <= 1) then -- ��, �����
			if (self.statys == '����� ����') then
				if self.x < x1 then
					self.x = self.x+1
				elseif self.x > x1 then
					self.x = self.x - 1
				end
				if self.y < y1 then
					self.y = self.y+1
				elseif self.y > y1 then
					self.y = self.y - 1
				end
				self.d_go = self.zaderzhka_v_go -- ��� ������, ���� �������� ���-�� ������ �� ���� ����
			elseif (self.statys == '���� ����') then
				for x = self.x-1,self.x+1 do
					for y = self.y-1,self.y+1 do

						if x<1 or x>g_h or y<1 or y>g_w then
							break -- ��������� �����, �.�. ����� ��� ����
						end

						if (gumus[x][y] >= self.ed_pitaniya) then
							self.x = x
							self.y = y
							self.d_go = self.zaderzhka_v_go -- ��� ������, ���� �������� ���-�� ������ �� ���� ����
							break
						end
					end
				end
			end
		else -- ���, ������ ��� ������
			self.d_go = self.d_go - 1
			if (self.sitost <= self.cikl_pitaniya - (self.cikl_pitaniya/2)) then
				self.statys = '���� ����'
			end
			if (self.sitost > self.cikl_pitaniya - (self.cikl_pitaniya/2)) and (self.vozrast >= 10) and (self.para_name==nil) then
				self.statys = '����� ����'
			end
		end
	end
end
]]

------------------/������� ��������� �����----------------
