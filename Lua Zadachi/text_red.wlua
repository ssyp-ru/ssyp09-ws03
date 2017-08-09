--I.N. 9.07.09 v. 0.00002 alpha
require ('iuplua')
require ('iupluacontrols')
textr = iup.multiline{value = '', SIZE = '300x300'}
console = iup.multiline{value = '', SIZE = '300x100'}
function iowr(a,b,c,d)
if a == nil then a = "nil" end
if b == nil then b = "nil" end
if c == nil then c = "nil" end
if d == nil then d = "nil" end
console.value = console.value..a..b..c..d
return
end
function pr(a,b,c,d)
iowr(a,b,c,d)
console.value = console.value..'\n'
return
end
print = pr
io.write = iowr

function ex()
os.exit(0)
return
end
function create_file()
textr.value = ''
return
end
function op()
textr.value = ''
opfiledlg = iup.filedlg{dialogtype = "OPEN", title = "Открытие файла",
                      filter = "*.lua", filterinfo = ".lua"
--                      ,directory="c:\\windows"
					  }
opfiledlg:popup (iup.ANYWHERE, iup.ANYWHERE)
status = opfiledlg.status
if status == "1" then
  iup.Message("New file",opfiledlg.value)
elseif status == "0" then
  myf=io.open (opfiledlg.value ,'r')
  textr.value = myf:read("*a")
--[[  repeat
	t = myf:read("*l") -- считаем очередную строку в local t
	if t then -- в конце файла в t будет nil
		textr.value = textr.value..t..'\n'
	end
  until not t -- пока это еще не последняя строка]]
elseif status == "-1" then
  iup.Message("IN редактор","Операция не произведена")
end
return
end
function save()
savefiledlg = iup.filedlg{dialogtype = "SAVE", title = "Сохранение файла",
                      filter = "*.lua", filterinfo = ".lua"
--                      ,directory="c:\\windows"
					}
savefiledlg:popup (iup.ANYWHERE, iup.ANYWHERE)
status = savefiledlg.status
if status == "1" then
  iup.Message("Новый файл",savefiledlg.value)
elseif status == "0" then
  myf=io.open (savefiledlg.value ,'w+')
	myf:write(textr.value) -- запишим в файл
	myf:close()
elseif status == "-1" then
  iup.Message("IN редактор","Операция не произведена")
end
return
end

-- Creates items, sets its shortcut keys and deactivates edit item
item_exit = iup.item {title = "Выход"; action = ex}
item_save = iup.item {title = "Сохранить как"; action = save}
item_op = iup.item {title = "Открыть"; action = op}
-- Создаём содержимое:)меню
menu_file = iup.menu {item_op, item_save, item_exit}
-- Создаём подменюшки

submenu_file = iup.submenu {menu_file; title = "Файл"}
-- Создаём главное меню с подменюшками

menu = iup.menu {submenu_file}

red = iup.dialog
	{menu=menu,
	iup.vbox
	{
		iup.hbox
		{
		menu
		},
		iup.hbox
		{
			iup.button{title='Создать новый файл'; action = create_file},
			iup.button{title='Открыть'; action = op},
			iup.button{title='Сохранить'; action = save},
			iup.button{title='Запустить'; action = "iup.dostring(textr.value)"}, --Команда, чтобы делать "Ран"
			iup.button{title = 'Выход'; action = ex}
		},
			textr,
			console
	}
	;title='IN редактор'
	}
red:show()
if (not iup.MainLoopLevel or iup.MainLoopLevel()==0) then
  iup.MainLoop()
end
