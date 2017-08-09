
function deepcopy(object)
    local lookup_table = {}
    local function _copy(object)
        if type(object) ~= "table" then
            return object
        elseif lookup_table[object] then
            return lookup_table[object]
        end
        local new_table = {}
        lookup_table[object] = new_table
        for index, value in pairs(object) do
            new_table[_copy(index)] = _copy(value)
        end
        return setmetatable(new_table, getmetatable(object))
    end
    return _copy(object)
end

--my_zhivye.print_name = print_name

my_zhivye = {}

-- Прародитель всех живых существ
obj = {typ = "непонятный", x = 1, y = 1, name = "без имени"}
-- Напечатать его имя
function obj:print_name()
	print(self.name)
end

--print (obj.name)
--obj:print_name()

--os.exit(0)

-- Прожить 1 цикл
function obj:zhivi()
	print(self.name.." думает что делать.")
end



-- Создадим класс ТРАВЫ на основе класса ПРАРОДИТЕЛЯ

o_trava = deepcopy(obj)
o_trava.name = "какое-то растение"
o_trava.typ = "растение"
-- Сколько семян бросает в почву
function o_trava:print_seeds()
	print(self.seeds)
end

-- Создадим класс Ромашек на основе класса ТРАВЫ
o_romashka = deepcopy(o_trava)
o_romashka.name = "Я Ромашка"
o_romashka.seeds = 8

-- Создадим класс Роз на основе класса ТРАВЫ
o_roza = deepcopy(o_trava)
o_roza.name = "Я Розочка"
o_roza.seeds = 5

-- Создадим класс НАСЕКОМЫХ на основе класса ПРАРОДИТЕЛЯ
o_nasekomoe = deepcopy(obj)
o_nasekomoe.name = "какое-то насекомое"
o_nasekomoe.typ = "насекомое"
-- Сколько ног у существа
function o_nasekomoe:print_legs()
	print(self.legs)
end

-- Создадим класс Муравей на основе класса НАСЕКОМЫХ
o_murash = deepcopy(o_nasekomoe)
o_murash.name = "Я не мормыш, я мураш"
o_murash.legs = 6


o_murash:print_name()
o_murash:print_legs()
o_murash:zhivi()
print ("---")
a = {}
a[1] = o_murash
a[1]:zhivi()
a[1]:print_seeds()

print ("---")

obj:print_name()
obj:print_seeds()
obj:print_legs()
