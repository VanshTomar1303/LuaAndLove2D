local Game = require 'src.Game'

function love.load()
    love.graphics.setDefaultFilter('nearest','nearest')
    game = Game:new()
end

function love.update(dt)
    game:update(dt)
end

function love.draw()
    game:draw()
end