-- datatype
-- nil -- empty,null,undefined
-- number -- 1,2,-99,2.9
-- string -- "asjsddk"
-- boolean -- true false
-- tables -- array, list

-- variable 

local name -- can't be used in another file
name = "Vansh"
print("Hello my name is "..name)

name = [[
    vansh
    invaders
]] -- multiline string
print(name)

local one,two,three = "one",2,false
print(one)
print(two)
print(three)
    
_G.GlobalVar = 10 -- it can be used in another file