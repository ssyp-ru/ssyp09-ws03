--���� ��������� � ����� �������  03.07.09    ����� v1.0
require ("iuplua")
require( "iupluacontrols")
c,d,p = 0,0,10
math.randomseed (os.time())
math.random ()
a = math.random (1,9)
b = math.random (1,9)

function goodbye2()
	s = iup.Alarm("����","� ��� ��������� �������","������� ���","�����")
	if s == 1 then
		p = 10
		math.randomseed (os.time())
		math.random ()
		a = math.random (1,9)
		b = math.random (1,9)
		game()
		else
		goodbye()
	end
	return
end

function chisla()
	local c,d
	if p == 0 then
		goodbye2()
	end
	ret,c,d = iup.GetParam ("����", nil,
    "�������� ������ �����: %l|1|2|3|4|5|6|7|8|9|\n"..
	"�������� ������ �����: %l|1|2|3|4|5|6|7|8|9|\n",0,0)
	if ret == 0 then
		goodbye()
	end
	return c+1, d+1
end

function goodbye()
	iup.Message("����","����")
	os.exit(0)
	return
end

function game()
c,d = chisla()
e = iup.Alarm ("����","�� ����� ����� "..c.." � "..d,"��������","������ ������","�����")
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
	if c == a and d == b then
		iup.Message ("����","�� ��������!")
		t = iup.Alarm ("����","������ ������� ���?","��, �������","���, ���� �����")
		if t == 1 then
			math.randomseed (os.time())
			math.random ()
			a = math.random (1,9)
			b = math.random (1,9)
			game()
			else
			goodbye()
		end
	end
	if c == a and d ~= b or c ~= a and d == b then
		iup.Message ("����","�� ������� ������ ���� ����� � �� �������, ��� ��� ���������")
		game()
	end
	if a == d and b == c then
		iup.Message ("����","�� ������� ��� �����, �� �� �������, ��� ��� ���������")
		game()
	end
	if a == d or b == c then
		iup.Message ("����","�� ������� ���� �����, �� �� �������, ��� ��� ���������")
		game()
	else
		iup.Message ("����","�� �� ������� �� ������ �����")
		game()
	end
return
end

game()
