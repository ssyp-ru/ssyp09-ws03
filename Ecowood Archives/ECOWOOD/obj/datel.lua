-- ��������: ������ ���������� ����� ������� ���� main.wlua ��� ���
if not did_we_load_the_main_file then
	print("��������, �� �� ������ ��������� ������ MAIN.WLUA")
	os.exit(0)
end
-------------------������� �����------------------
o_datel = deepcopy(o_ptichi)
o_datel_n = 0
o_datel.name = '����'
o_datel.vid = '�����'
o_datel.max_vozrast = 200
o_datel.zrenie = 30
o_datel.deti = 2
o_datel.c1 = 255
o_datel.c2 = 16
o_datel.c3 = 16

function o_datel:create(x,y,c1,c2,c3)
	o_datel_n = o_datel_n + 1
	local tmp_obj = deepcopy(o_datel)
	tmp_obj.name = '����-'..o_datel_n
	tmp_obj.x = x
	tmp_obj.y = y

	tmp_obj.sx = -self.sx
	tmp_obj.sy = -self.sy

	tmp_obj.razmnvoz = false
	tmp_obj.statys = '��������'
	tmp_obj.c1 = c1
	tmp_obj.c2 = c2
	tmp_obj.c3 = c3
	life[table.maxn(life)+1] = tmp_obj
	iup.SetAttribute(list, table.maxn(life), tmp_obj.name)
	st_alive = st_alive + 1 -- +1 �����
end

function o_datel:razmn()
	if self.deti > 0 and self.para~=nil
	and self.razmnvoz == false
	and self.para.x == self.x and self.para.y == self.y then
		printlog('������� ���� �����������.\n')
		for j = 1, self.deti do
			local x = math.random(self.x-1,self.x+1)
			if x<1 then x = 1 end
			if x>g_h then x = g_h end
			local y = math.random(self.y-1,self.y+1)
			if y<1 then y = 1 end
			if y>g_w then y = g_w end
			local c1 = (self.c1 + self.para.c1)/2 + math.random(-8, 8)
			local c2 = (self.c2 + self.para.c2)/2 + math.random(-8, 8)
			local c3 = (self.c3 + self.para.c3)/2 + math.random(-8, 8)
			if c1<1 then c1 = 1 end
			if c2<1 then c2 = 1 end
			if c3<1 then c3 = 1 end
			if c1>255 then c1 = 255 end
			if c2>255 then c2 = 255 end
			if c3>255 then c3 = 255 end
			self:create(x,y,c1,c2,c3)
		end
		printlog('���������� ��������: '..self.deti..'\n')
		self.razmnvoz = true
		self.para.razmnvoz = true
		return
	end
end

------------------/������� �����------------------
