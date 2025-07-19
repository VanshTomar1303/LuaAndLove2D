-- local love = require 'love' -- can cause error

local Player = require 'Player'

function love.load()
    player = Player:new(100,200)
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    player:draw()
end