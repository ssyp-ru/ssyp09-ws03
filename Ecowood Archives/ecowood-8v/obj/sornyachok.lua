-- ��������: ������ ���������� ����� ������� ���� main.wlua ��� ���
if not did_we_load_the_main_file then
	print("��������, �� �� ������ ��������� ������ MAIN.WLUA")
	os.exit(0)
end
-------------------������� ��������----------------
o_sornyachok = deepcopy(o_trava)
o_sornyachok_n = 0
o_sornyachok.name = "��������"
o_sornyachok.deti = 2

function o_sornyachok:create(x,y)
	o_sornyachok_n = o_sornyachok_n + 1
	tmp_obj = deepcopy(o_sornyachok)
	tmp_obj.name = '��������-'..o_sornyachok_n
	tmp_obj.x = x
	tmp_obj.y = y
	tmp_obj.chto_est = '�����'
	life[table.maxn(life)+1] = tmp_obj
	iup.SetAttribute(list, table.maxn(life), tmp_obj.name)
	st_alive = st_alive + 1
end
------------------/������� ��������----------------
