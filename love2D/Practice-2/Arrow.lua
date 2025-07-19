local arrowImage = love.graphics.newImage('weapons/arrow.png')

local directionVectors = {
    up = {
        x = 0,
        y = -1,
        angle = -math.pi / 2
    },
    down = {
        x = 0,
        y = 1,
        angle = math.pi / 2
    },
    left = {
        x = -1,
        y = 0,
        angle = math.pi
    },
    right = {
        x = 1,
        y = 0,
        angle = 0
    }
}

local Arrow = {}

function Arrow.new(x, y, dir, world)
    local vec = directionVectors[dir]
    local w, h = 13, 5
    if dir == "left" or dir == "right" then
        w, h = 13, 5
    end
    local collider = world:newBSGRectangleCollider(x, y, w, h, 10)

    local self = {
        x = x,
        y = y,
        speed = 400,
        direction = {
            x = vec.x,
            y = vec.y
        },
        rot = vec.angle,
        sprite = arrowImage,
        collider = collider,
        dead = false
    }

    function self:update(dt)
        local vx, vy = 0, 0
        vx = self.direction.x * self.speed
        vy = self.direction.y * self.speed

        self.collider:setLinearVelocity(vx, vy)
        self.x = self.collider:getX()
        self.y = self.collider:getY()

        if self.x < 0 or self.x > love.graphics.getWidth() or self.y < 0 or self.y > love.graphics.getHeight() then
            self.collider:destroy()
            self.dead = true -- mark for removal from arrow list
        end
    end

    function self:draw()
        local ox, oy = self.sprite:getWidth() / 2, self.sprite:getHeight() / 2

        if self.rot == math.pi then
            -- Left direction (facing left), flip around vertical center
            ox, oy = self.sprite:getWidth() / 2, self.sprite:getHeight() / 2
        elseif self.rot == 0 then
            -- Right direction (facing right)
            ox, oy = self.sprite:getWidth() / 2, self.sprite:getHeight() / 2
        elseif self.rot == math.pi / 2 then
            -- Down
            ox, oy = self.sprite:getWidth() / 2, self.sprite:getHeight() / 2
        elseif self.rot == -math.pi / 2 then
            -- Up
            ox, oy = self.sprite:getWidth() / 2, self.sprite:getHeight() / 2
        end

        love.graphics.draw(self.sprite, self.x, self.y, self.rot, 1, 1, ox, oy)
    end

    return self
end

return Arrow
