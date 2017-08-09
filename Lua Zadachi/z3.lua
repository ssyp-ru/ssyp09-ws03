s = 'андрей александрович берс'
a = ''
z = 1
s = s..' f'
a = (string.char (string.byte(s,z)-32))
for i = 1,string.len(s) do
if (string.sub (s,i,i) == ' ') then
a,z = a..(string.sub(s,z+1,i)),i+1
a = a..(string.char (string.byte(s,z)-32))
end
end
a = string.sub(a,1,string.len(a)-2)
print (a)
