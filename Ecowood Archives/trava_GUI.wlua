require( "iuplua" )
require( "iupluacontrols" )


function cycle()
	if day == nil then
		iup.Message('Ошибка','Нет травы; выберите "начать новое наблюдение".')
		return
	end
	io.write('\n\n--------\nДень '..day..'\n--------\n')
	for k = 1, table.maxn(trava) do
		trava_zhivi(trava[k])
	end
	day = day + 1
	return
end
function exit()
	os.exit(0)
	return
end
function logging(text)
	log.value = log.value..text
	return
end
io.write = logging
function clean_log()
	log.value = ''
	return
end

net = iup.matrix {numcol=10, numlin=10,numcol_visible=10, numlin_visible=10, widthdef=34, border='yes'}
log = iup.multiline{value=''; SIZE='300x100'}
st = iup.multiline{value=''; SIZE='100x50'}
tgui = iup.dialog
{
	iup.vbox
	{
		iup.hbox
		{
			iup.button{title='След. цикл'; SIZE='70x15', action=cycle},
			iup.button{title='Очистить лог'; size='90x15', action=clean_log},
			iup.button{title='Выход'; SIZE='50x15', action=exit},
		},
		net,
		iup.hbox
		{
			log,
			st
		}
	}
	;title='Жизнь травы (GUI)'
}
tgui:show()
if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end

------------------program------------------

trava = {}
eda_v_poch = 15
day = 1

function create_grass(num,p4,p5,p6,p8,p10,p11)
trava[num] = {}
trava[num].name = 'Трава-'..num
trava[num].zhiv = true
trava[num].vozrast = 0
trava[num].max_vozrast = p4
trava[num].cikl_pit = p5
trava[num].ed_pit = p6
trava[num].sitost = 1
trava[num].cikl_razmn = p8
trava[num].do_razmn = 30
trava[num].sem = p10
trava[num].vr_razl = p11
trava[num].razl = false
end

function check_die(t)
	if t.vozrast >= t.max_vozrast then
		t.zhiv = false
		io.write('\n'..t.name..' умерла.\n')
		return
	end
end

function info(t)
	io.write ('\n'..t.name..'\n')
	io.write ("Возраст - "..t.vozrast..'\n')
	io.write ("Осталось жить - "..t.max_vozrast - t.vozrast..'\n')
	io.write ("Сытость - "..t.sitost..'\n')
end

function eda(t)
	if t.sitost < 1 then
		io.write('Сегодня день питания.\n')
		io.write('Еды в почве - '..eda_v_poch..'\n')
		if eda_v_poch > 0 then
			eda_v_poch = eda_v_poch - t.ed_pit
			t.sitost = t.cikl_pit
			io.write('Осталось еды в почве - '..eda_v_poch..'\n')
		else
			t.zhiv = false
			io.write(t.name..' умерла.\n')
		end
	end
end

function razmn(t)
	if (t.do_razmn < 1) and (t.sem > 0) then
		io.write('Сегодня день размножения.\n')
		for j = 1, t.sem do
			create_grass(table.maxn(trava)+1,math.random(45,65),math.random(8,10),1,math.random(21,35),math.random(1,2),math.random(2,4))
		end
		io.write('Воспроизвёл потомков: '..t.sem..'\n')
		t.do_razmn = t.cikl_razmn
	end
end

function param(t)
	t.vozrast = t.vozrast + 1
	t.sitost = t.sitost - 1
	t.do_razmn = t.do_razmn - 1
end

function die(t)
	if not t.razl then
		if t.vr_razl >= 0 then
			t.vr_razl = t.vr_razl - 1
		else
			eda_v_poch = eda_v_poch + 2 + t.vozrast
			io.write(t.name..' разложилась.\nСтало еды в почве: '..eda_v_poch..'\n')
			t.razl = true
		end
	end
end

function trava_zhivi(t)
	if t.zhiv then
		check_die(t)
		info(t)
		eda(t)
		razmn(t)
		param(t)
	else
		die(t)
	end
	return
end


create_grass(1,65,9,1,28,2,3)
