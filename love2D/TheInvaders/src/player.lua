local Player = {}
Player.__index = Player

function Player:new(world, x, y)
    local this = {
        x = x,
        y = y,
        w = 16,
        h = 16,
        speed = 100,
        world = world
    }

    world:add(this, x, y, this.w, this.h)
    return setmetatable(this, Player)
end

function Player:update(dt)
    local dx, dy = 0, 0

    if love.keyboard.isDown("up") then dy = -self.speed * dt end
    if love.keyboard.isDown("down") then dy = self.speed * dt end
    if love.keyboard.isDown("left") then dx = -self.speed * dt end
    if love.keyboard.isDown("right") then dx = self.speed * dt end

    if dx ~= 0 or dy ~= 0 then
        local futureX = self.x + dx
        local futureY = self.y + dy

        local actualX, actualY, cols, len = self.world:move(self, futureX, futureY)
        self.x, self.y = actualX, actualY
    end
end

function Player:draw()
    love.graphics.setColor(1, 0.5, 0.5)
    love.graphics.rectangle("fill", self.x, self.y, self.w, self.h)
    love.graphics.setColor(1, 1, 1)
end

return setmetatable({}, {
    __call = function(_, ...) return Player:new(...) end
})
