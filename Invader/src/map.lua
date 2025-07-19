local sti = require 'libs.sti'

Map = {}
Map.__index = Map

function Map:new()
    local this = {
        map = sti('assets/map/mapv1.lua')
    }
    setmetatable(this, Map)

    return this
end

function Map:update(dt)

end

function Map:draw()
    -- Inside your love.draw()
    love.graphics.push()

    -- Scale the map (6x here as example)
    local scale = 3
    love.graphics.scale(scale, scale)

    -- Draw your map (e.g., STI map)
    self.map:drawLayer(self.map.layers['ground'])
    self.map:drawLayer(self.map.layers['road'])
    self.map:drawLayer(self.map.layers['house'])
    self.map:drawLayer(self.map.layers['walls'])
    self.map:drawLayer(self.map.layers['enemy'])
    self.map:drawLayer(self.map.layers['lover'])

    love.graphics.pop()

end

return Map
