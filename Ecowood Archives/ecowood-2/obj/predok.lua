-- ��������: ������ ���������� ����� ������� ���� main.wlua ��� ���
if not did_we_load_the_main_file then
	print("��������, �� �� ������ ��������� ������ MAIN.WLUA")
	os.exit(0)
end
----------------------- ����������� ���� ����� �������-----------------------
predok = {typ = "������",
		x = 1,
		y = 1,
		num = 0,
		name = "��� �����",
		zhiv = true,
		vozrast = 0,
		max_vozrast = 40,
		ed_pitaniya = 0,
		kaloriinost = 0,
		sitost = 0,
		razl = false,
		chto_est = '������',
		cikl_razmn = 0,
		d_razmn = 0,
		deti = 0,
		zrenie = 0,
		statys = 0,
		dom_x = 0,
		dom_y = 0,
		parent_name = '�� ��� ������'
	}
function predok:umiraet_or_not()
	if (self.vozrast >= self.max_vozrast) then
--		umri()
		return
	end
end
-----------------------/����������� ���� ����� �������-----------------------
