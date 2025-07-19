local anim8 = require 'libs.anim8'

Heart = {}
Heart.__index = Heart

function Heart:new()
    local itemSpriteSheet = love.graphics.newImage('assets/items/objects.png') 
    local heart = anim8.newGrid(16,16, itemSpriteSheet:getWidth(), itemSpriteSheet:getHeight())

    local this = {
        heartSpriteSheet = itemSpriteSheet,
        heart = heart(5,1),
        damagedHeart = heart(9,1)
    }
    setmetatable(this,Heart)
    return this

end

function Heart:drawHeart(hx)
    love.graphics.draw(self.heartSpriteSheet, self.heart[1],hx, 20, 0, 3, 3)
end

function Heart:drawDamagedHeart(hx)
    love.graphics.draw(self.heartSpriteSheet, self.damagedHeart[1],hx, 20, 0, 3, 3)
end

return Heart