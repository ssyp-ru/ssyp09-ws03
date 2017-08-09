math.randomseed(os.time())
mas1, mas2 = {},{}
ran = math.random(3,15)
ren = math.random(3,15)
for i = 1,ran do
	mas1[i] = math.random(9)
end
for i = 1,ren do
	mas2[i] = math.random(9)
end
for i = 1,ran do
	io.write(mas1[i]," ")
end
print()
for i = 1,ren do
	io.write(mas2[i]," ")
end
print()
print()
if ran > ren then
for i = 1,ran,2 do
	io.write(mas1[i]," ")
	if i < ren then
	io.write(mas2[i+1]," ")
	end
end
elseif ran < ren then
	for i = 1,ran,2 do
		if i < ran then
		io.write(mas1[i]," ")
		end
		io.write(mas2[i+1]," ")
	end
else
	for i = 1,ran,2 do
		io.write(mas1[i]," ")
		io.write(mas2[i+1]," ")
	end
end
