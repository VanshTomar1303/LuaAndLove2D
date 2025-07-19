local love = require 'love'
local sti = require 'libraries/sti'

function Map(world)
    return {
        gameMap = sti('maps/mapv2.lua'),
        scale = 2,
        walls = {},
        draw = function(self)
            love.graphics.push()
            love.graphics.scale(self.scale)

            self.gameMap:drawLayer(self.gameMap.layers["ground"])
            self.gameMap:drawLayer(self.gameMap.layers["objects"])
            love.graphics.pop()
        end,
        wallsInit = function(self)
            if self.gameMap.layers["obstacle"] then
                for i, obj in pairs(self.gameMap.layers["obstacle"].objects) do
                    local x = obj.x * self.scale
                    local y = obj.y * self.scale
                    local width = math.max(obj.width * self.scale, 0.1)
                    local height = math.max(obj.height * self.scale, 0.1)
                    local wall = world:newRectangleCollider(x, y, width, height)
                    wall:setType('static')
                    table.insert(self.walls, wall)
                end
            end
        end
    }
end

return Map
