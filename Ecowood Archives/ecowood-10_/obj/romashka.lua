-- ��������: ������ ���������� ����� ������� ���� main.wlua ��� ���
if not did_we_load_the_main_file then
	print("��������, �� �� ������ ��������� ������ MAIN.WLUA")
	os.exit(0)
end
-------------------������� �������----------------
o_romashka = deepcopy(o_trava)
o_romashka_n = 0
o_romashka.name = "�������"
o_romashka.deti = 1

function o_romashka:create(x,y)
	o_romashka_n = o_romashka_n + 1
	tmp_obj = deepcopy(o_romashka)
	tmp_obj.name = '�������-'..o_romashka_n
	tmp_obj.x = x
	tmp_obj.y = y
	tmp_obj.chto_est = '�����'
	life[table.maxn(life)+1] = tmp_obj
	iup.SetAttribute(list, table.maxn(life), tmp_obj.name)
	st_alive = st_alive + 1
end
------------------/������� �������----------------
