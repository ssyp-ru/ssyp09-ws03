require( "iuplua" )
require( "iupluacontrols" )

res, name = iup.GetParam("Title", "Ћюбой",
    "¬ведите число %s\n","12")

iup.Message("Hello!",name)

res, prof,prof2 = iup.GetParam("Title", nil,
    "Give your profession: %l|Teacher|Explorer|Engineer|\nGive your 2nd profession: %2|Teacher|Explorer|Engineer|",2)

