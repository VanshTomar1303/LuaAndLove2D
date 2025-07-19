local love = require "love"
local anim8 = require 'libraries/anim8'

function Player(world)

    local spriteSheet = love.graphics.newImage('sprites/character.png')
    local grid = anim8.newGrid(16, 33, spriteSheet:getWidth(), spriteSheet:getHeight())
    local animations = {
            down = anim8.newAnimation(grid('1-4', 1), 0.2),
            right = anim8.newAnimation(grid('1-4', 2), 0.2),
            up = anim8.newAnimation(grid('1-4', 3), 0.2),
            left = anim8.newAnimation(grid('1-4', 4), 0.2)
        }
    local anim = animations.down

    return {
        x = 300,
        y = 300,
        speed = 300,
        dir = 'down',
        arrowCount = 25,
        collider = world:newBSGRectangleCollider(300,200,37,50,10),
        update = function(self,dt)
            self.collider:setFixedRotation(true)
            local isMoving = false
            local vx = 0
            local vy = 0 
            if love.keyboard.isDown("w") then
                vy = self.speed * -1
                anim = animations.up
                isMoving = true
                self.dir = 'up'
            elseif love.keyboard.isDown("s") then
                vy = self.speed
                anim = animations.down
                isMoving = true
                self.dir = 'down'
            elseif love.keyboard.isDown("a") then
                vx = self.speed * -1
                anim = animations.left
                isMoving = true
                self.dir = 'left'
            elseif love.keyboard.isDown("d") then
                vx = self.speed
                anim = animations.right
                isMoving = true
                self.dir = 'right'
            end

            self.collider:setLinearVelocity(vx,vy)
            self.x = self.collider:getX()
            self.y = self.collider:getY()

            if not isMoving then
                anim:gotoFrame(3)
            else 
                anim:update(dt)
            end
        end,
        draw = function(self)
            anim:draw(spriteSheet,self.x,self.y,nil,2,nil,8,16)
        end
    }
end

return Player
