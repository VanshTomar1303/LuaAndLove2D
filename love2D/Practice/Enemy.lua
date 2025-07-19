local love = require "love"

function Enemy(level)

    local randX, randY

    randX = math.random(10,love.graphics.getWidth()-10)
    randY = -20*4

    return{
        x = randX,
        y = randY,
        radius = 20,
        speed = 100, 
        level =  level or 1,
        outScreen = false,
        isCollision = false,
        draw = function(self)
            love.graphics.setColor(0.4,0.7,0.3)
            love.graphics.circle("line",self.x,self.y,self.radius)
        end,
        update = function(self,dt,player_y,player_x,player_width)
            self.y = self.y + self.speed * dt + self.level
            if self.y + self.radius > love.graphics.getHeight() then
                self.outScreen = true
            end
            if
                self.y + self.radius >= player_y and             -- bottom of enemy touches top of player
                self.y - self.radius < player_y and              -- enemy is coming from above
                self.x + self.radius > player_x and              -- enemy's right past player's left
                 self.x - self.radius < player_x + player_width   -- enemy's left before player's right
            then
                self.isCollision = true
            end
        end
    }
end

return Enemy