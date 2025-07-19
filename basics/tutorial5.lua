-- if else statements

if true then
    print("this is true")
end

local x = 2

if x > 5 then
    print("x is more than 5")
end

--[[
   and
   or
   not 
   >
   <
   >=
   <=
   ~= -> not equal
   ==
]]

if x > 5 then
    print("x is more than 5")
elseif x == 5 then
    print("x equal to 5")
else
    print("x is smaller than 5")
end

local age = 19
local name =  age > 18 and "Mike" or "Jeff"

print(name)