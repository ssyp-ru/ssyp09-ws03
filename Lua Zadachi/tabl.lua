--[[ ������
while ������������
  ���-�� ������
end

repeat
	���-�� ������
until ������


--forever:

while true
  ���-�� ������
end

repeat
	���-�� ������
until true
]]

a=0
b=0
while b~=10 do
	b = b+1
	--io.write("����b ")
	a = 0
	while a ~= 10 do
		--io.write("����a ")
		a = a+1
		io.write(a*b.." ")
	end
	print()
end
io.write("\n")

for d=1,10 do
io.write(d.." ")

	for c=1,10 do
	--io.write(c.." ")
	io.write(c*d.." ")
	end
print()
end
