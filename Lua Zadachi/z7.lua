require('iuplua')
require('iupluacontrols')

a = iup.Alarm ('��� ��','��� ��?','����','����','����')
if a == 1 then
	iup.Message ('','�� �����.')
elseif a == 2 then
	iup.Message ('','�� �����.')
elseif a == 3 then
	iup.Message ('','�� ����� �������.')
end
