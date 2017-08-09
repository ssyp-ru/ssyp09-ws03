--"Тест" версия 0.2
--03.07.09

require('iuplua')
require('iupluacontrols')
res = 0
function act1()

	my_ecran.value = my_ecran.value .. "1"
	return
end

dlg = iup.dialog
{
	iup.sbox
	{
  iup.vbox
  {
    iup.button{title="Button Very Long Text 1"; action = act1},
    iup.hbox
	{
		iup.button{title="short"},
		iup.button{title="BUTTON 4"}
	},
	iup.text{value="???"},
    iup.button{title="Mid Button"}
  }
  }
  ;title="IupDialog", font="Arial, Bold 14"
}
dlg:show()


if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end
