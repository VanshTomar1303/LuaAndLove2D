-- tables
local tbl = {
    "Vansh", 2, 2.9, true,{"ok","kawaii"}
}

table.insert(tbl,2,20) -- table name, position, value
table.insert(tbl,20) -- table name, value
table.remove(tbl,4) -- table name, psoition

-- for each loop 
for index, value in pairs(tbl) do
    print(index,value)
end

for i = 1, #tbl do
    print(tbl[i])
end

print(table.concat(tbl," "))

local person = {
    name = "Vansh",
    age = 20
}
print(person[name])
print(person[age])