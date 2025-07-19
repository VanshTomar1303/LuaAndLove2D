local sti = require 'libs.sti'
local coin = require 'src.items.Coin'

local Map = {}
Map.__index = Map

function Map:new(world)

    local scale = 2

    local this = {
        map = sti('assets/map/mapv1..lua'),
        walls = {},
        coins = {} 
    }

    if this.map.layers['walls'] then
        for i,obj in pairs(this.map.layers['walls'].objects) do
            local wall = world:newRectangleCollider(obj.x*scale,obj.y*scale,obj.width*scale,obj.height*scale)
            wall:setType('static')
            table.insert(this.walls,wall)
        end    
    end
    
    if this.map.layers['collectable'] then
        for i,obj in pairs(this.map.layers['collectable'].objects) do 
            local c = coin:new(obj.x * scale, obj.y * scale,obj.width,obj.height, world)
            table.insert(this.coins, c)        
        end
    end

    -- remove walls color
    this.map.layers.walls.visible = false
    this.map.layers.collectable.visible = false

    setmetatable(this, Map)
    return this
end

function Map:update(dt)
    for i,coin in ipairs(self.coins) do
        coin:update(dt)
    end
end

function Map:draw()
    self.map:draw(0,0,2)
    for i,coin in ipairs(self.coins) do
        coin:draw()
    end
end

return Map