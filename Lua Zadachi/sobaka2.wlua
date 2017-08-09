--Илья Насибулов и Павел Смирнов  03.07.09    Числа v1.0
require ("iuplua")
require( "iupluacontrols")
iup.SetLanguage("ENGLISH") --чтобы конпки в Alarm были по-английски

c,d,z,p = 0,0,0,10
math.randomseed (os.time()) --чтобы random выдавало всегда случайное число
math.random () --пропустим первое случайное число
a = math.random (1,9)
b = math.random (1,9)
x = math.random (1,9)

function goodbye2()
	s = iup.Alarm("Игра","У вас кончились попытки","Сыграть ещё","Выход")
	if s == 1 then
		p = 10
		math.randomseed (os.time())
		math.random ()
		a = math.random (1,9)
		b = math.random (1,9)
		x = math.random (1,9)
		game()
		else
		goodbye()
	end
	return
end

function chisla()
	local c,d,z
	if p == 0 then
		goodbye2()
	end
	ret,c,d,z = iup.GetParam ("Игра", nil,
    "Выберите первое число: %l|1|2|3|4|5|6|7|8|9|\n"..
	"Выберите второе число: %l|1|2|3|4|5|6|7|8|9|\n"..
	"Выберите третье число: %l|1|2|3|4|5|6|7|8|9|\n",0,0,0)
	if ret == 0 then
		goodbye()
	end
	return c+1, d+1, z+1
end

function goodbye()
	iup.Message("Игра","Пока")
	os.exit(0)
	return
end

function game()
c,d,z = chisla()
e = iup.Alarm ("Игра","Вы ввели числа "..c..", "..d..' и '..z,"Согласен","Ввести заново","Выход")
if (e == 0) then
	goodbye()
end
if (e == 1) then
	p = p-1
	gem()
end
if (e == 2) then
	game()
end
if (e == 3) then
	goodbye()
end
return
end

function gem()
	if c == a and d == b and x == z then
		iup.Message ("Игра","Вы ВЫИГРАЛИ!\nВы использовали попыток:"..10-p)
		t = iup.Alarm ("Игра","Хотите сыграть ещё?","Да, конечно","Нет, чуть позже")
		if t == 1 then
			math.randomseed (os.time())
			math.random ()
			a = math.random (1,9)
			b = math.random (1,9)
			x = math.random (1,9)
			game()
			else
			goodbye()
		end
	end
	if (c == a and d ~= b and z ~= x) or (c ~= a and d == b and z ~= x) or (c ~= a and d ~= b and z == x) then
		iup.Message ("Игра","Вы угадали только одно число и вы угадали, где оно находится")
		game()
	end
	if (a == d and b == c and x == z) or (a == z and b == d and x == c) or (a == c and b == z and x == d) then
		iup.Message ("Игра","Вы угадали три числа, но два из них стоят не на своих местах")
		game()
	end
		if (a == c and b == d and x ~= z) or (a == c and b ~= d and x == z) or (a ~= c and b == d and x == z) then
		iup.Message ("Игра","Вы угадали два числа и угадали, где они находятся")
		game()
	end
	if a == d or a == z or b == c or b == z then
		iup.Message ("Игра","Вы угадали одно число, но не угадали, где оно находится")
		game()
	end
	if 	   (a == c and b == z and x ~= d)
		or (a == c and b ~= z and x == d)
		or (a == z and b == d and x ~= c)
		or (a ~= c and b == z and x == d)
		or (a == d and b ~= c and x == z)
		or (a ~= d and b == c and x == z) then
		iup.Message ("Игра","Вы угадали два числа и где находится одно из них")
		game()
	end
	if (a == d and b == c and x ~= z) or (a == z and b ~= d and x == c) or (a ~= c and b == z and x == d) then
		iup.Message ("Игра","Вы угадали два числа, но не угадали, где они находятся")
		game()
	else
		iup.Message ("Игра","Вы не угадали ни одного числа")
		game()
	end
return
end

game()
