m = {}
x,y = 15,10

for i = 1, y do
	m[i] = {}
end

for i = 1, y do
	for j = 1, x do
		m[i][j] = 1
	end
end

for i = 2, (y - 1) do
	for j = 2, (x - 1) do
		m[i][j] = 0
	end
end

io.write ('\n\n')
for i = 1, y do
	for j = 1, x do
		io.write(m[i][j])
	end
	io.write('\n')
end
