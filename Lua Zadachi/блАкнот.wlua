require ("iuplua")
require ("iupluacontrols")
saf,opf,mas = {},{},{'','',''}
perv,vtor,tret = "1."..mas[1],"2."..mas[2],"3."..mas[3]
textik = iup.multiline{value=''; SIZE='300x300'}
item_new = iup.item {title = "Создать"}
item_save_as = iup.item {title = "Сохранить как..."}
item_open = iup.item {title = "&Открыть"}
item_exit = iup.item {title = "В&ыход"}
item_save = iup.item {title = "&Сохранить"}
item_str = iup.item {title = str}
item_perv = iup.item {title = perv}
item_vtor = iup.item {title = vtor}
item_tret = iup.item {title = tret}

function item_exit:action()
  return iup.CLOSE
end

function item_save:action()
	if saf.value == nil then
		item_save_as:action()
	else
		f = io.open(saf.value,"w")
		f:write(textik.value)
	end
	return
end

function item_new:action()
	textik.value = ''
	saf.value = nil
	return
end

function item_save_as:action()
	saf = iup.filedlg{dialogtype = "SAVE", title = "Сохранение...",
	filter = "*.txt", filterinfo = "Текстовые документы (*.txt)"}
	saf:popup (iup.ANYWHERE, iup.ANYWHERE)
	if saf.status == "-1" then
		return
	end
	f = io.open(saf.value,"w")
	f:write(textik.value)
	if mas[3] ~= '' then
		mas[1],mas[2],mas[3] = mas[2],mas[3],saf.value
	else
		for i = 1,3 do
			if mas[i] == '' then
				mas[i] = saf.value
				--return
			end
		end
	end
	perv,vtor,tret = "1."..mas[1],"2."..mas[2],"3."..mas[3]
	for i = 1,3 do
		iup.Message ("",mas[i])
	end
	iup.SetAttribute(item_perv, "title", mas[1])
	iup.SetAttribute(item_vtor, "title", mas[2])
	iup.SetAttribute(item_tret, "title", mas[3])
	return
end

function item_open:action()
	opf = iup.filedlg{dialogtype = "OPEN", title = "Открытие...",
	filter = "*.txt", filterinfo = "Текстовые документы (*.txt)"}
	opf:popup (iup.ANYWHERE, iup.ANYWHERE)
	if opf.status == "-1" then
		return
	end
	f = io.open(opf.value,"r")
	textik.value = f:read("*a")
end

menu_file = iup.menu {item_new, item_open,item_save,item_save_as,item_exit,item_str,item_perv,item_vtor,item_tret}
submenu_file = iup.submenu {menu_file; title = "&Файл"}
menu = iup.menu {submenu_file}
dlg = iup.dialog{textik; title="БлАкнот", menu=menu}
dlg:showxy(iup.CENTER,iup.CENTER)

if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end
