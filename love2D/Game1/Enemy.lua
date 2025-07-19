local love = require "love"

function Enemy(level)

    local dice = math.random(1,4)
    local randX, randY
    local _radius = 10

    -- enemy come from any direction
    if dice == 1 then
        randX = math.random(_radius,love.graphics.getWidth())
        randY = -_radius * 4
    elseif dice == 2 then
        randX = -_radius * 4
        randY = math.random(_radius,love.graphics.getHeight())
    elseif dice == 3 then
        randX = math.random(_radius,love.graphics.getWidth())
        randY = love.graphics.getHeight() + _radius * 4
    else
        randY = math.random(_radius,love.graphics.getWidth())
        randX = love.graphics.getWidth()+_radius * 4
    end

    return{
        level = level or 1,
        radius = _radius,
        x = randX,
        y = randY,
        move = function(self,player_x,player_y)
            if player_x - self.x > 0 then
                self.x = self.x + self.level
            elseif player_x - self.x < 0 then
                self.x = self.x - self.level
            end

            if player_y - self.y > 0 then
                self.y = self.y + self.level
            elseif player_y - self.y < 0 then
                self.y = self.y - self.level
            end
        end,
        draw = function (self)
            love.graphics.setColor(1,0.5,0.7)
            love.graphics.circle("fill",self.x,self.y,self.radius)
            love.graphics.setColor(1,1,1)
        end,
        checkedTouched = function(self,player_x,player_y,cursor_radius)
            return math.sqrt(
                (self.x - player_x) ^ 2 
                + (self.y - player_y) ^ 2)
                 <= cursor_radius * 2
        end
    }
end

return Enemy