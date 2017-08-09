--"Код к сейфу" версия 0.1
--03.07.09

require('iuplua')
require('iupluacontrols')

n = nil
p = nil
y = nil
v = nil
str = ''
m = {}
r = {}
z = {}

function skilllevel()
b = iup.Alarm("Код к сейфу: уровень сложности", "Выберите уровень сложности" ,"простой" ,"средний" ,"сложный")

if b == 1 then
	return 2
elseif b == 2 then
	return 3
elseif b == 3 then
	return 4
end
end

function randomnums()
	for i = 1, n do
		local j = math.random(table.maxn(z))
		r[i] = z[j]
		table.remove(z,j)
		iup.Message('CHEAT','Нужное число - '..r[i])
	end
end

function guessing ()
	if p == 0 then
		iup.Message('Код к сейфу: проигрыш','Вы проиграли, попытки кончились! Попробуйте еше раз!')
		os.exit(0)
	end
	ret,str = iup.GetParam('Код к сейфу: ввод',nil,'Введите '..n..' разных числа с 0 по 9 (без пробелов или символов разделения). %s\n','')
	for i = 1, n do
		m[i] = 0+string.sub(str,i,i)
		iup.Message('CHEAT','Распознанное число - '..m[i])
	end
	y = 0
	v = 0
	for i = 1, n do
		for j = 1, n do
			if m[i] == r[j] then
				y = y + 1
			end
		end
	end
	for i = 1,n do
		if m[i] == r[i] then
			v = v + 1
		end
	end
	if v == n then
		iup.Message('Код к сейфу: победа','Вы угадали код и ПОБЕДИЛИ!')
		os.exit(0)
	else
		p = p-1
		iup.Message('Код к сейфу: результат','Текущий результат:\n\nВы угадали '..y..' чисел.\nИз них '..v..' стоят на своем месте.\nОсталось попыток: '..p..'.')
	end
	guessing()
end

math.randomseed(os.time())
math.random()
math.random()
n = skilllevel()
p = n * 10
iup.Message('Код к сейфу: приветствие', 'Добро пожаловать в игру "Код к сейфу".\nВам нужно будет угадать '..n..'-значный код.')
z = {0,1,2,3,4,5,6,7,8,9}
randomnums()
guessing(p)
