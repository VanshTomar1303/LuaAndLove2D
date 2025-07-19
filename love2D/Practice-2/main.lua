local love = require 'love'
local Player = require 'Player'
local Map = require 'Map'
local Arrow = require("Arrow")
local camera = require 'libraries/camera'
local windfield = require 'libraries/windfield'

local arrows = {}

function love.load()
    world = windfield.newWorld(0,0)
    love.graphics.setDefaultFilter("nearest","nearest")
    player = Player(world)
    map = Map(world)
    cam = camera()

    map:wallsInit()
end

function love.update(dt)
    player:update(dt)

    for _, arrow in ipairs(arrows) do
        arrow:update(dt)
        if arrow.dead then
            table.remove(arrows,_)
        end
    end

    world:update(dt)

    -- camera settings to follow player
    cam:lookAt(player.x,player.y)
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    if cam.x < screenWidth/2 then
        cam.x = screenWidth/2
    end
    if cam.y < screenHeight/2 then
        cam.y = screenHeight/2
    end

    local mapW = map.gameMap.width * map.gameMap.tilewidth * map.scale
    local mapH = map.gameMap.height * map.gameMap.tileheight * map.scale

    if cam.x > (mapW - screenWidth/2) then
        cam.x = (mapW - screenWidth/2)
    end
    if cam.y > (mapH - screenHeight/2) then
        cam.y = (mapH - screenHeight/2)
    end
end

function love.draw()
    cam:attach()
        map:draw()
        player:draw()
        for _, arrow in ipairs(arrows) do
            arrow:draw()
        end
        world:draw()
    cam:detach()
end

function love.keypressed(key)
    if key == 'x' and player.arrowCount > 0 then
        table.insert(arrows, Arrow.new(player.x, player.y, player.dir, world))
        player.arrowCount = player.arrowCount - 1
    end
end