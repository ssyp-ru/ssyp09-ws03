-- ������� 5 �������� ���������� � ������� �� � 1 ������ � �� ����� � ������ ������
a,b,c,d,e = '�����','������','���������������','������ ����������','����'
print (a,b,c,d,e)

if (string.len(b) > string.len(c) and string.len(b) > string.len(d)) then
	print (b.. " ����� ������� ���")
	elseif (string.len(c) > string.len(d)) then
		print (c.." ����� ������� ���")
	else
		print (d.." ����� ������� ���")
end
--a = e
s = string.len(a)
while (s ~= 0) do
io.write(string.sub(a,s,s))
s = s-1
end
s = string.len(a)
io.write("\n"..string.sub(a,1,2)..string.sub(b,3,string.len(b)-2)..string.sub(c,string.len(c)-1,string.len(c)))

a = '��������'
s = string.len(a)
l = 2
io.write('\n')
while (l <= s) do
io.write(string.sub(a,l,l))
l = l+2
end
