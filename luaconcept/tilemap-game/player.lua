local anim8 = require 'lib.anim8' -- library for animation

Player = {} -- class
Player.__index = Player -- object

function Player:new(world, x, y) -- constructor

    local image = love.graphics.newImage('assets/character.png')
    image:setFilter("nearest", "nearest") -- to remove blur after scaling the image
    local grid = anim8.newGrid(16, 33, image:getWidth(), image:getHeight())
    local animations = {
        down = anim8.newAnimation(grid('1-4', 1), 0.1),
        left = anim8.newAnimation(grid('1-4', 4), 0.1),
        right = anim8.newAnimation(grid('1-4', 2), 0.1),
        up = anim8.newAnimation(grid('1-4', 3), 0.1)
    }

    local self = {
        x = x,
        y = y,
        width = 50,
        height = 50,
        speed = 300,
        world = world, -- store world in player
        sprite = image, -- adding image
        animations = animations, -- adding animations
        currentAnim = animations.down, -- current animation
        moving = false -- to check if character is moving or not
    }

    setmetatable(self, Player) -- setting self in class

    world:add(self, x, y, self.width, self.height) -- add to bump world

    return self -- returning the self
end

function Player:update(dt)
    self.moving = false -- initialy it's false

    local goalX, goalY = self.x, self.y -- Where you want the object to go

    if love.keyboard.isDown('w') then -- up
        goalY = goalY - self.speed * dt
        self.currentAnim = self.animations.up -- changing animation according to movement
        self.moving = true -- setting it to true
    elseif love.keyboard.isDown('s') then -- down
        goalY = goalY + self.speed * dt
        self.currentAnim = self.animations.down -- changing animation according to movement
        self.moving = true -- setting it to true
    elseif love.keyboard.isDown('a') then -- left
        goalX = goalX - self.speed * dt
        self.currentAnim = self.animations.left -- changing animation according to movement
        self.moving = true -- setting it to true
    elseif love.keyboard.isDown('d') then -- right
        goalX = goalX + self.speed * dt
        self.currentAnim = self.animations.right -- changing animation according to movement 
        self.moving = true -- setting it to true
    end

    local actualX, actualY, cols, len = self.world:move(self, goalX, goalY) -- Where Bump allows the object to move after checking collisions
    self.x, self.y = actualX, actualY
    if self.moving then -- if moving then update animation
        self.currentAnim:update(dt) -- updating the animation
    end
end

function Player:draw()
    love.graphics.setColor(1, 0.8, 0.5)
    -- self.currentAnim:draw(self.sprite,self.x,self.y,nil,5,nil,6,9) -- drawing the aimations
    if self.moving then -- if moving then the nimation
        self.currentAnim:draw(self.sprite, self.x, self.y, nil, 5, nil, 6, 9)
    else -- if not moving then a standing player image
        local frame = self.currentAnim.frames[2] -- idle frame
        love.graphics.draw(self.sprite, frame, self.x, self.y, nil, 5, nil, 6, 9)
    end

    love.graphics.setColor(1, 1, 1)
end

return Player
