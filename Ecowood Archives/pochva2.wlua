require ("iuplua")
require ("iupluacontrols")
math.randomseed(os.time())

trava = {}
--eda_v_poch = 10
giv = 1
um = 0
cic = 0

function trav ()


function trava_zhivi(t,c)
	if t.zhiv == false then
		return
		else pr = ""
		printin(pr)
		pr = "Я трава " .. c .. " (" .. t.x .. "," .. t.y .. ")"
		printin(pr)
	end
	if (t.sitost == 0 and tgumus[t.x][t.y] == 0) or (t.vozrast >= t.max_vozrast) then
		pr = "Трава умерла"
		printin(pr)
		tgumus[t.x][t.y] = tgumus[t.x][t.y] + 3
		iup.SetFocus(pochva)
		pochva:setcell(t.y,t.x,tgumus [t.x][t.y])
		um = um + 1
		giv = giv - 1
		t.zhiv = false
		return

	elseif (t.sitost == 0 and tgumus[t.x][t.y] ~= 0) then
		t.sitost = t.cikl_pit
		tgumus[t.x][t.y] = tgumus[t.x][t.y] - t.ed_pit
		pochva:setcell(t.y,t.x,tgumus [t.x][t.y])
		pr = "Трава покушала"
		printin(pr)
	end
	if (t.razmnozh == 0) then
		--table.maxn(trava) = table.maxn(trava) + 1
		pr = "Трава размножилась"
		printin(pr)
		math.randomseed(os.time())
		for p = 1,math.random(3) do

			local nx = math.random(t.x-1,t.x+1)
			if nx<1 then nx = 1 end
			if nx>10 then nx = 10 end

			local ny = math.random(t.y-1,t.y+1)
			if ny<1 then ny = 1 end
			if ny>10 then ny = 10 end

		zarozhd_travki(nx,ny)
--		zarozhd_travki(math.random(1,10),math.random(1,10))
		giv = giv + 1
		end
		t.razmnozh = t.cikl_razmnozh
	end
	t.vozrast = t.vozrast + 1
	t.sitost = t.sitost-1
	t.razmnozh = t.razmnozh - 1
	pr = "Возраст: "..t.vozrast-1
	printin(pr)
	pr = "Осталось жить:"..t.max_vozrast - t.vozrast+1
	printin(pr)
	pr = "До потребления еды осталось "..t.sitost + 1 .." циклов"
	printin(pr)
	pr = "Едениц еды осталось в почве:"..tgumus[t.x][t.y]
	printin(pr)
	pr = "До следующего размножения осталось "..t.razmnozh + 1 .." циклов\n"
	printin(pr)
	pochva:setcell(t.y,t.x,tgumus [t.x][t.y] .. " tr")
	return
end

function zhizn()
	cic = cic + 1
	pr = "Цикл: "..cic.."\nЖивые: "..giv.."\nМертвы: "..um
	printin2(pr)
	for c = 1,table.maxn(trava) do
	trava_zhivi(trava[c],c)
	end
	--zhizn()
	return
end


	zhizn()
end
-- конец травы-----------------------------------------------------------------------------------------
pochva_m = {}
function exit()
	os.exit(0)
	return
end

--Создает новую ТРАВУ по координатам х,у
function zarozhd_travki(x,y)
	local i = table.maxn(trava) + 1
	trava[i] = {}
	trava[i].sitost = 1
	trava[i].vozrast = 0
	trava[i].max_vozrast = 40
	trava[i].cikl_pit = 5
	trava[i].ed_pit = 1
	trava[i].razmnozh = 1
	trava[i].cikl_razmnozh = 1
	trava[i].zhiv = true
	trava[i].x = x
	trava[i].y = y
	return
end

-- создадим 1 травку в начале. вызвав функцию со случайными координатами Х У
zarozhd_travki(math.random(1,10),math.random(1,10))


function printin(pr)
	log1.value = log1.value..'\n'..pr
	return
end

function printin2(pr)
	log2.value =pr
	return
end

function one_cikl()
	trav ()
	pochva.redraw = "ALL"
	return
end

function ten_cikl()
	for z = 1,10 do
	trav ()
	pochva.redraw = "ALL"
	end
	return
end

function ochistka()
log1.value = ''
end

pochva = iup.matrix {numcol=10, numlin=10,numcol_visible=10, numlin_visible=10, widthdef=35}
log1 = iup.multiline {SIZE = "250x300"}
log2 = iup.multiline {SIZE = "100x100"}

dlg = iup.dialog
{
	iup.vbox
	{
		iup.hbox
		{
			iup.button {title = "Один цикл", action = one_cikl},
			iup.button {title = "Десять циклов", action = ten_cikl},
			iup.button {title = "Очистить", action = ochistka},
			iup.button {title = "Выход", action = exit}
		},
		pochva,
		iup.hbox
		{
			log1,
			log2
		}
	}
	;title='Эколес', SIZE=""
}

pochva.resizematrix = "YES"
for i = 0,10 do
	pochva:setcell(i,0,i)
end
for i = 0,10 do
	pochva:setcell(0,i,i)
end

tgumus = {}
for i = 1,10 do
	tgumus[i] = {}
	for j = 1,10 do
		tgumus[i][j] = math.random(10,20) --Заносим случайную величину удобрений
		pochva:setcell(j,i,tgumus [i][j]) --Отображаем величину удобрений на матрице
	end
end

--dlg = iup.dialog{iup.vbox{pochva; margin="10x10"}}
dlg:showxy(iup.CENTER, iup.CENTER)

if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end
