function create_field(x,y)
	if (x < 3) then
		x = 3
	end
	if (y < 3) then
		y = 3
	end
	local m = {}

	m.shirina = x
	m.vysota = y

	for i = 1, y do
		m[i] = {}
	end


	for i = 1,y do
		for j = 1,x do
			m[i][j] = 0
		end
	end


	for i = 1,x do
		m[1][i] = 1
	end
	for i = 1,x do
		m[y][i] = 1
	end
	for i = 1,y do
		m[i][1] = 1
	end
	for i = 1,y do
		m[i][x] = 1
	end

	return m
end
-- нарисовать поле
function ris(m)
	for i = 1,m.vysota do
		for j = 1,m.shirina do
			io.write (m[i][j])
		end
		io.write ('\n')
	end
return
end

function range(x1,y1,x2,y2)
local x3 = x1-x2
local y3 = y1-y2
local x4 = x3*x3
local y4 = y3*y3
local xy = x4+y4
r = math.sqrt(xy)
return r
end

m1 = create_field (30, 40)
m2 = create_field (10, 20)
m3 = create_field (15, 15)


