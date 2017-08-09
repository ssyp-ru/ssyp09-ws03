print ('¬ведите число')
a = io.read ()
print ('¬ведите знак')
c = io.read ()
print ('¬ведите второе число')
b = io.read ()
if (c == '+') then
	print(a..'+'..b..'='..a+b)
end
if (c == '-') then
	print (a..'-'..b..'='..a-b)
end
if (c == '*') then
	print (a..'*'..b..'='..a*b)
end
if (c == '/') then
	print (a..'/'..b..'='..a/b)
end

