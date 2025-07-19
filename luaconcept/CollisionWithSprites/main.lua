local Player = require 'Player'
local bump = require 'lib.bump' -- add lib for collision 

walls = {} -- walls obstacle

function love.load()
    world = bump.newWorld() -- for collisions

    walls[1] = {
        x = 300,
        y = 100,
        w = 200,
        h = 50
    } -- setting the walls
    walls[2] = {
        x = 150,
        y = 300,
        w = 50,
        h = 200
    }

    for _, wall in ipairs(walls) do -- updating walls
        world:add(wall, wall.x, wall.y, wall.w, wall.h)
    end

    player = Player:new(world, 100, 200) -- pass world for collision
end

function love.update(dt)
    player:update(dt)
end

function love.draw()
    player:draw()
    love.graphics.setColor(0.3, 0.3, 0.3)
    for _, wall in ipairs(walls) do -- drawing the walls
        love.graphics.rectangle("fill", wall.x, wall.y, wall.w, wall.h)
    end
    love.graphics.setColor(1, 1, 1)

end
