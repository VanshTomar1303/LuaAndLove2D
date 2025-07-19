-- functions

local function sayHello()
    print("Hello")
end

local function sayHi(name)
    local name = name or "Jack" -- default variable
    print("Hi "..name)
end

local function sum(n1,n2)
    return n1+n2
end

sayHello()
sayHi("Vansh")
sayHi()