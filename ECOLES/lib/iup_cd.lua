-- Эту функцию мы взяли для того, чтобы рисовать в растре
-- на iup.Canvas с помощью методов CD.Canvas

cnv = iup.canvas {size = (g_h*10+10).."x"..(g_w*10)}

-- Она создает cd.canvas из iup.canvas
-- не менять!
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
	canvas:Background (cd.GRAY) -- Серый фон поля где все ходят
	canvas:Box (1, 1, 300, 300)

  --canvas:Foreground(cd.EncodeColor(255, 32, 140))
  --canvas:Line(0, 0, 300, 100)
	if life == nil then
		return	-- Мы еще не создали таблицу life = не отрисовываем ее пока
	end
  	for i = 1, table.maxn(life) do
		if life[i].statys ~= 'Мертв' and life[i].statys ~= 'Разложился' then
			life[i]:draw(canvas)
		end
	end
	for j = 0,math.ceil(g_h/3)+4 do
		for i = math.ceil(g_w/3)+4,math.ceil(g_w/3)+1,-1 do
			derewo(canvas,j,i)
		end
	end
	for j = math.ceil(g_h/3)+1, math.ceil(g_h/3)+4 do
		for i = math.ceil(g_w/3),0,-1 do
			derewo(canvas,j,i)
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
