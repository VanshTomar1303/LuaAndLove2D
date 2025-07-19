
Player = {} -- class
Player.__index = Player -- object

function Player:new(x,y) --constructor
    local self = {
        x = x,
        y = y,
        width = 50,
        height = 50,
        speed = 300
    }

    setmetatable(self, Player) -- setting self in class

    return self -- returning the self
end

function Player:update(dt)
    if love.keyboard.isDown('w') then -- up
        self.y = self.y - self.speed * dt
    end
    if love.keyboard.isDown('s') then -- down
        self.y = self.y + self.speed * dt
    end
    if love.keyboard.isDown('a') then -- left
        self.x = self.x - self.speed * dt
    end
    if love.keyboard.isDown('d') then -- right
        self.x = self.x + self.speed * dt
    end
end

function Player:draw()
    love.graphics.setColor(1,0.8,0.5)
    love.graphics.rectangle('fill',self.x,self.y,self.width,self.height)
    love.graphics.setColor(1,1,1)
end

return Player