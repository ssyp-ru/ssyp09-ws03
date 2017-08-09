
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

-- ����������� ���� ����� �������
obj = {typ = "����������", x = 1, y = 1, name = "��� �����"}
-- ���������� ��� ���
function obj:print_name()
	print(self.name)
end

--print (obj.name)
--obj:print_name()

--os.exit(0)

-- ������� 1 ����
function obj:zhivi()
	print(self.name.." ������ ��� ������.")
end



-- �������� ����� ����� �� ������ ������ �����������

o_trava = deepcopy(obj)
o_trava.name = "�����-�� ��������"
o_trava.typ = "��������"
-- ������� ����� ������� � �����
function o_trava:print_seeds()
	print(self.seeds)
end

-- �������� ����� ������� �� ������ ������ �����
o_romashka = deepcopy(o_trava)
o_romashka.name = "� �������"
o_romashka.seeds = 8

-- �������� ����� ��� �� ������ ������ �����
o_roza = deepcopy(o_trava)
o_roza.name = "� �������"
o_roza.seeds = 5

-- �������� ����� ��������� �� ������ ������ �����������
o_nasekomoe = deepcopy(obj)
o_nasekomoe.name = "�����-�� ���������"
o_nasekomoe.typ = "���������"
-- ������� ��� � ��������
function o_nasekomoe:print_legs()
	print(self.legs)
end

-- �������� ����� ������� �� ������ ������ ���������
o_murash = deepcopy(o_nasekomoe)
o_murash.name = "� �� ������, � �����"
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
