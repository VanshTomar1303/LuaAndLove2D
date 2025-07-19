-- loops

-- for loop
for i=1, 10, 2 do -- start 0 end 10 steps 2 
    print(i)
end

-- while loop
while true do
    print("くるまがすきです！")
    break
end

-- repeat loop like a do while loop
local count = 10
repeat
    count = count + 1
    print("Mike")
until count > 5