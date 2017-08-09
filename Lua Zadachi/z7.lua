require('iuplua')
require('iupluacontrols')

a = iup.Alarm ('Кто ты','Кто ты?','Вася','Кузя','Паша')
if a == 1 then
	iup.Message ('','Ты дибил.')
elseif a == 2 then
	iup.Message ('','Ты дурак.')
elseif a == 3 then
	iup.Message ('','Ты Умный человек.')
end
