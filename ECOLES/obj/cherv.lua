-- ��������: ������ ���������� ����� ������� ���� main.wlua ��� ���
if not did_we_load_the_main_file then
	print("��������, �� �� ������ ��������� ������ MAIN.WLUA")
	os.exit(0)
end
-------------------������� ��������----------------
o_cherv = deepcopy(o_chervi)
o_cherv_n = 0
o_cherv.name = "��������"
o_cherv.deti = 1

function o_cherv:create(x,y,c1,c2,c3)
	o_cherv_n = o_cherv_n + 1
	tmp_obj = deepcopy(o_cherv)
	tmp_obj.name = '��������-'..o_cherv_n
	tmp_obj.x = x
	tmp_obj.y = y
	tmp_obj.razmnvoz = false
	tmp_obj.statys = '��������'
	tmp_obj.c1 = c1
	tmp_obj.c2 = c2
	tmp_obj.c3 = c3
	life[table.maxn(life)+1] = tmp_obj
	iup.SetAttribute(list, table.maxn(life), tmp_obj.name)
	st_alive = st_alive + 1
	self.sitost = 20
end

function o_cherv:zhivi()
	if (self.statys ~= '�����') and (self.statys ~= '����������') then
		--if mode == 1 then self:draw(cnv) end
		self:umiraet_or_not()
		self:info()
		self:eda()
--		self:poisk_pari()
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
------------------/������� ��������----------------
