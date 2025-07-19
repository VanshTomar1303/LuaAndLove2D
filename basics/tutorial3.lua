-- string
local x = "vansh"
local y = 'Tomar'
local z = [[
abcd
two
]]

print(#x) -- # is use for finding length of string

-- convert num to str
local num = 20303
local str = tostring(num)
-- to find type of variable
print(type(str),num,str)

-- escape char
print("Hello\nhi\tasld\vdsjds") -- '\n' new line, '\t' tab, '\v' vertical tab, same as other programming languages 

str = "Hello, World!"
print(string.lower(str)) -- lowercase
print(string.upper(str)) -- uppercase
print(string.len(str)) -- length of string
