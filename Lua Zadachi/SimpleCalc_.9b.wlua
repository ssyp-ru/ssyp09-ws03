--SimpleCalc версия 0.9 beta

require('iuplua')
require('iupluacontrols')
iup.SetLanguage('ENGLISH')

function newnum()
	if txt.value == '0' then
		new = 1
	end
	if new == 1 then
		txt.value = ''
		new = 0
	end
end

function butt_1()
	newnum()
	txt.value = txt.value .. '1'
	return
end
function butt_2()
	newnum()
	txt.value = txt.value .. "2"
	return
end
function butt_3()
	newnum()
	txt.value = txt.value .. "3"
	return
end
function butt_4()
	newnum()
	txt.value = txt.value .. "4"
	return
end
function butt_5()
	newnum()
	txt.value = txt.value .. "5"
	return
end
function butt_6()
	newnum()
	txt.value = txt.value .. "6"
	return
end
function butt_7()
	newnum()
	txt.value = txt.value .. "7"
	return
end
function butt_8()
	newnum()
	txt.value = txt.value .. "8"
	return
end
function butt_9()
	newnum()
	txt.value = txt.value .. "9"
	return
end
function butt_0()
	newnum()
	txt.value = txt.value .. "0"
	return
end

function butt_d()
	if string.find (txt.value,'.',1,true) then
		return
	end
	txt.value = txt.value .. '.'
	return
end

function butt_pl()
	z = '+'
	a = txt.value
	txt.value = '0'
end
function butt_mn()
	z = '-'
	a = txt.value
	txt.value = '0'
end
function butt_ym()
	z = '*'
	a = txt.value
	txt.value = '0'
end
function butt_dl()
	z = '/'
	a = txt.value
	txt.value = '0'
end

function butt_eq()
	b = txt.value
	if z == '+' then
		c = a+b
	elseif z == '-' then
		c = a-b
	elseif z == '*' then
		c = a*b
	elseif z == '/' then
		c = a/b
	end
	txt.value = c
	new = 1
end

function butt_Bs()
	txt.value = string.sub(txt.value,1,string.len(txt.value)-1)
	if txt.value == '' then
		butt_0()
	end
	return
end
function butt_CE()
	a = nil
	z = nil
	b = nil
	txt.value = 0
end
function butt_C()
	txt.value = '0'
end
txt = iup.text{value=''; SIZE='120x12', ALIGNMENT="ARIGHT"}
calc = iup.dialog
{
	iup.vbox
	{
		txt,
		iup.hbox
		{
			iup.button{title='Backspace'; SIZE='50x22', action=butt_Bs},
			iup.button{title='CE'; SIZE='35x22', action=butt_CE},
			iup.button{title='C'; SIZE='35x22', action=butt_C},
		},
		iup.hbox
		{
			iup.button{title='1';SIZE='30x22', action= butt_1},
			iup.button{title='2';SIZE='30x22', action= butt_2},
			iup.button{title='3';SIZE='30x22', action= butt_3},
			iup.button{title='+';SIZE='30x22', action= butt_pl},
		},
		iup.hbox
		{
			iup.button{title='4';SIZE='30x22', action= butt_4},
			iup.button{title='5';SIZE='30x22', action= butt_5},
			iup.button{title='6';SIZE='30x22', action= butt_6},
			iup.button{title='-';SIZE='30x22', action= butt_mn},
		},
		iup.hbox
		{
			iup.button{title='7';SIZE='30x22', action= butt_7},
			iup.button{title='8';SIZE='30x22', action= butt_8},
			iup.button{title='9';SIZE='30x22', action= butt_9},
			iup.button{title='*';SIZE='30x22', action= butt_ym},
		},
		iup.hbox
		{
			iup.button{title='0';SIZE='30x22', action= butt_0},
			iup.button{title='.';SIZE='30x22', action= butt_d},
			iup.button{title='=';SIZE='30x22', action= butt_eq},
			iup.button{title='/';SIZE='30x22', action= butt_dl},
		}
	}
	;title='SimpleCalc',font='Courier New, Bold 20'

}
--iup.Mask(txt,IUPMASK_FLOAT,1,1)
calc:show()
butt_0()
if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end
