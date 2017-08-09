--Измерение расстояний от определенной точки (x,y) до десяти других и вывод наименьшего.

function range (x1,y1,x2,y2)
	return (math.sqrt ((x1-x2)*(x1-x2) + (y1-y2)*(y1-y2)))
end

x = 15
y = 1
m = {}
m[1] = {x=15, y=10}
m[2] = {x=21, y=18}
m[3] = {x=16, y=22}
m[4] = {x=45, y=26}
m[5] = {x=49, y=30}
m[6] = {x=37, y=33}
m[7] = {x=26, y=40}
m[8] = {x=19, y=42}
m[9] = {x=41, y=48}
m[10] = {x=43, y=50}

for i = 1, 10 do
	m[i].r = range (x,y,m[i].x,m[i].y)
	print (i,range (x,y,m[i].x,m[i].y))
end

min = 9999
num = 0
for i = 1, 10 do
	if m[i].r < min then
		min = m[i].r
		num = i
	end
end

io.write ('\n'..num..'\t'..min..'\n')
