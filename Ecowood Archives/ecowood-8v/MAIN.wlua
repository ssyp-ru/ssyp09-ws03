require( "iuplua" )
require( "iupluacontrols" )
require"cdlua"
require"iupluacd"
iup.SetLanguage('ENGLISH') --����� iup.ALARM Message � �.�. ��������� ������ �� �� ���������

-- �������, ������� ���������� � ������ ������� �� �������� ��������� ����� �������
-- ��� ��������� - ��������� �� �� ���� ����� MAIN.WLUA ����� ��� ������� ������ ��� ���������
did_we_load_the_main_file = true
if not did_we_load_the_main_file then
	print("��������, �� �� ������ ��������� ������ MAIN.WLUA")
	os.exit(0)
end

math.randomseed(os.time()) -- ��� ������������� ������� ��������� �����
-- ������ �� ���������� ������������ ����������� ������. ��� ������ ��� � ��������� ������.
m_prover_kletki = {{sx=-1,sy=-1}, {sx=0,sy=-1}, {sx=1,sy=-1}, {sx=-1,sy=0}, {sx=0,sy=0}, {sx=1,sy=0}, {sx=-1,sy=1}, {sx=0,sy=1}, {sx=1,sy=1},
{sx=-1,sy=-1}, {sx=0,sy=-1}, {sx=1,sy=-1}, {sx=-1,sy=0}, {sx=0,sy=0}, {sx=1,sy=0}, {sx=-1,sy=1}, {sx=0,sy=1}, {sx=1,sy=1}}

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

function printlog(text)
	log1.value = log1.value..text
	return
end
function string_cut(s1,s2)
	n = string.find(s1,s2)
	if n ~= nil then
		s = string.sub(s1,1,n-1)..string.sub(s1,n+string.len(s2),string.len(s1))
		return s
	end
end
dofile('obj/predok.lua')
dofile('obj/trava.lua')
dofile('obj/sornyachok.lua')
dofile('obj/romashka.lua')
dofile('obj/chervi.lua')
dofile('obj/cherv.lua')
dofile('obj/d_cherv.lua')
dofile('obj/odyvanchik.lua')
dofile("lib/iup_cd.lua")	-- ��� �������� ������� ��� ���������
dofile('lib/gui.lua')

