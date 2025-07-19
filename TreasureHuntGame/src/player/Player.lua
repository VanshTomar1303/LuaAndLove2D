local anim8 = require 'libs.anim8'
local Heart = require 'src.player.Heart'

Player = {}
Player.__index = Player

function Player:new(world)
    local spriteSheet = love.graphics.newImage('assets/player/character.png')
    local grid = anim8.newGrid(15, 30, spriteSheet:getWidth(), spriteSheet:getHeight(), 0, 0, 1)
    local attackGrid = anim8.newGrid(32, 31, spriteSheet:getWidth(), spriteSheet:getHeight(), 0, 0, 1)

    local this = {
        speed = 200,
        spriteSheet = spriteSheet,
        animation = {
            down = anim8.newAnimation(grid('1-4', 1), 0.2),
            right = anim8.newAnimation(grid('1-4', 2), 0.2),
            up = anim8.newAnimation(grid('1-4', 3), 0.2),
            left = anim8.newAnimation(grid('1-4', 4), 0.2),
            swordDown = anim8.newAnimation(attackGrid('1-4', 5), 0.1),
            swordUp = anim8.newAnimation(attackGrid('1-4', 6), 0.1),
            swordLeft = anim8.newAnimation(attackGrid('1-4', 8), 0.1),
            swordRight = anim8.newAnimation(attackGrid('1-4', 7), 0.1)
        },
        currentAnim = nil,
        direction = "down",
        isMoving = false,
        collider = nil,
        maxHeart = 5,
        currentHeart = 5,
        hearts = {},
        coins = 0,
        attacking = false,
        attackCooldown = 0.6,
        damage = 1,
        swordHitbox = nil,
        swordHitboxLife = 0
    }

    setmetatable(this, Player)

    local collider = world:newBSGRectangleCollider(500, 500, 30, 45, 9)
    collider:setFixedRotation(true)
    collider:setCollisionClass('Player')
    collider:setObject(this)
    this.collider = collider

    for i = 1, this.maxHeart do
        table.insert(this.hearts, Heart:new())
    end

    this.currentAnim = this.animation.down

    return this
end

function Player:update(dt, game)
    self.isMoving = false

    local vx, vy = 0, 0

    if love.keyboard.isDown('w') then
        vy = -self.speed
        self.currentAnim = self.animation.up
        self.direction = 'up'
        self.isMoving = true
    elseif love.keyboard.isDown('s') then
        vy = self.speed
        self.currentAnim = self.animation.down
        self.direction = 'down'
        self.isMoving = true
    elseif love.keyboard.isDown('d') then
        vx = self.speed
        self.currentAnim = self.animation.right
        self.direction = 'right'
        self.isMoving = true
    elseif love.keyboard.isDown('a') then
        vx = -self.speed
        self.currentAnim = self.animation.left
        self.direction = 'left'
        self.isMoving = true
    end

    self.collider:setLinearVelocity(vx, vy)

    -- Coin collision
    if self.collider:enter("Coin") then
        local data = self.collider:getEnterCollisionData("Coin")
        local coin = data.collider:getObject()
        if coin and coin.onCollect then
            coin:onCollect(game)
        end
    end

    -- Enemy collision (Tree)
    if self.collider:enter("Tree") then
        local data = self.collider:getEnterCollisionData("Tree")
        local enemy = data.collider:getObject()
        if enemy then
            game.tree.attacking = true
            game.tree.attackCooldown = 0.6
            self.currentHeart = self.currentHeart - game.tree.damage
        end
    end

    -- Handle sword hitbox lifetime
    if self.swordHitbox then
        self.swordHitboxLife = self.swordHitboxLife - dt
        if self.swordHitboxLife <= 0 then
            self.swordHitbox:destroy()
            self.swordHitbox = nil
        end
    end

    -- Handle sword cooldown and revert animation
    if self.attacking then
        self.attackCooldown = self.attackCooldown - dt
        if self.attackCooldown <= 0 then
            self.attacking = false
            self.attackCooldown = 0

            -- Return to idle animation
            if self.direction == "down" then
                self.currentAnim = self.animation.down
            elseif self.direction == "up" then
                self.currentAnim = self.animation.up
            elseif self.direction == "left" then
                self.currentAnim = self.animation.left
            elseif self.direction == "right" then
                self.currentAnim = self.animation.right
            end
        end
    end

    self.currentAnim:update(dt)

    if not self.isMoving then
        self.collider:setLinearVelocity(0, 0)
        if not self.attacking then
            self.currentAnim:gotoFrame(3)
        end
    end
end

function Player:swordAttack(world)
    self.attacking = true
    self.attackCooldown = 0.6

    local dir = self.direction
    self.currentAnim = self.animation["sword" .. dir:sub(1, 1):upper() .. dir:sub(2)]

    self:spawnSwordHitbox(world)
end

function Player:spawnSwordHitbox(world)
    local px, py = self.collider:getPosition()
    local hitboxW, hitboxH = 20, 20
    local offsetX, offsetY = 0, 0

    if self.direction == "up" then
        offsetY = -25
    elseif self.direction == "down" then
        offsetY = 25
    elseif self.direction == "left" then
        offsetX = -25
    elseif self.direction == "right" then
        offsetX = 25
    end

    local x = px + offsetX
    local y = py + offsetY

    self.swordHitbox = world:newRectangleCollider(x, y, hitboxW, hitboxH)
    self.swordHitbox:setType("dynamic")
    self.swordHitbox:setCollisionClass("Sword")
    self.swordHitbox:setObject(self)
    self.swordHitbox:setGravityScale(0)
    self.swordHitbox:setLinearVelocity(0, 0)
    self.swordHitboxLife = 0.15
end

function Player:draw()
    local x, y = self.collider:getPosition()
    self.currentAnim:draw(self.spriteSheet, x, y, 0, 2, nil, 7.5, 15)

    -- Draw sword hitbox for debug
    -- if self.swordHitbox then
    --     love.graphics.setColor(1, 0, 0, 0.5)
    --     local sx, sy = self.swordHitbox:getPosition()
    --     local sw, sh = 20,20
    --     love.graphics.rectangle("fill", sx - sw / 2, sy - sh / 2, sw, sh)
    --     love.graphics.setColor(1, 1, 1)
    -- end

    -- Draw hearts
    for i, heart in ipairs(self.hearts) do
        local hx = 20 + (i - 1) * 40
        if i <= self.currentHeart then
            heart:drawHeart(hx)
        else
            heart:drawDamagedHeart(hx)
        end
    end
end

function Player:UI()
    local boxWidth, boxHeight = 120, 80
    local margin = 100
    local screenWidth = love.graphics.getWidth()

    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", screenWidth - boxWidth - margin, margin, boxWidth, boxHeight, 10, 10)

    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("x " .. math.floor(self.collider:getX()), screenWidth - boxWidth - margin + 10, margin + 10,
        boxWidth - 20, 'left')

    love.graphics.printf("y " .. math.floor(self.collider:getY()), screenWidth - boxWidth - margin + 10, margin + 40,
        boxWidth - 20, 'left')
end

return Player
