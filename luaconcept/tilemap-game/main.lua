local Player = require 'Player'
local bump = require 'lib.bump' -- add lib for collision 
local Camera = require 'lib.camera' -- for lib.camera
local Map = require 'Map' 
local UI = require 'UI' -- to show some debug things


walls = {} -- walls obstacle

function love.load()
    world = bump.newWorld() -- for collisions

    camera = Camera()

    map = Map.new(world) -- setting up the map

    player = Player:new(world, 100, 200) -- pass world for collision

    ui = UI.new(player)
end

function love.update(dt)
    player:update(dt)
    map:update(dt) -- updating a map

    -- Get screen size
    local sw, sh = love.graphics.getWidth(), love.graphics.getHeight()

    -- Get map pixel size (store in map object earlier)
    local mapW, mapH = map.map.width * map.map.tilewidth, map.map.height * map.map.tileheight

    -- Clamp camera to map boundaries
    local camX = math.max(sw / 2, math.min(player.x, mapW - sw / 2))
    local camY = math.max(sh / 2, math.min(player.y, mapH - sh / 2))
    camera:lookAt(camX, camY)

    -- camera:lookAt(player.x, player.y) -- follow the player
end

function love.draw()
    camera:attach() -- attach the camera to player and walls
    map:draw() -- drawing the map
    player:draw()
    camera:detach() -- detach the camera to player and walls
    ui:draw()
end
