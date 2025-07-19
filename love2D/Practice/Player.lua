local love =  require "love"

function Player()
    return{
        x = love.graphics.getWidth()/2 - 50,
        y = love.graphics.getHeight() - 60,
        height = 50,
        width = 100,
        speed = 200,
        points = 0,
        draw = function(self)
            love.graphics.setColor(1,0,9)
            love.graphics.rectangle("fill",self.x,self.y,self.width,self.height)
            love.graphics.setColor(0.6,0.2,0.9)
            love.graphics.printf(
                "Points: "..math.floor(self.points),
                love.graphics.newFont(26),
                10,10,
                love.graphics.getWidth()
            )
        end,
        update = function(self,dt)
            self.points = self.points + dt
            if love.keyboard.isDown("a") and self.x > 10 then
                self.x = self.x - self.speed * dt
            elseif love.keyboard.isDown("d") and self.x + self.width + 10 < love.graphics.getWidth() then
                self.x = self.x + self.speed * dt
            end
        end
    }
end

return Player