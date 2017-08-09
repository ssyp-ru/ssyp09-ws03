
function o_d_cherv:draw(canvas)
	canvas:Foreground(cd.EncodeColor(255, 0, 0))
	canvas:LineWidth(2)
	canvas:Arc(self.x*10-5,self.y*10,10,10, 270, 360)
	canvas:Arc(self.x*10+5,self.y*10,10,10, 90, 180)
	--canvas:Arc(100,50, 50, 50, 90, 180)
	canvas:LineWidth(1)
end

function o_sornyachok:draw(canvas)
	--canvas:Box (10, 55, 10, 55)
	canvas:Foreground(cd.EncodeColor( 0,128,  0))
	canvas:LineWidth(2)
	canvas:Line(self.x*10,self.y*10-5, self.x*10+5,self.y*10+3)
	canvas:Line(self.x*10,self.y*10-5, self.x*10,self.y*10+5)
	canvas:Line(self.x*10,self.y*10-5, self.x*10-5,self.y*10+3)
	canvas:LineWidth(1)
	--cnv:Pixel(self.x*10,self.y*10,cd.EncodeColor(255,0,0))
end

function o_odyvanchik:draw(canvas)
	--canvas:LineWidth(2)
	canvas:Foreground(cd.EncodeColor( 0,255,  0))
	canvas:Line(self.x*10,self.y*10-5, self.x*10,self.y*10+2.5)
	--canvas:Line(self.x*10,self.y*10-5, self.x*10-5,self.y*10)
	canvas:Foreground(cd.EncodeColor( 255,255,  255))
	--canvas:LineWidth(1)
	for i = 1 , 4 do
		canvas:Arc(self.x*10,self.y*10+2.5,6-i,6-i, 0, 360)
	end
end

function o_cherv:draw(canvas)
	canvas:Foreground(cd.EncodeColor(255, 0, 0))
	canvas:LineWidth(2)
	canvas:Arc(self.x*10-4,self.y*10,8,8, 0, 90)
	canvas:Arc(self.x*10+4,self.y*10,8,8, 180, 270)
	--canvas:Arc(100,50, 50, 50, 90, 180)
	canvas:LineWidth(1)
end
