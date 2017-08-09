--Калькулятор версия 0.01 alpha
--Автор: Кирилл Смиренко

require('iuplua')
require('iupluacontrols')
iup.SetLanguage('ENGLISH')

function butt_1()
	if txt.value == '0' then
		txt.value = ''
	end
	txt.value = txt.value .. "1"
	return
end
function butt_2()
	if txt.value == '0' then
		txt.value = ''
	end
	txt.value = txt.value .. "2"
	return
end
function butt_3()
	if txt.value == '0' then
		txt.value = ''
	end
	txt.value = txt.value .. "3"
	return
end
function butt_4()
	if txt.value == '0' then
		txt.value = ''
	end
	txt.value = txt.value .. "4"
	return
end
function butt_5()
	if txt.value == '0' then
		txt.value = ''
	end
	txt.value = txt.value .. "5"
	return
end
function butt_6()
	if txt.value == '0' then
		txt.value = ''
	end
	txt.value = txt.value .. "6"
	return
end
function butt_7()
	if txt.value == '0' then
		txt.value = ''
	end
	txt.value = txt.value .. "7"
	return
end
function butt_8()
	if txt.value == '0' then
		txt.value = ''
	end
	txt.value = txt.value .. "8"
	return
end
function butt_9()
	if txt.value == '0' then
		txt.value = ''
	end
	txt.value = txt.value .. "9"
	return
end
function butt_0()
	if txt.value == '0' then
		txt.value = ''
	end
	txt.value = txt.value .. "0"
	return
end
function butt_Bs()
	txt.value = string.sub(txt.value,1,string.len(txt.value)-1)
	if txt.value == '' then
		butt_0()
	end
	return
end
function butt_d()
	txt.value = txt.value .. "."
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
		a = a+b
	elseif z == '-' then
		a = a-b
	elseif z == '*' then
		a = a*b
	elseif z == '/' then
		a = a/b
	end
	txt.value = a
end

txt = iup.text{value=''; SIZE='128x12', ALIGNMENT="ARIGHT"}
calc = iup.dialog
{
	iup.vbox
	{
		txt,
		iup.hbox
		{
			iup.button{title='Backspace'; action=butt_Bs}
		},
		iup.hbox
		{
			iup.button{title='1';SIZE='32x24', action= butt_1},
			iup.button{title='2';SIZE='32x24', action= butt_2},
			iup.button{title='3';SIZE='32x24', action= butt_3},
			iup.button{title='+';SIZE='32x24', action= butt_pl},
		},
		iup.hbox
		{
			iup.button{title='4';SIZE='32x24', action= butt_4},
			iup.button{title='5';SIZE='32x24', action= butt_5},
			iup.button{title='6';SIZE='32x24', action= butt_6},
			iup.button{title='-';SIZE='32x24', action= butt_mn},
		},
		iup.hbox
		{
			iup.button{title='7';SIZE='32x24', action= butt_7},
			iup.button{title='8';SIZE='32x24', action= butt_8},
			iup.button{title='9';SIZE='32x24', action= butt_9},
			iup.button{title='*';SIZE='32x24', action= butt_ym},
		},
		iup.hbox
		{
			iup.button{title='0';SIZE='32x24', action= butt_0},
			iup.button{title='.';SIZE='32x24', action= butt_d},
			iup.button{title='=';SIZE='32x24', action= butt_eq},
			iup.button{title='/';SIZE='32x24', action= butt_dl},
		}
	}
	;title='Калькулятор',font='Courier New, Bold 20'

}
--iup.Mask(txt,IUPMASK_FLOAT,1,1)
calc:show()
butt_0()
if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end
