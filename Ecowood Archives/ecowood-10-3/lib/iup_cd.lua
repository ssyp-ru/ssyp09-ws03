-- ��� ������� �� ����� ��� ����, ����� �������� � ������
-- �� iup.Canvas � ������� ������� CD.Canvas

--cnv = iup.canvas {size = (g_w*10+10).."x"..(g_h*10)}
cnv = iup.canvas {size = "100x100"}

-- ��� ������� cd.canvas �� iup.canvas
-- �� ������!
function cnv:map_cb()
  canvas = cd.CreateCanvas(cd.IUP, self)
  self.canvas = canvas     -- store the CD canvas in a IUP attribute
end


--[[function dlg:close_cb()
  cnv = self[1][2]
  canvas = cnv.canvas     -- retrieve the CD canvas from the IUP attribute
  canvas:Kill()
  self:destroy()
  return iup.IGNORE -- because we destroy the dialog
end]]

function cnv:action()
  canvas = self.canvas     -- retrieve the CD canvas from the IUP attribute

  canvas:Activate()
  canvas:Clear()
  canvas:Foreground (cd.RED)

  --canvas:Box (10, 55, 10, 55)
  --canvas:Foreground(cd.EncodeColor(255, 32, 140))
  --canvas:Line(0, 0, 300, 100)
	if life == nil then
		return	-- �� ��� �� ������� ������� life = �� ������������ �� ����
	end
  	for i = 1, table.maxn(life) do
		if life[i].statys ~= '�����' and life[i].statys ~= '����������' then
			life[i]:draw(canvas)
		end
	end

end

--[[function cnv:button_cb(b, e, x, y, r)
  print ("Button: " .. "Button="..tostring(b).." Pressed="..tostring(e).." X="..tostring(x).." Y="..tostring(y) )
end

function cnv:resize_cb(w, h)
  print("Resize: Width="..w.."   Height="..h)
end
]]
