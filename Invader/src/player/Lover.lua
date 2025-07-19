local anim8 = require 'libs.anim8'

Lover = {}
Lover.__index = Lover

function Lover:new()

    local loverSpriteSheet = love.graphics.newImage('assets/player/lover/princess-001-light.png')
    local loverGrid = anim8.newGrid(24,32,loverSpriteSheet:getWidth(),loverSpriteSheet:getHeight())

    local this = {
        x = 1200 *3,
        y = 1400 *3,
        loverSpriteSheet =  loverSpriteSheet,
        animation = {
            down = anim8.newAnimation(loverGrid('1-3',3),0.2),
            up = anim8.newAnimation(loverGrid('1-3',1),0.2),
            left = anim8.newAnimation(loverGrid('1-3',4),0.2),
            right = anim8.newAnimation(loverGrid('1-3',2),0.2),
        },
        currentAnimation = nil,
    }    
    setmetatable(this,Lover)

    this.currentAnimation = this.animation.down

    return this
end

function Lover:update(dt)
    self.currentAnimation:update(dt)
end

function Lover:draw()
    self.currentAnimation:draw(self.loverSpriteSheet,self.x,self.y,0,2.5)
end

return Lover