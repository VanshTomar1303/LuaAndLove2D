
Player = {} -- class
Player.__index = Player -- object

function Player:new(world,x,y) --constructor
    local self = {
        x = x,
        y = y,
        width = 50,
        height = 50,
        speed = 300,
        world = world -- store world in player
    }

    setmetatable(self, Player) -- setting self in class

    world:add(self, x, y, self.width, self.height) -- add to bump world

    return self -- returning the self
end

function Player:update(dt)

    local goalX, goalY = self.x, self.y -- Where you want the object to go

    if love.keyboard.isDown('w') then -- up
        goalY = goalY - self.speed * dt
    end
    if love.keyboard.isDown('s') then -- down
        goalY = goalY + self.speed * dt
    end
    if love.keyboard.isDown('a') then -- left
        goalX = goalX - self.speed * dt
    end
    if love.keyboard.isDown('d') then -- right
        goalX = goalX + self.speed * dt
    end

    local actualX, actualY, cols, len = self.world:move(self,goalX,goalY) -- Where Bump allows the object to move after checking collisions
    self.x, self.y =  actualX, actualY  

end

function Player:draw()
    love.graphics.setColor(1,0.8,0.5)
    love.graphics.rectangle('fill',self.x,self.y,self.width,self.height)
    love.graphics.setColor(1,1,1)
end

return Player