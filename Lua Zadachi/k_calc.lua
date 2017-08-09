function b_read ()
print('¬ведите число.')
return (io.read())
end

function z_read ()
print('¬ведите знак действи€.')
return (io.read())
end

function prog ()
print('¬ведите число.')
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
	print('ќшибка: на ноль делить нельз€.')
	cikl()
end
if (z ~= '+') and (z ~= '-') and (z ~= '*') and (z ~= '/') then
	print('ќшибка: некорректный знак действи€ или нет данных.')
	prog()
end
print('ќтвет - '..a..'.')
print('≈ще вычислить (с полученным результатом)? ("1" - да, "2" - нет.)')
q = io.read()
if q == '1' then
	cikl()
end
end

prog()
