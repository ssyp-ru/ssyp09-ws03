--"��� � �����" ������ 0.3
--03.07.09

require('iuplua')
require('iupluacontrols')
iup.SetLanguage('ENGLISH')

n = nil
p = nil
y = nil
v = nil
str = ''
m = {}
r = {}
z = {}

function skilllevel()
b = iup.Alarm("��� � �����: ������� ���������", "�������� ������� ���������" ,"�������" ,"�������" ,"�������")

if b == 1 then
	return 2
elseif b == 2 then
	return 3
elseif b == 3 then
	return 4
end
end

function randomnums()
	for i = 1, n do
		local j = math.random(table.maxn(z))
		r[i] = z[j]
		table.remove(z,j)
--		iup.Message('rootmsg','������ ����� - '..r[i])
	end
end

function guessing ()
	if p == 0 then
		iup.Message('��� � �����: ��������','�� ���������, ������� ���������! ���������� ��� ���!')
		os.exit(0)
	end
	ret,str = iup.GetParam('��� � �����: ����',nil,'������� '..n..' ������ ���� � 0 �� 9 (��� �������� ��� �������� ����������). %s\n','')
	for i = 1, n do
		m[i] = 0+string.sub(str,i,i)
		for j = 1, i-1 do
			if m[i] == m[j] then
				iup.Message('��� � �����: ������','������: ����� �� ������ �����������.')
				guessing()
			end
		end
--		iup.Message('rootmsg','������������ ����� - '..m[i])
	end
	y = 0
	v = 0
	for i = 1, n do
		for j = 1, n do
			if m[i] == r[j] then
				y = y + 1
			end
		end
	end
	for i = 1,n do
		if m[i] == r[i] then
			v = v + 1
		end
	end
	if v == n then
		iup.Message('��� � �����: ������','�� ������� ��� � ��������!')
		os.exit(0)
	else
		p = p-1
		iup.Message('��� � �����: ���������','������� ���������:\n\n�� ������� '..y..' �����.\n�� ��� '..v..' ����� �� ����� �����.\n�������� �������: '..p..'.')
	end
	guessing()
end

math.randomseed(os.time())
math.random()
math.random()
n = skilllevel()
p = n * 6
iup.Message('��� � �����: �����������', '����� ���������� � ���� "��� � �����".\n��� ����� ����� ������� '..n..'-������� ���.')
z = {0,1,2,3,4,5,6,7,8,9}
randomnums()
guessing(p)
