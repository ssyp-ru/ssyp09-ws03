-- проверка: запуск произведен через главный файл main.wlua или нет
if not did_we_load_the_main_file then
	print("»звините, но вы должны запускать только MAIN.WLUA")
	os.exit(0)
end
-------------------‘ункции сорн€чка----------------
o_sornyachok = deepcopy(o_trava)
o_sornyachok_n = 0
o_sornyachok.name = "—орн€чок"
o_sornyachok.deti = 2

function o_sornyachok:create(x,y)
	o_sornyachok_n = o_sornyachok_n + 1
	tmp_obj = deepcopy(o_sornyachok)
	tmp_obj.name = '—орн€чок-'..o_sornyachok_n
	tmp_obj.x = x
	tmp_obj.y = y
	tmp_obj.chto_est = 'гумус'
	life[table.maxn(life)+1] = tmp_obj
	iup.SetAttribute(list, table.maxn(life), tmp_obj.name)
	st_alive = st_alive + 1
end

--[[
-- Ќарисуй
function o_sornyachok:draw(cnv)
	--canvas:Box (10, 55, 10, 55)
	canvas:Foreground(cd.EncodeColor( 0,128,  0))
	canvas:LineWidth(2)
	canvas:Line(self.x*10,self.y*10, self.x*10+5,self.y*10+8)
	canvas:Line(self.x*10,self.y*10, self.x*10,self.y*10+10)
	canvas:Line(self.x*10,self.y*10, self.x*10-5,self.y*10+8)
	canvas:LineWidth(1)
	--cnv:Pixel(self.x*10,self.y*10,cd.EncodeColor(255,0,0))
end
]]
------------------/‘ункции сорн€чка----------------
