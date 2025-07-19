local love =  require "love"
local Player = require "Player"
local Enemy = require "Enemy"

math.randomseed(os.time())

local player -- declare player

local gameOver = false

local enemies = {}
local enemySpawnTimer = 0
local enemySpawnInterval = 1  -- seconds between spawns
local enemiesToSpawn = 0
local speed = 0

local levels = {
    7, 16, 22, 28, 30
} 
local triggeredLevels = {}  

function love.load()
    player = Player()
    enemies = {
        Enemy()
    }
end

function love.update(dt)
    if not gameOver then
        player:update(dt)
        for ei = #enemies, 1, -1 do
            local enemy = enemies[ei]
            if not enemy.outScreen then
                enemy:update(dt, player.y, player.x, player.width)
            else
                table.remove(enemies, ei)
            end
            if enemy.isCollision then
                gameOver = true
            end
        end

        -- Check for new level and prepare enemy spawning
        for i = 1, #levels do
            local score = levels[i]
            if math.floor(player.points) >= score and not triggeredLevels[score] then
                triggeredLevels[score] = true
                enemiesToSpawn = 5  -- how many enemies to spawn
                enemySpawnTimer = 0 -- reset timer
                if i >= 5 then
                    gameOver = true
                end
            end
        end

        -- Handle timed enemy spawn
        if enemiesToSpawn > 0 then
            enemySpawnTimer = enemySpawnTimer + dt
            if enemySpawnTimer >= enemySpawnInterval then
                table.insert(enemies, Enemy(speed + 1))
                enemiesToSpawn = enemiesToSpawn - 1
                enemySpawnTimer = 0
                speed = speed + 1
            end
        end

    end
end


function love.draw()
    if not gameOver then
        player:draw()
        for i = 1, #enemies do
            enemies[i]:draw()
        end
    else
        love.graphics.printf(
                "Game Over",
                love.graphics.newFont(36),
                0,10,
                love.graphics.getWidth(),
                "center"
            )
        love.graphics.printf(
                "Total Points: "..math.floor(player.points),
                love.graphics.newFont(36),
                0,50,
                love.graphics.getWidth(),
                "center"
            )
    end
end
