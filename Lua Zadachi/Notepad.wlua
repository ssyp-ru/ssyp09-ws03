--Текстовый редактор "TxtEdit" версия 0.9 beta

require('iuplua')
require('iupluacontrols')
txt_name = ''
txt_path = ''
txt = nil --'..cs..'
saved = true
item_n = iup.item{title = 'Создать'}
item_o = iup.item{title = 'Открыть...'}
item_s = iup.item{title = 'Сохранить как...'}
item_x = iup.item{title = 'Выход'}
crypt_c = iup.item{title = 'Шифровать'}
crypt_u = iup.item{title = 'Дешифровать'}
set_step = ''
function item_n:action()
	text.value = ''
	txt = nil
	saved = false
end
function item_o:action()
	f_op = iup.filedlg{dialogtype = 'OPEN', title = 'Открыть файл',
						filter = "*.txt", filterinfo = "Текстовые документы(*.txt)"}
	f_op:popup (iup.ANYWHERE, iup.ANYWHERE)
	if f_op.status ~= '-1' then
		text.value = ''
		h_fileop = io.open(f_op.value, "r")
		txt = h_fileop:read("*a")
		h_fileop:close()
		text.value = txt
	end
end
function item_s:action()
	f_sv = iup.filedlg{dialogtype = 'SAVE', title = 'Сохранить файл',
						filter = "*.txt", filterinfo = "Текстовые документы(*.txt)"}
	f_sv:popup (iup.ANYWHERE, iup.ANYWHERE)
	if f_sv.status ~= '-1' then
		h_filesv = io.open(f_sv.value, "w")
		h_filesv:write(text.value)
		h_filesv:close()
		saved = true
	end
end
function item_x:action()
	if saved then
		os.exit(0)
	else
		alarm = iup.Alarm('Не сохранено','Файл не сохранен! Хотите сохранить его?','Да','Нет','Отмена')
		if alarm == 1 then
		  file_save()
		  os.exit(0)
		elseif alarm == 2 then
		  os.exit(0)
		end
	end
end
function crypt_c:action()
	crypt_step = 1
	local t1 = text.value
	local t2 = ''
	for i = 1, string.len(t1) do
		if (string.byte(string.sub(t1,i,i))>1) and (string.byte(string.sub(t1,i,i))<254) then
			local j = string.char(string.byte(string.sub(t1,i,i)) + crypt_step)
			t2 = t2..j
		else
			t2 = t2..string.sub(t1,i,i)
		end
	end
	text.value = t2
end
function crypt_u:action()
	crypt_step = 1
	local t1 = text.value
	local t2 = ''
	for i = 1, string.len(t1) do
		if (string.byte(string.sub(t1,i,i))>1) and (string.byte(string.sub(t1,i,i))<254) then
			local j = string.char(string.byte(string.sub(t1,i,i)) - crypt_step)
			t2 = t2..j
		else
			t2 = t2..string.sub(t1,i,i)
		end
	end
	text.value = t2
end

menu_file = iup.menu {item_n, item_o, item_s, item_x}
menu_edit = iup.menu {edit_d}
menu_cryption = iup.menu {crypt_c, crypt_u}
submenu_file = iup.submenu {menu_file; title = 'Файл'}
submenu_edit = iup.submenu {menu_edit; title = 'Правка'}
submenu_cryption = iup.submenu {menu_cryption; title = 'Шифрование'}
menu = iup.menu {submenu_file, submenu_cryption}
text = iup.multiline{value='', border="YES", multiline = 'YES', size = '500x400'}
text.action = function()
	saved = false
end
win = iup.dialog{iup.vbox{text}	;title = 'TxtEdit', menu = menu}
win:show()
if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end
