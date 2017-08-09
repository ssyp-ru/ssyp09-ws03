--vars
s = 'михаил витальевич братусь'

function WordUp (Word)
	if word == nil then
		return "Ќет параметра"
	end
	io.write (string.char (string.byte (Word,1)-32))
	return (string.sub (Word,2,string.len(Word)))
end

--script

for i = 1, string.len(s) do
	if string.byte(s,i) == 32 then
		io.write (string.char(32))
		j0 = i + 1
		j = i + 2
		repeat
			j = j + 1
		until string.byte(s,j) == 32
	io.write (WordUp(string.sub(s,j0,j - 1)))
	end
end


print (WordUp('кирилл'))
