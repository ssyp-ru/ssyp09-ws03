--���� ��������� � ����� �������  03.07.09    ����� v1.0
require ("iuplua")
require( "iupluacontrols")
iup.SetLanguage("ENGLISH") --����� ������ � Alarm ���� ��-���������

c,d,z,p = 0,0,0,10
math.randomseed (os.time()) --����� random �������� ������ ��������� �����
math.random () --��������� ������ ��������� �����
a = math.random (1,9)
b = math.random (1,9)
x = math.random (1,9)

function goodbye2()
	s = iup.Alarm("����","� ��� ��������� �������","������� ���","�����")
	if s == 1 then
		p = 10
		math.randomseed (os.time())
		math.random ()
		a = math.random (1,9)
		b = math.random (1,9)
		x = math.random (1,9)
		game()
		else
		goodbye()
	end
	return
end

function chisla()
	local c,d,z
	if p == 0 then
		goodbye2()
	end
	ret,c,d,z = iup.GetParam ("����", nil,
    "�������� ������ �����: %l|1|2|3|4|5|6|7|8|9|\n"..
	"�������� ������ �����: %l|1|2|3|4|5|6|7|8|9|\n"..
	"�������� ������ �����: %l|1|2|3|4|5|6|7|8|9|\n",0,0,0)
	if ret == 0 then
		goodbye()
	end
	return c+1, d+1, z+1
end

function goodbye()
	iup.Message("����","����")
	os.exit(0)
	return
end

function game()
c,d,z = chisla()
e = iup.Alarm ("����","�� ����� ����� "..c..", "..d..' � '..z,"��������","������ ������","�����")
if (e == 0) then
	goodbye()
end
if (e == 1) then
	p = p-1
	gem()
end
if (e == 2) then
	game()
end
if (e == 3) then
	goodbye()
end
return
end

function gem()
	if c == a and d == b and x == z then
		iup.Message ("����","�� ��������!\n�� ������������ �������:"..10-p)
		t = iup.Alarm ("����","������ ������� ���?","��, �������","���, ���� �����")
		if t == 1 then
			math.randomseed (os.time())
			math.random ()
			a = math.random (1,9)
			b = math.random (1,9)
			x = math.random (1,9)
			game()
			else
			goodbye()
		end
	end
	if (c == a and d ~= b and z ~= x) or (c ~= a and d == b and z ~= x) or (c ~= a and d ~= b and z == x) then
		iup.Message ("����","�� ������� ������ ���� ����� � �� �������, ��� ��� ���������")
		game()
	end
	if (a == d and b == c and x == z) or (a == z and b == d and x == c) or (a == c and b == z and x == d) then
		iup.Message ("����","�� ������� ��� �����, �� ��� �� ��� ����� �� �� ����� ������")
		game()
	end
		if (a == c and b == d and x ~= z) or (a == c and b ~= d and x == z) or (a ~= c and b == d and x == z) then
		iup.Message ("����","�� ������� ��� ����� � �������, ��� ��� ���������")
		game()
	end
	if a == d or a == z or b == c or b == z then
		iup.Message ("����","�� ������� ���� �����, �� �� �������, ��� ��� ���������")
		game()
	end
	if 	   (a == c and b == z and x ~= d)
		or (a == c and b ~= z and x == d)
		or (a == z and b == d and x ~= c)
		or (a ~= c and b == z and x == d)
		or (a == d and b ~= c and x == z)
		or (a ~= d and b == c and x == z) then
		iup.Message ("����","�� ������� ��� ����� � ��� ��������� ���� �� ���")
		game()
	end
	if (a == d and b == c and x ~= z) or (a == z and b ~= d and x == c) or (a ~= c and b == z and x == d) then
		iup.Message ("����","�� ������� ��� �����, �� �� �������, ��� ��� ���������")
		game()
	else
		iup.Message ("����","�� �� ������� �� ������ �����")
		game()
	end
return
end

game()
