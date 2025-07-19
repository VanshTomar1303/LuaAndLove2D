local anim8 = require 'libs.anim8'

Coin = {}
Coin.__index = Coin

function Coin:new(x, y, w, h, world)
    local itemSpriteSheet = love.graphics.newImage('assets/items/objects.png')
    local coinGrid = anim8.newGrid(16, 16, itemSpriteSheet:getWidth(), itemSpriteSheet:getHeight())

    local this = {
        x = x or 0,
        y = y or 0,
        coinSpriteSheet = itemSpriteSheet,
        coinAnimation = anim8.newAnimation(coinGrid('1-4', 5), 0.2),
        coinImage = coinGrid(1, 5),
        collider = nil,
        collected = false
    }
    setmetatable(this, Coin)

    if world then
        local collider = world:newRectangleCollider(x, y, w, h)
        collider:setType("static")
        collider:setFixedRotation(true)
        collider:setCollisionClass('Coin')
        collider:setObject(this) -- ✅ use `this`
        this.collider = collider
    end

    return this
end


function Coin:onCollect(game)
    if self.collider then
        self.collider:destroy()
    end
    self.collected = true

    -- ✅ Remove self from game.map.coins list
    for i, c in ipairs(game.map.coins) do
        if c == self then
            table.remove(game.map.coins, i)
            break
        end
    end

    -- ✅ Add to player's coin count
    game.player.coins = game.player.coins + 1
end


function Coin:update(dt)
    self.coinAnimation:update(dt)
end

function Coin:draw()
    if not self.collected then
        self.coinAnimation:draw(self.coinSpriteSheet, self.x, self.y, 0, 2)
    end
end

function Coin:UI(coins)
    -- Draw a background box (top-right corner)
    local boxWidth, boxHeight = 120, 40
    local margin = 20
    local screenWidth = love.graphics.getWidth()

    -- Draw semi-transparent box
    love.graphics.setColor(0, 0, 0, 0.5)
    love.graphics.rectangle("fill", screenWidth - boxWidth - margin, margin, boxWidth, boxHeight, 10, 10)

    -- Draw coin icon
    love.graphics.setColor(1, 1, 1, 1) -- reset color to white
    love.graphics.draw(self.coinSpriteSheet, self.coinImage[1], screenWidth - boxWidth - margin + 10, margin + 8, 0, 2, 2)

    -- Draw coin count text
    love.graphics.setNewFont(26)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf("x " .. tostring(coins), screenWidth - boxWidth - margin + 50, margin + 12,40,'center')

end

return Coin
