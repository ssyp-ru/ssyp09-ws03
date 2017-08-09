require ("iupx")
require ("iuplua")
math.randomseed(os.time())
plot = iupx.pplot {TITLE = "Действие кризиса за последнюю неделю", AXS_BOUNDS={0,0,100,100}}
plot:AddSeries ({{math.random(0,100)},{math.random(0,100)},{math.random(0,100)}})
plot:AddSeries ({{math.random(0,100)},{math.random(0,100)},{math.random(0,100)}})
plot:AddSeries ({{math.random(0,100)},{math.random(0,100)},{math.random(0,100)}})
plot:AddSeries ({{math.random(0,100)},{math.random(0,100)},{math.random(0,100)}})
plot:AddSeries ({{math.random(0,100)},{math.random(0,100)},{math.random(0,100)}})
iupx.show_dialog{plot; title="Easy Plotting",size="QUARTERxQUARTER"}
