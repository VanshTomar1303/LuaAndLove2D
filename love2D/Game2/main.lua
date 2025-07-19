local love = require "love"
local anim8 = require 'libraries/anim8'
local sti = require 'libraries/sti'
local camera = require 'libraries/camera'
local windfield = require 'libraries/windfield'

function love.load()

    world = windfield.newWorld(0,0)

    love.graphics.setDefaultFilter("nearest","nearest")
    cam  = camera()

    gameMap = sti('maps/map.lua')

    player = {}
    player.collider = world:newBSGRectangleCollider(400,250,50,90,10)
    player.collider:setFixedRotation(true)
    player.x = 400
    player.y = 400
    player.speed = 300
    player.spriteSheet = love.graphics.newImage('sprites/player-sheet.png')
    player.grid = anim8.newGrid(12, 18, player.spriteSheet:getWidth(), player.spriteSheet:getHeight())

    player.animations = {}
    player.animations.down = anim8.newAnimation(player.grid('1-4', 1), 0.2)
    player.animations.left = anim8.newAnimation(player.grid('1-4', 2), 0.2)
    player.animations.right = anim8.newAnimation(player.grid('1-4', 3), 0.2)
    player.animations.up = anim8.newAnimation(player.grid('1-4', 4), 0.2)

    player.anim = player.animations.left

    sounds = {}
    sounds.blip = love.audio.newSource("sounds/blip.wav",'static')
    sounds.music = love.audio.newSource("sounds/music.mp3",'stream')
    sounds.music:setLooping(true)

    sounds.music:play()

    walls = {}
    if gameMap.layers["walls"] then
        for i, obj in pairs(gameMap.layers["walls"].objects) do
            local width = math.max(obj.width, 0.1)
            local height = math.max(obj.height, 0.1)
            local wall = world:newRectangleCollider(obj.x,obj.y,width,height)
            wall:setType('static')
            table.insert(walls, wall)
        end
    end
    
end

function love.update(dt)

    local isMoving = false

    local vx = 0
    local vy = 0 

    if love.keyboard.isDown("w") then
        vy = player.speed * -1
        player.anim = player.animations.up
        sounds.blip:play()
        isMoving = true
    elseif love.keyboard.isDown("s") then
        vy = player.speed
        player.anim = player.animations.down
        sounds.blip:play()
        isMoving = true
    elseif love.keyboard.isDown("a") then
        vx = player.speed * -1
        player.anim = player.animations.left
        sounds.blip:play()
        isMoving = true
    elseif love.keyboard.isDown("d") then
        vx = player.speed
        player.anim = player.animations.right
        sounds.blip:play()
        isMoving = true
    end

    player.collider:setLinearVelocity(vx,vy)

    if not isMoving then
        player.anim:gotoFrame(2)
    end
    world:update(dt)

    player.x = player.collider:getX()
    player.y = player.collider:getY()

    player.anim:update(dt)

    cam:lookAt(player.x,player.y)

    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    if cam.x < screenWidth/2 then
        cam.x = screenWidth/2
    end
    if cam.y < screenHeight/2 then
        cam.y = screenHeight/2
    end
    local mapW = gameMap.width * gameMap.tilewidth
    local mapH = gameMap.height * gameMap.tileheight
    if cam.x > (mapW - screenWidth/2) then
        cam.x = (mapW - screenWidth/2)
    end
    if cam.y > (mapH - screenHeight/2) then
        cam.y = (mapH - screenHeight/2)
    end
end

function love.draw()
    cam:attach()
        -- gameMap:draw() make conflict with the camera
        gameMap:drawLayer(gameMap.layers["ground"])
        gameMap:drawLayer(gameMap.layers["trees"])
        player.anim:draw(player.spriteSheet, player.x,player.y, nil, 5,nil,6,9)
        -- world:draw() hide the collider
    cam:detach()
end