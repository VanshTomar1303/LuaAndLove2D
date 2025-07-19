_G.love = require("love") -- importing love


-- Part - 4 -> sprites/characters
function love.load() 
    _G.invader = {
        x = 0,
        y = 0,
        sprite = love.graphics.newImage("assets/spritesheet.png"), -- import images
        animation = {
            direction = "right",
            idle = true,
            frame = 1,
            max_frame = 8, -- amount of sprite
            speed = 20,
            timer = 0.1
        }
    }

    -- 5352x569
    _G.SPRITE_WIDTH, _G.SPRITE_HEIGHT = 5352, 569
    _G.QUAD_WIDTH, _G.QUAD_HEIGHT = 669, SPRITE_HEIGHT

    
    _G.quads = {}
    
    for i = 1, invader.animation.max_frame do
        quads[i] = love.graphics.newQuad(
            QUAD_WIDTH * (i-1),
            0, 
            QUAD_WIDTH,
            QUAD_HEIGHT,
            SPRITE_WIDTH,
            SPRITE_HEIGHT
        ) 
    end
end

function love.update(dt)
    -- key handler

    if love.keyboard.isDown("a") then -- left
        invader.animation.idle = false
        invader.animation.direction = "left"
        invader.x = invader.x - invader.animation.speed * invader.animation.timer
    elseif love.keyboard.isDown("d") then -- right
        invader.animation.idle = false
        invader.animation.direction = "right"
        invader.x = invader.x + invader.animation.speed * invader.animation.timer
    elseif love.keyboard.isDown("w") then -- up
        invader.animation.idle = false
        invader.animation.direction = "up"
        invader.y = invader.y - invader.animation.speed * invader.animation.timer
    elseif love.keyboard.isDown("s") then -- down
        invader.animation.idle = false
        invader.animation.direction = "down"
        invader.y = invader.y + invader.animation.speed * invader.animation.timer
    else
        invader.animation.idle = true
        invader.animation.frame = 1
    end


    if not invader.animation.idle then
        invader.animation.timer = invader.animation.timer + dt
        if invader.animation.timer > 0.2 then
            invader.animation.timer = 0.1

            invader.animation.frame = invader.animation.frame + 1
            if invader.animation.frame > invader.animation.max_frame then
                invader.animation.frame = 1
            end
        end
    end
end

function love.draw() 
    love.graphics.scale(0.3)
    if invader.animation.direction == "right" then
        love.graphics.draw(invader.sprite,quads[invader.animation.frame],invader.x,invader.y)
    elseif invader.animation.direction == "left" then
        love.graphics.draw(invader.sprite,quads[invader.animation.frame],invader.x,invader.y,0,-1,1,QUAD_WIDTH,0)
    else
        love.graphics.draw(invader.sprite,quads[invader.animation.frame],invader.x,invader.y)
    end
end


-- Part - 3 -> Keyboard input
-- function love.load() 
--     love.graphics.setBackgroundColor(145/255,137/255,199/255)

--     _G.pacman = {}
--     pacman.x = 200
--     pacman.y = 250
--     pacman.angle1 = 1
--     pacman.angle2 = 5

--     _G.food = {}
--     _G.food.x = 600
--     _G.food.eaten = false
-- end

-- function love.update(dt)
--     -- key handler 
    -- if love.keyboard.isDown("a") then -- left
    --     pacman.x = pacman.x - 1
    --     pacman.angle1 = pacman.angle1 - math.pi*dt -- rotate arc 
    --     pacman.angle2 = pacman.angle2 - math.pi*dt
    -- elseif love.keyboard.isDown("d") then -- right
    --     pacman.x = pacman.x + 1
    -- elseif love.keyboard.isDown("w") then -- up
    --     pacman.y = pacman.y - 1
    -- elseif love.keyboard.isDown("s") then -- down
    --     pacman.y = pacman.y + 1
    -- end

--     if pacman.x >= food.x then
--         food.eaten = true
--     end
-- end

-- function love.draw()
 
--     love.graphics.setColor(1,0,9) 
--     if not food.eaten then
--         love.graphics.rectangle("fill",600,200,70,70) 
--     end

--     love.graphics.arc("line",pacman.x,pacman.y,60,pacman.angle1,pacman.angle2) 
-- end



-- -- Part - 2
-- function love.load() 
--     love.graphics.setBackgroundColor(145/255,137/255,199/255)

--     _G.pacman = {}
--     pacman.x = 200
--     pacman.y = 250
--     pacman.eat = false

--     _G.food_x = 500
-- end

-- function love.update(dt) 
--     pacman.x = pacman.x + 1

--     if pacman.x >= food_x then
--         pacman.eat = true
--     end
-- end

-- function love.draw() -- it work with every frame
--     --[[
--         draw a rectengle
--         "fill"/"line" -> line only borders, fill colored rectangle
--         x
--         y
--         width
--         height
--     ]]
--     -- love.graphics.setColor(75 / 255,148 / 255,9 / 255) -- color uses rgb
--     love.graphics.setColor(1,0,9) -- color uses rgb
--     if not pacman.eat then
--         love.graphics.rectangle("fill",600,200,70,70) 
--     end
--     -- love.graphics.circle("line",100,200,50)

--     love.graphics.arc("line",pacman.x,pacman.y,60,1,5) -- in this radius,angle1,angle2
-- end






-- Part - 1
-- function love.load() -- load the data when game is executed
--     _G.num = 0
-- end

-- function love.update(dt) -- it run every 60 FPS -- dt is a single frame -- it update characters
--     num = num + 1
-- end

-- function love.draw() -- it draws every characters
--     love.graphics.print(num) -- graphics is used to draw anything
-- end