require("iuplua")

l = iup.list{dropdown="NO"}

iup.SetAttribute(l, "1", "HELVETICA_NORMAL_8")
iup.SetAttribute(l, "2", "COURIER_NORMAL_8")
iup.SetAttribute(l, "3", "TIMES_NORMAL_8")
iup.SetAttribute(l, "4", "HELVETICA_ITALIC_8")
iup.SetAttribute(l, "5", "COURIER_ITALIC_8")
iup.SetAttribute(l, "6", "TIMES_ITALIC_8")
iup.SetAttribute(l, "7", "HELVETICA_BOLD_8")
iup.SetAttribute(l, "8", "COURIER_BOLD_8")
iup.SetAttribute(l, "9", "TIMES_BOLD_8")
iup.SetAttribute(l, "10", "HELVETICA_NORMAL_10")
iup.SetAttribute(l, "11", "COURIER_NORMAL_10")
iup.SetAttribute(l, "12", "TIMES_NORMAL_10")
iup.SetAttribute(l, "13", "HELVETICA_ITALIC_10")
iup.SetAttribute(l, "14", "COURIER_ITALIC_10")
iup.SetAttribute(l, "15", "TIMES_ITALIC_10")
iup.SetAttribute(l, "16", "HELVETICA_BOLD_10")
iup.SetAttribute(l, "17", "COURIER_BOLD_10")
iup.SetAttribute(l, "18", "TIMES_BOLD_10")
iup.SetAttribute(l, "19", "HELVETICA_NORMAL_12")
iup.SetAttribute(l, "20", "COURIER_NORMAL_12")
iup.SetAttribute(l, "21", "TIMES_NORMAL_12")
iup.SetAttribute(l, "22", "HELVETICA_ITALIC_12")
iup.SetAttribute(l, "23", "COURIER_ITALIC_12")
iup.SetAttribute(l, "24", "TIMES_ITALIC_12")
iup.SetAttribute(l, "25", "HELVETICA_BOLD_12")
iup.SetAttribute(l, "26", "COURIER_BOLD_12")
iup.SetAttribute(l, "27", "TIMES_BOLD_12")
iup.SetAttribute(l, "28", "HELVETICA_NORMAL_14")
iup.SetAttribute(l, "29", "COURIER_NORMAL_14")
iup.SetAttribute(l, "30", "TIMES_NORMAL_14")
iup.SetAttribute(l, "31", "HELVETICA_ITALIC_14")
iup.SetAttribute(l, "32", "COURIER_ITALIC_14")
iup.SetAttribute(l, "33", "TIMES_ITALIC_14")
iup.SetAttribute(l, "34", "HELVETICA_BOLD_14")
iup.SetAttribute(l, "35", "COURIER_BOLD_14")
iup.SetAttribute(l, "36", "TIMES_BOLD_14")
--lifelist:show()

if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end