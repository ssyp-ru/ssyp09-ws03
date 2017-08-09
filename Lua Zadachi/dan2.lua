--[[ Даниил
-- Нужно вывести заданную строку текста
-- задом наперед

-- дано
s = "Выведи меня задом наперед!"

-- Функция   string.sub(СТРОКА, А , Б)
-- возвращает кусочек строки с символа А по символ Б

-- Функция   string.len(СТРОКА)
-- возвращает количество букв в СТРОКЕ
a = "АБВГДЕЖЗ"
print ( string.sub(a, 3 , 5) )
print ( "В строке " .. string.len(a) .. " букв")

------- тут пиши]]
s="Выведи меня задом наперед!"
--print(" в строке ".. string.len(a).." букв")
--io.write(string.sub(s, 1(string.len(s)), ))
for b=(string.len(s)),1,-1 do
io.write (string.sub(s, b, b))
end
print("---")
for b=1,(string.len(s)),2 do
io.write (string.sub(s, b, b))
end


m={1,8,78,45,76,23,65,123,5}
print(table.maxn(m))
for i=1,(table.maxn(m)) do
print(m[i])
	if m[i]/2 == math.ceil(m[i]/2) then
		print ("Чет")
	else
		print ("неЧет")
	end
end
