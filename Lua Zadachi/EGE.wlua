--���������� ������
--��� ��� 5 ������
require('iuplua')
pravelno = 0
ne_pravelno = 0

iup.Message('��� ��� 5 ������','����� ��������� �� ���!\n��� ����������� ������� OK')

otvet = iup.Alarm('��� ��� 5 ������','� 2009� ������� ��� ���� �� ������?','200','139','2009')
if otvet == 1 then pravelno = pravelno +1 end
if otvet == 2 then ne_pravelno = ne_pravelno +1 end
if otvet == 3 then ne_pravelno = ne_pravelno +1 end

otvet = iup.Alarm('��� ��� 5 ������','��� ������ ���������� �������?','�����','�����','��������')
if otvet == 1 then ne_pravelno = ne_pravelno +1 end
if otvet == 2 then pravelno = pravelno +1 end
if otvet == 3 then ne_pravelno = ne_pravelno +1 end

otvet = iup.Alarm('��� ��� 5 ������','��� ���������� ����� � ������� ������?','�� ��� �� ����','� ������','���������')
if otvet == 1 then ne_pravelno = ne_pravelno +1 end
if otvet == 2 then pravelno = pravelno +1 end
if otvet == 3 then ne_pravelno = ne_pravelno +1 end


iup.Message('���������','�� ������� '..pravelno..' ������ ������.\n�� ������� '..ne_pravelno..' �� ������ ������')

if ne_pravelno >= pravelno then
	iup.Message('���������!','�� �� ������ ���')
end
if pravelno >= ne_pravelno then
	iup.Message('���������','�� ������ ���')
end
