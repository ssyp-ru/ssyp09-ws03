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
o_datel.max_vozrast = 1000
o_datel.zrenie = 30
o_datel.deti = 1
o_datel.c1 = 255
o_datel.c2 = 16
o_datel.c3 = 16

function o_datel:create(x,y,c1,c2,c3)
	o_datel_n = o_datel_n + 1
	tmp_obj = deepcopy(o_datel)
	tmp_obj.name = '����-'..o_datel_n
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
end

function o_datel:poisk_pari()
	if (self.statys ~= '�����') and (self.statys ~= '����������') and (self.para == nil) and (self.vozrast > 16) then
		for i = 1, table.maxn(life) do
			if (life[i] ~= self) and (life[i].vid == self.vid) and (life[i].para == nil) and (life[i].statys ~= '�����') and (life[i].statys ~= '����������') then
				self.para = life[i]
				self.para.para = self
				self.statys = '����� ����'
				--x1 = self.para.x
				--y1 = self.para.y
				--self:go_to_obj(life[i].x,life[i].y)
				return
			end
		end
		if self.para == nil then
			--self.statys = '��������'
			return
		end
	end
end

------------------/������� �����------------------
