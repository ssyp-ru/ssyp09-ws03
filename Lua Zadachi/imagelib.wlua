require"iuplua"
require"iupluaimglib"

iup.ImageLibOpen()

-- Defines an "X" image
img_x = iup.image{
  { 1,2,3,3,3,3,3,3,3,2,1 },
  { 2,1,2,3,3,3,3,3,2,1,2 },
  { 3,2,1,2,3,3,3,2,1,2,3 },
  { 3,3,2,1,2,3,2,1,2,3,3 },
  { 3,3,3,2,1,2,1,2,3,3,3 },
  { 3,3,3,3,2,1,2,3,3,3,3 },
  { 3,3,3,2,1,2,1,2,3,3,3 },
  { 3,3,2,1,2,3,2,1,2,3,3 },
  { 3,2,1,2,3,3,3,2,1,2,3 },
  { 2,1,2,3,3,3,3,3,2,1,2 },
  { 1,2,3,3,3,3,3,3,3,2,1 }
  -- Sets "X" image colors
  ; colors = { "0 1 0", "255 0 0", "255 255 0" }
}

--butt = iup.button{image= "IUP_FileNew",action = create_file}
butt = iup.button{image= img_x, title="test"}
butt2 = iup.button{title="test", IMAGE= "IUP_DeviceVideo"}
butt3 = iup.button{title="test", image= "IUP_FileNew"}
dlg = iup.dialog{iup.hbox {butt,butt2,butt3;PADDING = "40"},title="test", size = "100x100"}

function dlg:close_cb()
  iup.ExitLoop()
  dlg:destroy()
  return iup.IGNORE
end

dlg:show()

if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end
