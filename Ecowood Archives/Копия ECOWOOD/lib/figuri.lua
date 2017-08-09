function derewo(canvas,weith,high)
	if mode == 1 then
		canvas:Foreground(cd.EncodeColor(200,165, 0))
		canvas:LineWidth(5)
		canvas:Line(weith*30+5,high*30+10,weith*30+5,high*30+70)
		canvas:Foreground(cd.EncodeColor(0,255, 0))
		canvas:LineWidth(1)
		canvas:Sector(weith*30+7.5,high*30+70,50,50, 0, 360)
		canvas:Foreground(cd.EncodeColor(0,150, 0))
		canvas:Arc(weith*30+7.5,high*30+70,50,50, 0, 360)
		--canvas:Line(weith*10+10,high*10+10,weith*10+7,high*10+40)
	end
end

function o_d_cherv:draw(canvas)
	if mode == 1 then
		canvas:Foreground(cd.EncodeColor(self.c1,self.c2,self.c3))
		canvas:LineWidth(2)
		canvas:Arc(self.x*10-5,self.y*10,10,10, 270, 360)
		canvas:Arc(self.x*10+5,self.y*10,10,10, 90, 180)
		canvas:LineWidth(1)
	end
end

function o_sornyachok:draw(canvas)
	if mode == 1 then
		--canvas:Box (10, 55, 10, 55)
		canvas:Foreground(cd.EncodeColor( 0,128,  0))
		canvas:LineWidth(2)
		canvas:Line(self.x*10,self.y*10-5, self.x*10+5,self.y*10+3)
		canvas:Line(self.x*10,self.y*10-5, self.x*10,self.y*10+5)
		canvas:Line(self.x*10,self.y*10-5, self.x*10-5,self.y*10+3)
		canvas:LineWidth(1)
		--cnv:Pixel(self.x*10,self.y*10,cd.EncodeColor(255,0,0))
	end
end

function o_odyvanchik:draw(canvas)
	if mode == 1 then
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
end

function o_romashka:draw(canvas)
	if mode == 1 then
		--canvas:LineWidth(2)
		canvas:Foreground(cd.EncodeColor( 0,255,  0))
		canvas:Line(self.x*10,self.y*10-4, self.x*10,self.y*10+2)
		--canvas:Line(self.x*10,self.y*10-5, self.x*10-5,self.y*10)
		canvas:Foreground(cd.EncodeColor( 255,255,  255))
		--canvas:LineWidth(1)
		--for i = 1 , 8 do
		canvas:Arc(self.x*10,self.y*10+2.5,6,6, 0, 360)
		--end
		canvas:Foreground(cd.EncodeColor( 255,0,  255))
		canvas:Arc(self.x*10,self.y*10+2.5,1,1, 0, 360)
	end
end

function o_cherv:draw(canvas)
	if mode == 1 then
		canvas:Foreground(cd.EncodeColor(self.c1,self.c2,self.c3))
		canvas:LineWidth(2)
		canvas:Arc(self.x*10-4,self.y*10,8,8, 0, 90)
		canvas:Arc(self.x*10+4,self.y*10,8,8, 180, 270)
		--canvas:Arc(100,50, 50, 50, 90, 180)
		canvas:LineWidth(1)
	end
end

function o_zaic:draw(canvas)
	if mode == 1 then
		canvas:Foreground(cd.EncodeColor(self.c1,self.c2,self.c3))
		--canvas:Box(self.x*10-2,self.x*10+3,self.y*10-1,self.y*10-3)
		--canvas:Box(self.x*10-2,self.y*10-1,5,5)
		canvas:Box(self.x*10-2,self.x*10+10,self.y*10,self.y*10-4)
		canvas:Box(self.x*10,self.x*10-6,self.y*10+1,self.y*10+6)
		canvas:Box(self.x*10-8,self.x*10-7,self.y*10+4,self.y*10+2)
		canvas:Pixel(self.x*10-7,self.y*10+5,cd.EncodeColor(self.c1,self.c2,self.c3))
		canvas:Pixel(self.x*10-7,self.y*10+1,cd.EncodeColor(self.c1,self.c2,self.c3))
		canvas:Box(self.x*10+10,self.x*10+11,self.y*10,self.y*10+2)
		canvas:Pixel(self.x*10-5,self.y*10+4,cd.EncodeColor(0,255,0))
		canvas:Box(self.x*10-2,self.x*10-1,self.y*10-5,self.y*10-8)
		canvas:Line(self.x*10+9,self.y*10-5, self.x*10+7,self.y*10-5)
		canvas:Box(self.x*10+8,self.x*10+7,self.y*10-6,self.y*10-8)
		canvas:Box(self.x*10+1, self.x*10+2,self.y*10+6,self.y*10+5)
		canvas:Box(self.x*10+3, self.x*10+6,self.y*10+6,self.y*10+4)
		canvas:Line(self.x*10+4,self.y*10+3, self.x*10+6,self.y*10+3)
		canvas:Line(self.x*10+7,self.y*10+5, self.x*10+7,self.y*10+4)
		--canvas:Line(self.x*10-1,self.y*10+4, self.x*10,self.y*10+5)
		--canvas:Box(self.x*10+1,self.x*10+2,self.y*10+5,self.y*10+6)
	end
end

function o_datel:draw(canvas)
	if mode == 1 then
		canvas:Foreground(cd.EncodeColor(self.c1,self.c2,self.c3))
		canvas:LineWidth(1)
		--canvas:Arc(self.x*10,self.y*10+5,8,8, 0, 360)
		canvas:Sector(self.x*10, self.y*10+15, 8, 8, 0, 360)
		canvas:Line(self.x*10-8,self.y*10+15, self.x*10-4,self.y*10+18)
		canvas:Line(self.x*10-8,self.y*10+15, self.x*10-4,self.y*10+12)
		canvas:Pixel(self.x*10-1,self.y*10+15,cd.EncodeColor(0,255,0))
		--canvas:Arc(self.x*10+5,self.y*10,10,10, 180, 315)
		canvas:Sector(self.x*10+5,self.y*10+10,10,10, 135, 315)
		canvas:Line(self.x*10+3,self.y*10+5, self.x*10+1,self.y*10+1)
		canvas:Line(self.x*10+5,self.y*10+5, self.x*10+6,self.y*10+1)
		canvas:Line( self.x*10+1,self.y*10+1,self.x*10-1,self.y*10+1)
		canvas:Line(self.x*10+6,self.y*10+1,self.x*10+4,self.y*10+1)
		--canvas:Line(self.x*10+8,self.y*10-4, self.x*10+3,self.y*10+2)
		--canvas:Arc(self.x*10+5,self.y*10,10,10, 180, 270)
	end
end
