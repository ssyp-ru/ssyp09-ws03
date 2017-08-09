--калькулятор v0.04 beta Насибулов Илья
--03.07.09
--04.07.09

require('iuplua')
require('iupluacontrols')

function dobkn(a)
	if (ind.value == '0') then
		ind.value = a
		else ind.value = ind.value..a
	end
	return
end

function but1()
	dobkn(1)
	return
end

function but2()
	dobkn(2)
	return
end

function but3()
	dobkn(3)
	return
end

function but4()
	dobkn(4)
	return
end

function but5()
	dobkn(5)
	return
end

function but6()
	dobkn(6)
	return
end

function but7()
	dobkn(7)
	return
end

function but8()
	dobkn(8)
	return
end

function but9()
	dobkn(9)
	return
end

function but0()
	dobkn(0)
	return
end

function butbackspace()
	if ind.value == '' or ind.value == '0' then
	ind.value = '0'
	else ind.value = string.sub(ind.value,1,string.len(ind.value)-1)
	end
	if (string.len (ind.value) == 0) then
	ind.value = '0'
	end
	return
end

function buttochka()
	if string.find (ind.value, '.',1, true) then
		return
	end
	ind.value = ind.value..'.'
	return
end

function butplus()
	plus = ind.value
	ind.value = ''
	return
end

function butminus()
	minus = ind.value
	ind.value = ''
	return
end

function butumn()
	umn = ind.value
	ind.value = ''
	return
end

function butdel()
	del = ind.value
	ind.value = ''
	return
end

function butsqrt()
	ind.value = math.sqrt(0+ind.value)
	return
end

function butC()
	ind.value = '0'
	return
end
function butravno()
	if (plus ~= nil) then
	ravno = ind.value
	ind.value = plus + ravno
	end
		if (minus ~= nil) then
	ravno = ind.value
	ind.value = minus - ravno
	end
		if (umn ~= nil) then
	ravno = ind.value
	ind.value = umn * ravno
	end
		if (del ~= nil) then
	ravno = ind.value
	ind.value = del / ravno
	end
	plus = nil
	minus = nil
	umn = nil
	del = nil
	return
end

ind = iup.text{value = '0';SIZE = '150x15y', alignment = 'ARIGHT'}
--iup.MaskSet (ind.text,IUPMASK_FLOAT,1,0)
dlg = iup.dialog
{
	iup.vbox
	{	ind,
		iup.hbox
		{
			iup.button{title = 'Backspace';SIZE = '75x20y'; action = butbackspace},
			iup.button{title = 'C';SIZE = '75x20y'; action = butC}
		},
		iup.hbox
		{
			iup.button{title = '7';SIZE = '30x20y'; action = but7},
			iup.button{title = '8';SIZE = '30x20y'; action = but8},
			iup.button{title = '9';SIZE = '30x20y'; action = but9},
			iup.button{title = '/';SIZE = '30x20y'; action = butdel},
			iup.button{title = 'sqrt';SIZE = '30x20y'; action = butsqrt}
		},
		iup.hbox
		{
			iup.button{title = '4';SIZE = '30x20y'; action = but4},
			iup.button{title = '5';SIZE = '30x20y'; action = but5},
			iup.button{title = '6';SIZE = '30x20y'; action = but6},
			iup.button{title = '*';SIZE = '30x20y'; action = butumn},
			iup.button{title = '%';SIZE = '30x20y'}
		},
		iup.hbox
		{
			iup.button{title = '1';SIZE = '30x20y'; action = but1},
			iup.button{title = '2';SIZE = '30x20y'; action = but2},
			iup.button{title = '3';SIZE = '30x20y'; action = but3},
			iup.button{title = '-';SIZE = '30x20y'; action = butminus},
			iup.button{title = '1/x';SIZE = '30x20y'}
		},
		iup.hbox
		{	iup.button{title = '0'; SIZE = '30x20y'; action = but0},
			iup.button{title = '+/-'; SIZE = '30x20y'; action = butpm},
			iup.button{title = ','; SIZE = '30x20y', action = buttochka},
			iup.button{title = '+'; SIZE = '30x20y', action = butplus},
			iup.button{title = '=';SIZE = '30x20y'; action = butravno}
		}
	}
	;title="Calc", font="Arial, Bold 14"
}

dlg:show()

if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end
