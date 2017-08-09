require "iupx"

math.randomseed (os.time())

--function cregr(plot)
plot = iupx.pplot {TITLE = "График", AXS_BOUNDS={0,0,300,300}}
plot:AddSeries ({{math.random(1,300),math.random(1,300)},{math.random(1,300),math.random(1,300)},{math.random(1,300),math.random(1,300)},{math.random(1,300),math.random(1,300)}})
plot:AddSeries ({{40,40},{50,55},{60,60},{70,65}})
plot:AddSeries ({{4,20},{54,49},{90,90},{90,95}})

plot2 = iupx.pplot {TITLE = "График", AXS_BOUNDS={0,0,300,300}}
plot2:AddSeries ({{math.random(1,300),math.random(1,300)},{math.random(1,300),math.random(1,300)},{math.random(1,300),math.random(1,300)},{math.random(1,300),math.random(1,300)}})
plot2:AddSeries ({{40,40},{50,55},{60,60},{70,65}})
plot2:AddSeries ({{4,20},{54,49},{90,90},{90,95}})

plot3 = iupx.pplot {TITLE = "График", AXS_BOUNDS={0,0,300,300}}
plot3:AddSeries ({{math.random(1,300),math.random(1,300)},{math.random(1,300),math.random(1,300)},{math.random(1,300),math.random(1,300)},{math.random(1,300),math.random(1,300)}})
plot3:AddSeries ({{40,40},{50,55},{60,60},{70,65}})
plot3:AddSeries ({{4,20},{54,49},{90,90},{90,95}})

plot4 = iupx.pplot {TITLE = "График", AXS_BOUNDS={0,0,300,300}}
plot4:AddSeries ({{math.random(1,300),math.random(1,300)},{math.random(1,300),math.random(1,300)},{math.random(1,300),math.random(1,300)},{math.random(1,300),math.random(1,300)}})
plot4:AddSeries ({{40,40},{50,55},{60,60},{70,65}})
plot4:AddSeries ({{4,20},{54,49},{90,90},{90,95}})
--return
--end
--[[plot2 = iupx.pplot {TITLE = "График", AXS_BOUNDS={0,0,100,100}}
plot2:AddSeries ({{0,0},{10,10},{20,30},{30,45}})
plot2:AddSeries ({{40,40},{50,55},{60,60},{70,65}})
plot2:AddSeries ({{4,20},{54,49},{90,90},{90,95}})]]

--cregr(plot)
--cregr(plot2)

iupx.show_dialog{
	iup.vbox{
	iup.hbox
	{
	iup.button{title = 'Сгенерировать'; action = aaa}--"plot:AddSeries ({{14,20},{14,49},{10,90},{10,95}});plot.REDRAW = 1"}
	},
	plot,
	plot2
	,
	iup.hbox
	{
	plot3,
	plot4
	}}; title="График",size="QUARTERxQUARTER"}

--dlg:show()
function aaa()

return
end


if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end
