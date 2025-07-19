local anim8 = require 'libs.anim8'

Tree = {}
Tree.__index = Tree

function Tree:new(world)

    local treeSpriteSheet = love.graphics.newImage('assets/enemy/log.png')
    local treeGrid = anim8.newGrid(32, 32, treeSpriteSheet:getWidth(), treeSpriteSheet:getHeight())

    local this = {
        x = 288,
        y = 402,
        speed = 50,
        treeSpriteSheet = treeSpriteSheet,
        walkAnimation = {
            down = anim8.newAnimation(treeGrid('1-4', 1), 0.2),
            up = anim8.newAnimation(treeGrid('1-4', 2), 0.2),
            left = anim8.newAnimation(treeGrid('1-4', 4), 0.2),
            right = anim8.newAnimation(treeGrid('1-4', 3), 0.2)
        },
        attackingAnimation = anim8.newAnimation(treeGrid(6, '1-3'), 0.2),
        sleepingAnimation = anim8.newAnimation(treeGrid(5, '1-4'), 0.2), -- idle state
        dir = 'right',
        health = 5,
        damage = 1,
        collider = nil,
        currentAnim = nil,
        isMoving = false,
        attacking = false,
        attackCooldown = 0.6,
        death = false
    }
    local collider = world:newBSGRectangleCollider(this.x, this.y, 43, 50, 9)
    collider:setFixedRotation(true)
    collider:setCollisionClass('Tree')
    collider:setObject(this) -- ✅ CORRECT: attach the player instance
    this.collider = collider

    this.currentAnim = this.sleepingAnimation

    setmetatable(this, Tree)
    return this
end

function Tree:update(dt, player)

    local px, py = player.collider:getPosition()
    local ex, ey = self.collider:getPosition()

    local dx = px - ex
    local dy = py - ey

    local distance = math.sqrt(dx * dx + dy * dy)

    -- Set direction based on player position
    local absDx = math.abs(dx)
    local absDy = math.abs(dy)
    if absDx > absDy then
        self.dir = dx > 0 and "right" or "left"
    else
        self.dir = dy > 0 and "down" or "up"
    end

    if distance < 200 then
        local vx = (dx / distance) * self.speed
        local vy = (dy / distance) * self.speed
        self.collider:setLinearVelocity(vx, vy)
        self.isMoving = true
    else
        self.isMoving = false
        self.collider:setLinearVelocity(0, 0)
    end

    if self.isMoving then
        self.walkAnimation[self.dir]:update(dt)
        self.currentAnim = self.walkAnimation[self.dir]
    else
        self.collider:setPosition(self.x, self.y)
        self.currentAnim = self.sleepingAnimation
        self.sleepingAnimation:update(dt)
    end

    -- sword attack
    if self.collider:enter("Sword") then
        local data = self.collider:getEnterCollisionData("Sword")
        local sword = data.collider:getObject()
        if sword then
            self.health = self.health - sword.damage
            print("Tree hit! Health = " .. self.health)
        end
    end

    -- death
    if self.health <= 0 then
        self.collider:destroy()
        self.death = true
    end

    if self.attacking then
        self.attackingAnimation:update(dt)
        self.attackCooldown = self.attackCooldown - dt
        if self.attackCooldown <= 0 then
            self.attacking = false
        end
    end
end

function Tree:draw()
    love.graphics.setNewFont(16)
    if self.isMoving then
        local x, y = self.collider:getPosition()
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf("HP:" .. self.health, x-20, y+20, 100, 'left')
        if self.attacking then
            self.attackingAnimation:draw(self.treeSpriteSheet, x, y, 0, 2, nil, 15, 20)
        else
            self.walkAnimation[self.dir]:draw(self.treeSpriteSheet, x, y, 0, 2, nil, 15, 20)
        end
    else
        self.sleepingAnimation:draw(self.treeSpriteSheet, self.x, self.y, 0, 2, nil, 15, 20)
        love.graphics.printf("HP:" .. self.health, self.x-45, self.y+20, 100,'center')
    end
end

return Tree
