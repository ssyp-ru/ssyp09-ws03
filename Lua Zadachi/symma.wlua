--[[require ("iuplua")
require ("iupluacontrols")
math.randomseed(os.time())
math.random(10)
a = 0
m = {}
--for i = 1,5 do
	m[i] = {}
end
for i = 1,math.random(3,11) do
		m[i] = math.random(10)
		print (m[i])
end

for i = 1,table.maxn(m) do
	a = a + m[i]
end
print ("Ðåç ",a)]]

m1 = {1,2,3,4,5,6,7,8,9,10}
m2 = {30,31}
m3 = {}

q = 1

for i = 1,table.maxn(m1) + table.maxn(m2) do
	--for j = 1,table.maxn(m1) do
	c = table.maxn(m2)-i+1
	if (m1[i] ~= nil) then
	print (m1[i])
	m3[q] = m1[i]
	q = q + 1
	end
	if (m2[c] ~= nil) then
	print (m2[c])
	m3[q] = m2[c]
	q = q + 1
	end
end

print()

m3["ggg"] =3333
--[[for i = 1,table.maxn(m3) do
print(m3[i])
end]]
for i,v in ipairs(m3) do
print(i,v)
end
