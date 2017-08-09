--Илья Насибулов и Павел Смирнов  03.07.09    Числа v1.0
require ("iuplua")
require( "iupluacontrols")
c,d,p = 0,0,10
math.randomseed (os.time())
math.random ()
a = math.random (1,9)
b = math.random (1,9)

function goodbye2()
	s = iup.Alarm("Игра","У вас кончились попытки","Сыграть ещё","Выход")
	if s == 1 then
		p = 10
		math.randomseed (os.time())
		math.random ()
		a = math.random (1,9)
		b = math.random (1,9)
		game()
		else
		goodbye()
	end
	return
end

function chisla()
	local c,d
	if p == 0 then
		goodbye2()
	end
	ret,c,d = iup.GetParam ("Игра", nil,
    "Выберите первое число: %l|1|2|3|4|5|6|7|8|9|\n"..
	"Выберите второе число: %l|1|2|3|4|5|6|7|8|9|\n",0,0)
	if ret == 0 then
		goodbye()
	end
	return c+1, d+1
end

function goodbye()
	iup.Message("Игра","Пока")
	os.exit(0)
	return
end

function game()
c,d = chisla()
e = iup.Alarm ("Игра","Вы ввели числа "..c.." и "..d,"Согласен","Ввести заново","Выход")
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
	if c == a and d == b then
		iup.Message ("Игра","Вы ВЫИГРАЛИ!")
		t = iup.Alarm ("Игра","Хотите сыграть ещё?","Да, конечно","Нет, чуть позже")
		if t == 1 then
			math.randomseed (os.time())
			math.random ()
			a = math.random (1,9)
			b = math.random (1,9)
			game()
			else
			goodbye()
		end
	end
	if c == a and d ~= b or c ~= a and d == b then
		iup.Message ("Игра","Вы угадали только одно число и вы угадали, где оно находится")
		game()
	end
	if a == d and b == c then
		iup.Message ("Игра","Вы угадали оба числа, но не угадали, где они находятся")
		game()
	end
	if a == d or b == c then
		iup.Message ("Игра","Вы угадали одно число, но не угадали, где оно находится")
		game()
	else
		iup.Message ("Игра","Вы не угадали ни одного числа")
		game()
	end
return
end

game()
