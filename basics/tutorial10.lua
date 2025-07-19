-- working with files

-- io.output("input.txt") -- create file
-- io.write("The Invaders.") 

-- io.input("input.txt") -- read file
-- local fileData = io.read("*all")
-- local fileData = io.read("*line")
-- print(fileData)

local file = io.open("input1.txt","w")

if file ~= nil then
    file:write("Hello There!")
else 
    print("Could not open the file")
end
file:close() -- close the file