-- ��������: ������ ���������� ����� ������� ���� main.wlua ��� ���
if not did_we_load_the_main_file then
	print("��������, �� �� ������ ��������� ������ MAIN.WLUA")
	os.exit(0)
end
-------------------������� �����------------------
o_datel = deepcopy(o_ptichi)
o_datel_n = 0
o_datel.name = '�����'
o_datel.vid = '�����'
o_datel.max_vozrast = 100
o_datel.deti = 1
o_datel.c1 = 255
o_datel.c2 = 16
o_datel.c3 = 16

function o_datel:create(x,y,c1,c2,c3)
	o_datel_n = o_datel_n + 1
	tmp_obj = deepcopy(o_datel)
	tmp_obj.name = '�����-'..o_datel_n
	tmp_obj.typ = '�����'
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

function o_datel:razmn()
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

function o_datel:poisk_pari()
	if (self.statys ~= '�����') and (self.statys ~= '����������') and (self.para == nil) and (self.vozrast > 16) then
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

function o_ptichi:poisk_edi()
	if (self.statys ~= '�����') and (self.statys ~= '����������') and (self.edagertva == nil) then
		for i = 1, table.maxn(life) do
			if (life[i].vid == '�����') then
				self.edagertva = life[i]
				x1 = self.edagertva.x
				y1 = self.edagertva.y
				return
			end
		end
		--[[if self.para == nil then
			self.statys = '��������'
			return
		end]]
	end
end

------------------/������� �����------------------

