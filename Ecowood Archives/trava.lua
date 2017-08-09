trava = {}

giv = 1
um = 0
cic = 0
function zarozhd_travki()
	local i = table.maxn(trava) + 1
	trava[i] = {}
	trava[i].sitost = 1
	trava[i].vozrast = 0
	trava[i].max_vozrast = 40
	trava[i].cikl_pit = 6
	trava[i].ed_pit = 1
	trava[i].razmnozh = 30
	trava[i].cikl_razmnozh = 30
	trava[i].zhiv = true
	trava[i].x = 1
	trava[i].y = 1
--trava[i].cikl = 0
	return
end


function trava_zhivi(t,c)
	if t.zhiv == false then
		return
		else print ("Я трава "..c)
	end
	if (t.sitost == 0 and eda_v_poch == 0) or (t.vozrast >= t.max_vozrast) then
		print ("Трава умерла")
		eda_v_poch = eda_v_poch + 3
		um = um + 1
		giv = giv - 1
		t.zhiv = false
		return

	elseif (t.sitost == 0 and eda_v_poch ~= 0) then
		t.sitost = t.cikl_pit
		eda_v_poch = eda_v_poch - t.ed_pit
		print("Трава покушала")
	end
	if (t.razmnozh == 0) then
		--table.maxn(trava) = table.maxn(trava) + 1
		print ("Трава размножилась")
		math.randomseed(os.time())
		for p = 1,math.random(3) do
		zarozhd_travki()
		giv = giv + 1
		end
		t.razmnozh = t.cikl_razmnozh
	end
	t.vozrast = t.vozrast + 1
	t.sitost = t.sitost-1
	t.razmnozh = t.razmnozh - 1
	print ("Возраст - "..t.vozrast-1)
	print ("Осталось жить - "..t.max_vozrast - t.vozrast+1)
	print ("До потребления еды осталось "..t.sitost.." циклов")
	print ("Едениц еды осталось в почве:"..eda_v_poch)
	print ("До следующего размножения осталось "..t.razmnozh.." циклов")
	print ()
	return
end

function zhizn()
	cic = cic + 1
	print ("Цикл: "..cic)
	print ("Живые: "..giv)
	print ("Мертвы: "..um)
	for c = 1,table.maxn(trava) do
	trava_zhivi(trava[c],c)
	end
	--zhizn()
	return
end


eda_v_poch = 5
zarozhd_travki()
while true do
	zhizn()
end
