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

function o_cherv:create(x,y)
	o_cherv_n = o_cherv_n + 1
	tmp_obj = deepcopy(o_cherv)
	tmp_obj.name = '��������-'..o_cherv_n
	tmp_obj.x = x
	tmp_obj.y = y
	life[table.maxn(life)+1] = tmp_obj
	st_alive = st_alive + 1
end

------------------/������� ��������----------------
