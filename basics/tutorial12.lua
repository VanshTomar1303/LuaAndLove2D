-- oop

local function Pet(name)
    return {
        name = name or "Charlie",
        speak = function(self)
            print("Meow")
        end,
        feed = function(self)
            print("Eating",self.name)
        end,
    }
end

local cat = Pet()
local dog = Pet("Jack")
print(cat.name)
print(dog.name)
cat:speak()
dog:feed()

-- inheritance
local function Hawk(name)
    local hawk = Pet(name)

    hawk.speed = 200 -- add new variables
    -- override a function
    hawk.speak = function(self)
        print("kiiiiiiiiiiiiiiii")
    end

    return hawk
end