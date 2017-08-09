--Горносталёв Даниил
--ЕГЭ для 5 класса
require('iuplua')
pravelno = 0
ne_pravelno = 0

iup.Message('ЕГЭ для 5 класса','Узнай насколько ты умён!\nДля продолжения нажмите OK')

otvet = iup.Alarm('ЕГЭ для 5 класса','В 2009г сколько лет было бы Гоголю?','200','139','2009')
if otvet == 1 then pravelno = pravelno +1 end
if otvet == 2 then ne_pravelno = ne_pravelno +1 end
if otvet == 3 then ne_pravelno = ne_pravelno +1 end

otvet = iup.Alarm('ЕГЭ для 5 класса','Кем Цезарь приходился Августу?','Папой','Дядей','Дедушкой')
if otvet == 1 then ne_pravelno = ne_pravelno +1 end
if otvet == 2 then pravelno = pravelno +1 end
if otvet == 3 then ne_pravelno = ne_pravelno +1 end

otvet = iup.Alarm('ЕГЭ для 5 класса','Как назывались школы в древнем Египте?','Их там не было','В Египте','Гладиолус')
if otvet == 1 then ne_pravelno = ne_pravelno +1 end
if otvet == 2 then pravelno = pravelno +1 end
if otvet == 3 then ne_pravelno = ne_pravelno +1 end


iup.Message('Результат','Вы набрали '..pravelno..' верных баллов.\nВы набрали '..ne_pravelno..' не верных баллов')

if ne_pravelno >= pravelno then
	iup.Message('Результат!','Ты не прошёл ЕГЭ')
end
if pravelno >= ne_pravelno then
	iup.Message('Результат','Ты прошёл ЕГЭ')
end
