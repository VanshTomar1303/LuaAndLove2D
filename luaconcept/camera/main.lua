local Player = require 'Player'
local bump = require 'lib.bump' -- add lib for collision 
local Camera = require 'lib.camera' -- for lib.camera

walls = {} -- walls obstacle

function love.load()
    world = bump.newWorld() -- for collisions

    camera = Camera()

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
    camera:lookAt(player.x,player.y) -- follow the player
end

function love.draw()
    camera:attach() -- attach the camera to player and walls
        player:draw()
        love.graphics.setColor(0.3, 0.3, 0.3)
        for _, wall in ipairs(walls) do -- drawing the walls
            love.graphics.rectangle("fill", wall.x, wall.y, wall.w, wall.h)
        end
        love.graphics.setColor(1, 1, 1)
    camera:detach() -- detach the camera to player and walls
end
