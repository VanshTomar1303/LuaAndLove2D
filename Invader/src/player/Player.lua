local anim8 = require 'libs.anim8'

Player = {}
Player.__index = Player

function Player:new()

    local playerSpriteSheets = {
        idleDown = love.graphics.newImage('assets/player/IDLE/idle_down.png'),
        idleUp = love.graphics.newImage('assets/player/IDLE/idle_up.png'),
        idleLeft = love.graphics.newImage('assets/player/IDLE/idle_left.png'),
        idleRight = love.graphics.newImage('assets/player/IDLE/idle_right.png'),
        runDown = love.graphics.newImage('assets/player/Run/run_down.png'),
        runUp = love.graphics.newImage('assets/player/Run/run_up.png'),
        runLeft = love.graphics.newImage('assets/player/Run/run_left.png'),
        runRight = love.graphics.newImage('assets/player/Run/run_right.png'),
        attack1Down = love.graphics.newImage('assets/player/ATTACK 1/attack1_down.png'),
        attack1Up = love.graphics.newImage('assets/player/ATTACK 1/attack1_up.png'),
        attack1Left = love.graphics.newImage('assets/player/ATTACK 1/attack1_left.png'),
        attack1Right = love.graphics.newImage('assets/player/ATTACK 1/attack1_right.png')
    }

    local playerGrids = {
        idleDown = anim8.newGrid(96, 80, playerSpriteSheets.idleDown:getWidth(), playerSpriteSheets.idleDown:getHeight()),
        idleUp = anim8.newGrid(96, 80, playerSpriteSheets.idleUp:getWidth(), playerSpriteSheets.idleUp:getHeight()),
        idleLeft = anim8.newGrid(96, 80, playerSpriteSheets.idleLeft:getWidth(), playerSpriteSheets.idleLeft:getHeight()),
        idleRight = anim8.newGrid(96, 80, playerSpriteSheets.idleRight:getWidth(),playerSpriteSheets.idleRight:getHeight()),
        runDown = anim8.newGrid(96, 80, playerSpriteSheets.runDown:getWidth(), playerSpriteSheets.runDown:getHeight()),
        runUp = anim8.newGrid(96, 80, playerSpriteSheets.runUp:getWidth(), playerSpriteSheets.runUp:getHeight()),
        runLeft = anim8.newGrid(96, 80, playerSpriteSheets.runLeft:getWidth(), playerSpriteSheets.runLeft:getHeight()),
        runRight = anim8.newGrid(96, 80, playerSpriteSheets.runRight:getWidth(), playerSpriteSheets.runRight:getHeight())
    }

    local this = {
        x = 1380 * 3,
        y = 1260 * 3,
        speed = 300,
        playerSpriteSheets = playerSpriteSheets,
        animation = {
            idleDown = anim8.newAnimation(playerGrids.idleDown('1-8', 1), 0.2),
            idleUp = anim8.newAnimation(playerGrids.idleDown('1-8', 1), 0.2),
            idleLeft = anim8.newAnimation(playerGrids.idleDown('1-8', 1), 0.2),
            idleRight = anim8.newAnimation(playerGrids.idleDown('1-8', 1), 0.2),
            runDown = anim8.newAnimation(playerGrids.runDown('1-8', 1), 0.2),
            runUp = anim8.newAnimation(playerGrids.runDown('1-8', 1), 0.2),
            runLeft = anim8.newAnimation(playerGrids.runDown('1-8', 1), 0.2),
            runRight = anim8.newAnimation(playerGrids.runDown('1-8', 1), 0.2)
        },
        currentAnimation = nil,
        currentPlayerSprite = nil,
        dir = 'down'
    }
    setmetatable(this, Player)

    this.currentAnimation = this.animation.idleDown
    this.currentPlayerSprite = this.playerSpriteSheets.idleDown

    return this
end

function Player:update(dt)
    local isMoving = false

    if love.keyboard.isDown('s') then
        self.y = self.y + self.speed * dt
        self.currentAnimation = self.animation.runDown
        self.currentPlayerSprite = self.playerSpriteSheets.runDown
        self.dir = 'down'
        isMoving = true
    elseif love.keyboard.isDown('w') then
        self.y = self.y - self.speed * dt
        self.currentAnimation = self.animation.runUp
        self.currentPlayerSprite = self.playerSpriteSheets.runUp
        self.dir = 'up'
        isMoving = true
    elseif love.keyboard.isDown('a') then
        self.x = self.x - self.speed * dt
        self.currentAnimation = self.animation.runLeft
        self.currentPlayerSprite = self.playerSpriteSheets.runLeft
        self.dir = 'left'
        isMoving = true
    elseif love.keyboard.isDown('d') then
        self.x = self.x + self.speed * dt
        self.currentAnimation = self.animation.runRight
        self.currentPlayerSprite = self.playerSpriteSheets.runRight
        self.dir = 'right'
        isMoving = true
    end
    
    if not isMoving then
        if self.dir == 'down' then
            self.currentAnimation = self.animation.idleDown
            self.currentPlayerSprite = self.playerSpriteSheets.idleDown
            self.dir = 'down'
        elseif self.dir == 'up' then
            self.currentAnimation = self.animation.idleUp
            self.currentPlayerSprite = self.playerSpriteSheets.idleUp
            self.dir = 'up'
        elseif self.dir == 'left' then
            self.currentAnimation = self.animation.idleLeft
            self.currentPlayerSprite = self.playerSpriteSheets.idleLeft
            self.dir = 'left'
        elseif self.dir == 'right' then
            self.currentAnimation = self.animation.idleRight
            self.currentPlayerSprite = self.playerSpriteSheets.idleRight
            self.dir = 'right'
        end
    end

    self.currentAnimation:update(dt)
end

function Player:draw()
    self.currentAnimation:draw(self.currentPlayerSprite, self.x, self.y, 0, 2.5,nil,48,40)
end

return Player
