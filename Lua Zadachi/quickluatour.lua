-- QuickLuaTour.lua
--
-- A quick tour of the Lua Scripting Language.
--
-- Created: May 21, 2008,
-- Updated: Sept 4th, 2008 Fix typos, minor changes, better formatting.
-- Author: AGR Wilson
--
-- To add later? - serialize table, self-executing code, closures, co-routines.
--

local codeSamples ={
[==[
-- First Program.
-- Classic hello program.

print("hello")

]==],

[==[
-- Comments.
-- Single line comments in Lua start with double hyphen.

--[[ Multiple line comments start
with double hyphen and two square brackets.
  and end with two square brackets. ]]

-- And of course this example produces no
-- output, since it's all comments!

]==],

[==[
-- Variables.
-- Variables hold values which have types, variables don't have types.
a=1
b="abc"
c={}
d=print

print(type(a))
print(type(b))
print(type(c))
print(type(d))
]==],

[==[
-- Variables names.
-- Variable names consist of letters, digits and underscores.
-- Variables names cannot start with a digit.

one_two_3 = 123 -- is valid varable name

-- 1_two_3 is not a valid variable name.

]==],

[==[
-- More Variable names.
-- The underscore is typically used to start special values
-- like _VERSION in Lua.

print(_VERSION)

-- So don't use variables that start with _,
-- but a single underscore _ is often used as a
-- dummy variable.

]==],
[==[
-- Case Sensitive.
-- Lua is case sensitive so all variable names & keywords
-- must be in correct case.

ab=1
Ab=2
AB=3
print(ab,Ab,AB)

]==],
[==[
-- Keywords.
-- Lua reserved words are: and, break, do, else, elseif,
--     end, false, for, function, if, in, local, nil, not, or,
--     repeat, return, then, true, until, while.

-- Keywords cannot be used for variable names,
-- 'and' is a keyword, but AND is not, so it is a legal variable name.
AND=3
print(AND)

]==],

[==[
-- Strings.
a="single 'quoted' string and double \"quoted\" string inside"
b='single \'quoted\' string and double "quoted" string inside'
c= [[ multiple line
with'single'
and "double" quoted strings inside.]]

print(a)
print(b)
print(c)
]==],

[==[
-- Assignments.
-- Multiple assignments are valid.
--  var1,var2=var3,var4

a,b,c,d,e = 1, 2, "three", "four", 5

print(a,b,c,d,e)

]==],
[==[
-- More Assignments.
-- Multiple assignments allows one line to swap two variables.

print(a,b)
a,b=b,a
print(a,b)

]==],
[==[
-- Numbers.
-- Multiple assignment showing different number formats.

a,b,c,d,e = 1, 1.123, 1E9, -123, .0008
print("a="..a,"b="..b,"c="..c,"d="..d,"e="..e)

]==],
[==[
-- More Output.
-- More writing output.

print "Hello from Lua!"
print("Hello from Lua!")

]==],
[==[
-- More Output.
-- io.write writes to stdout but without new line.

io.write("Hello from Lua!")
io.write("Hello from Lua!")

-- Use single print to write single new line.
print()

]==],

[==[
-- Tables.
-- Simple table creation.

a={} -- {} creates a table
b={1,2,3} -- creates a table containing numbers 1,2,3
c={"a","b","c"} -- creates a table containing strings a,b,c
print(a,b,c) -- tables don't print directly, we'll get back to this!!
]==],

[==[
-- More Tables.
-- Associate index style.

address={} -- empty address
address.Street="Wyman Street"
address.StreetNumber=360
address.AptNumber="2a"
address.City="Watertown"
address.State="Vermont"
address.County="USA"

print(address.StreetNumber, address["AptNumber"])

]==],
[==[
-- More Tables.
-- More creation.

b={1,2,3} -- creates a table containing numbers 1,2,3
c={"a","b","c"} -- creates a table containing strings a,b,c
print(a,b,c) -- tables don't print, we'll get back to this!!
]==],

[==[
-- if statement.
-- Simple if.

a=1
if a==1 then
    print ("a is one")
end
]==],

[==[
-- if else statement.

b="happy"
if b=="sad" then
    print("b is sad")
else
    print("b is not sad")
end
]==],

[==[
-- if elseif else statement

c=3
if c==1 then
    print("c is 1")
elseif c==2 then
    print("c is 2")
else
    print("c isn't 1 or 2, c is "..tostring(c))
end
]==],


[==[
-- Conditional assignment.
-- value = test and x or y
a=1
b=(a==1) and "one" or "not one"
print(b)

-- is equivalent to
a=1
if a==1 then
    b = "one"
else
    b = "not one"
end
print(b)
]==],

[==[
-- while statement.

a=1
while a~=5 do -- Note: Lua uses ~= to mean not equal
    a=a+1
    io.write(a.." ")
end
]==],


[==[
-- repeat until statement.

a=0
repeat
    a=a+1
    print(a)
until a==5
]==],


[==[
-- for statement.
-- Numeric iteration form.

-- Count from 1 to 4 by 1.
for a=1,4 do io.write(a) end

print()

-- Count from 1 to 6 by 3.
for a=1,6,3 do io.write(a) end
]==],


[==[
-- More for statement.
-- Sequential iteration form.

for key,value in pairs({1,2,3,4}) do print(key, value) end
]==],

[==[
-- Functions.

-- Define a function without parameters or return value.
function myFirstLuaFunction()
    print("My first lua function was called")
end

-- Call myFirstLuaFunction.
myFirstLuaFunction()
]==],
[==[
-- More functions.

-- Define a function with a returns value.
function mySecondLuaFunction()
    return "string from my second function"
end

-- Call function returning a value.
a=mySecondLuaFunction("string")
print(a)
]==],

[==[
-- More functions.

-- Define function with multiple parameters and multiple return values.
function myFirstLuaFunctionWithMultipleReturnValues(a,b,c)
    return a,b,c,"My first lua function with multiple return values", 1, true
end

a,b,c,d,e,f = myFirstLuaFunctionWithMultipleReturnValues(1,2,"three")
print(a,b,c,d,e,f)
]==],

[==[
-- Variable scoping and functions.
-- All varables are global in scope by default.

b="global"

-- To make local variables you must put the keyword 'local' in front.
function myfunc()
    local b=" local variable"
    a="global variable"
    print(a,b)
end

myfunc()
print(a,b)
]==],

[==[
-- break statement.
-- break is used to exit loop based on condition.

a=0
while true do
    a=a+1
    if a==10 then
        break
    end
end

print(a)
]==],

[==[
-- Formatted printing.
-- An implementation of printf.

function printf(...)
    io.write(string.format(...))
end

printf("Hello %s from %s on %s\n",os.getenv"USER" or "there",_VERSION,os.date())
]==],

[==[
-- Printing tables.
-- Simple way to print tables.

a={1,2,3,4,"five","elephant", "mouse"}

for i,v in pairs(a) do print(i,v) end
]==],

[==[
--[[

 Standard Libraries

  Lua has standard libraries built-in libraries for common operations in
  math, string, table, input/output & operating system facilities libraries.

 External Libraries

  Lua has support for external libraries for operations in sockets, xml,
  profiling, logging, test units, and many more.

]]

]==],

[==[
-- Standard Libraries - math.

-- Math functions:
-- math.abs, math.acos, math.asin, math.atan, math.atan2,
-- math.ceil, math.cos, math.deg, math.exp, math.floor, math.frexp
-- math.ldexp, math.log, math.log10, math.max, math.min, math.mod,
-- math.pi, math.rad, math.random, math.randomseed, math.sin,
-- math.sqrt, math.tan

print(math.sqrt(9), math.pi)
]==],

[==[
-- Standard Libraries - string.

-- String functions:
-- string.byte, string.char, string.dump, string.find, string.format,
-- string.gfind, string.gsub, string.len, string.lower, string.rep
-- string.sub, string.upper

print(string.upper("lower"),string.rep("a",5),string.find("abcde", "cd"))
]==],

[==[
-- Standard Libraries - table.

-- Table functions:
-- table.concat, table.getn, table.insert,
-- table.remove, table.setn, table.sort

a={2}
table.insert(a,3);
table.insert(a,4);
table.sort(a,function(v1,v2) return v1 > v2 end)
for i,v in ipairs(a) do print(i,v) end
]==],

[==[
-- Standard Libraries - input/output.

-- IO functions:
-- io.close , io.flush, io.input, io.lines, io.open, io.output, io.popen,
-- io.read, io.tmpfile, io.type, io.write, file:close, file:flush,
-- file:lines ,file:read, file:seek, file:setvbuf, file:write

       print(io.open("file doesn't exist", "r"))
]==],

[==[
-- Standard Libraries - operating system facilities.

-- OS functions:
-- os.clock, os.date, os.difftime, os.execute, os.exit, os.getenv,
-- os.remove, os.rename, os.setlocale, os.time, os.tmpname

print(os.date())
]==],

[==[
-- External Libraries.
-- Lua has support for external modules using the require function
-- INFO: A dialog will popup but it could get hidden behind the console.
-- Shows a multiline that ignores the DEL key, canceling its effect.

require( "iuplua" )
ml = iup.multiline
    {
    expand="YES",
    value="Quit this multiline edit app to continue Tutorial!",
    border="YES"
    }
dlg = iup.dialog{ml; title="IupMultiline", size="QUARTERxQUARTER",}
dlg:show()
print("Exit GUI app to continue!")
iup.MainLoop()
]==],

[==[
--[[

 To learn more about Lua Scripting see

 Lua Tutorials: http://lua-users.org/wiki/TutorialDirectory

 Programming in Lua Book: http://www.inf.puc-rio.br/~roberto/pil2/

 Lua 5.1 Reference Manual:
     Start/Programs/Lua/Documentation/Lua 5.1 Reference Manual

 Examples: Start/Programs/Lua/Examples
]]

]==],


}

-- for every code sample do
for i =1, #codeSamples do

   -- clear screen
   if os.getenv("OS")=="Windows_NT" then
       os.execute("cls")
   end

   -- print code sample to console
   io.write("\n-- ������ "..i.."   ")

   print(codeSamples[i])

   print ("\n-------- �� ������ ------\n")

   -- execute code sample
   -- used protected call to load & execute codeSamples[i] as chunk of code
   local ok, err = pcall(loadstring(codeSamples[i]))
   if not ok then
        print("failed to load & run sample code")
        print(err)
    end

    io.write("\n������� 'Enter' ��� ���������� �������")
    io.read()

end -- for loop


print("\n��� ������� ���� Lua ��������!")
