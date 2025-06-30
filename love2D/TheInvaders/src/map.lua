local sti = require("lib.sti")

local Map = {}
Map.__index = Map

function Map:new(world)
    local this = {
        map = sti("assets/maps/test.lua"),
        world = world,
        scale = 2  -- ✅ scale factor
    }

    -- Add collision objects from "Walls" layer
    if this.map.layers["Walls"] then
        for _, obj in pairs(this.map.layers["Walls"].objects) do
            world:add(obj, obj.x, obj.y, obj.width, obj.height)
        end
    end

    return setmetatable(this, Map)
end

function Map:update(dt)
    self.map:update(dt)
end

function Map:draw()
    love.graphics.push()
    love.graphics.scale(self.scale, self.scale) -- ✅ Apply scaling

     self.map:drawLayer(self.map.layers["Base"])
    self.map:drawLayer(self.map.layers["Objects"])
    self.map:drawLayer(self.map.layers["Test"])
    self.map:drawLayer(self.map.layers["Loot"])
    self.map:drawLayer(self.map.layers["Trees"])
    self.map:drawLayer(self.map.layers["Chests"])
    self.map:drawLayer(self.map.layers["Enemies"])
    self.map:drawLayer(self.map.layers["Water"])
    self.map:drawLayer(self.map.layers["Transitions"])
    
    love.graphics.pop()

    -- Draw scaled collision debug boxes
    love.graphics.setColor(1, 0, 0, 0.3)
    for _, obj in ipairs(self.map.layers["Walls"].objects) do
        love.graphics.rectangle("line", obj.x * self.scale, obj.y * self.scale, obj.width * self.scale, obj.height * self.scale)
    end
    love.graphics.setColor(1, 1, 1)
end

return setmetatable({}, {
    __call = function(_, ...) return Map:new(...) end
})
