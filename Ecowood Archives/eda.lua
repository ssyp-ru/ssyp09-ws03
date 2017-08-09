--функция вычисления мин расст от тчк до тчк
function range(x1,y1,x2,y2)
local x3 = x1-x2
local y3 = y1-y2
local x4 = x3*x3
local y4 = y3*y3
local xy = x4+y4
r = math.sqrt(xy)
return r
end

--точки еды
m = {}
m[1] = {x = 13,y = 12}
m[2] = {x = 15,y = 7}
m[3] = {x = 2,y = 9}
m[4] = {x = 24,y = 5}
m[5] = {x = 34,y = 1}


min = 65000
--координаты зверушки
x = 13
y = 12
--ищет расстояние от зверушки до точки еды
for i = 1,5 do
	m[i].r = range(x,y,m[i].x,m[i].y)
end
--ищет мин расстояние
for i = 1,5 do
	if m[i].r < min then
		min = m[i].r
	end
end
--выводит мин расстояние
io.write (min)
