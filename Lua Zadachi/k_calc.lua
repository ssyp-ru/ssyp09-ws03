function b_read ()
print('������� �����.')
return (io.read())
end

function z_read ()
print('������� ���� ��������.')
return (io.read())
end

function prog ()
print('������� �����.')
a = io.read()
cikl()
end

function cikl ()
z = z_read()
b = b_read()
if z == '+' then
	a = a + b
end
if z == '-' then
	a = a - b
end
if z == '*' then
	a = a * b
end
if z == '/' then
	a = a / b
end
if z == '/' and b == '0' then
	print('������: �� ���� ������ ������.')
	cikl()
end
if (z ~= '+') and (z ~= '-') and (z ~= '*') and (z ~= '/') then
	print('������: ������������ ���� �������� ��� ��� ������.')
	prog()
end
print('����� - '..a..'.')
print('��� ��������� (� ���������� �����������)? ("1" - ��, "2" - ���.)')
q = io.read()
if q == '1' then
	cikl()
end
end

prog()
