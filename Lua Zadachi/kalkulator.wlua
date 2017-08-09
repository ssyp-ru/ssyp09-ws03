--калькулятор v0.003 alpha Насибулов Илья
--03.07.09
--04.07.09

require('iuplua')
require('iupluacontrols')

function but1()
	ind.value = ind.value..'1'
	return
end

function but2()
	ind.value = ind.value..'2'
	return
end

function but3()
	ind.value = ind.value..'3'
	return
end

function but4()
	ind.value = ind.value..'4'
	return
end

function but5()
	ind.value = ind.value..'5'
	return
end

function but6()
	ind.value = ind.value..'6'
	return
end

function but7()
	ind.value = ind.value..'7'
	return
end

function but8()
	ind.value = ind.value..'8'
	return
end

function but9()
	ind.value = ind.value..'9'
	return
end

function but0()
	ind.value = ind.value..'0'
	return
end

function butbackspace()
	ind.value = string.len(ind.value)-1
	return
end

function buttochka()
	ind.value = ind.value..','
	return
end

function butplus()
	ind.value = ind.value..'0'
	return
end

function butminus()
	ind.value = ind.value..'0'
	return
end

function butumn()
	ind.value = ind.value..'0'
	return
end

function butdel()
	ind.value = ind.value..'0'
	return
end

function butsqrt()
	ind.value = math.sqrt(ind.value)
	return
end

function butpm()
	if (ind.value < 0) then
		ind.value = ind.value - ind.value - ind.value
		else
			ind.value = ind.value + ind.value + ind.value
	end
	return
end

ind = iup.text{value = '0,';SIZE = '150x15y', alignment = 'ARIGHT'}
--iup.MaskSet (ind.text,IUPMASK_FLOAT,1,0)
dlg = iup.dialog
{
	iup.vbox
	{	ind,
		iup.hbox
		{
			iup.button{title = 'Backspace';SIZE = '75x20y'; action = butbackspace},
			iup.button{title = 'C';SIZE = '75x20y'}
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
			iup.button{title = '+/-'; SIZE = '30x20y'},
			iup.button{title = ','; SIZE = '30x20y', action = buttochka},
			iup.button{title = '+'; SIZE = '30x20y', action = butplus},
			iup.button{title = '=';SIZE = '30x20y'}
		}
	}
	;title="Calc", font="Arial, Bold 14"
}

dlg:show()

if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end
