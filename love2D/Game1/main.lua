-- Save the ball GAME
local love = require("love")
local Enemy = require "Enemy"
local Button = require "Button"

math.randomseed(os.time()) -- make more value more random

local game = {
    difficulty = 1,
    state = {
        menu = true,
        paused = false,
        running = false,
        ended = false
    },
    points = 0, -- it can also be in player
    levels = {15, 30, 60, 120}
}

local fonts = {
    medium = {
        font = love.graphics.newFont(16),
        size = 16
    },
    large = {
        font = love.graphics.newFont(26),
        size = 26
    },
    xl = {
        font = love.graphics.newFont(60),
        size = 36
    },
}

local player = {
    radius = 20,
    x = 30,
    y = 30
}

local buttons = {
    menu_state = {},
    ended_state = {}
}

local enemies = {}

local function changeGameState(state)
    game.state['menu'] = state == "menu"
    game.state['paused'] = state == "paused"
    game.state['running'] = state == "running"
    game.state['ended'] = state == "ended"
end

local function startNewGame()
    changeGameState("running")

    game.points = 0

    -- table.insert(enemies,1,Enemy()) -- insert enemy in table
    enemies = {
        Enemy(1)
    }
end

function love.mousepressed(x,y,button,istouch,presses)
    if not game.state["running"] then
        if button == 1 then
            if game.state["menu"] then
                for index in pairs(buttons.menu_state) do
                    buttons.menu_state[index]:checkPressed(x,y,player.radius)
                end
            elseif game.state["ended"] then
                for index in pairs(buttons.ended_state) do
                    buttons.ended_state[index]:checkPressed(x,y,player.radius)
                end
            end  
        end
    end
end

function love.load()
    -- love.window.setTitle("Save the ball") -- set title in main file
    love.mouse.setVisible(false) -- hide the cursor
     
    -- menu button
    buttons.menu_state.play_game = Button("Play",startNewGame,nil,120,40)
    buttons.menu_state.settings = Button("Settings",nil,nil,120,40)
    buttons.menu_state.exit = Button("Exit",love.event.quit,nil,120,40)

    -- ending button
    buttons.ended_state.replay_game = Button("Replay",startNewGame,nil,200,50)
    buttons.ended_state.menu = Button("Menu",changeGameState,"menu",200,50)
    buttons.ended_state.exit = Button("Exit",love.event.quit,nil,200,50)
end

function love.update(dt)
    player.x,player.y = love.mouse.getPosition() -- move player with the mouse -- love.mouse.getPosition() it give two value x,y

    if game.state["running"] then
       for i = 1, #enemies do -- move enemy
            if not enemies[i]:checkedTouched(player.x,player.y,player.radius) then
                enemies[i]:move(player.x,player.y)
                for l = 1, #game.levels do
                    if math.floor(game.points) == game.levels[l] then
                        table.insert(enemies,1,Enemy(game.difficulty * (l+1)))
                        game.points = game.points + 1
                    end
                end
            else
                changeGameState("ended")
            end
        end  
        game.points = game.points + dt
    end
end

function love.draw()
    love.graphics.setFont(fonts.medium.font)

    love.graphics.printf(
        "FPS: "..love.timer.getFPS(),
        --love.graphics.newFont(16), -- font
        fonts.medium.font,
        10,love.graphics.getHeight() - 30, -- x,y
        love.graphics.getWidth() -- widht taken by it
    ) -- print fps on screen

    if game.state["running"] then
        love.graphics.printf(
            math.floor(game.points),
            fonts.large.font,
            0,10,
            love.graphics.getWidth(),
            "center"
        )

        for i = 1, #enemies do -- draw enemy
            enemies[i]:draw()
        end 

        love.graphics.circle("fill",player.x,player.y,player.radius) -- player
    elseif game.state["menu"] then -- draw button
        buttons.menu_state.play_game:draw(10,20,17,10)
        buttons.menu_state.settings:draw(10,70,17,10)
        buttons.menu_state.exit:draw(10,120,17,10)
    elseif game.state["ended"] then -- draw button
        love.graphics.setFont(fonts.xl.font)
        buttons.ended_state.replay_game:draw(love.graphics.getWidth()/2.5,love.graphics.getHeight()/1.8,17,10)
        buttons.ended_state.menu:draw(love.graphics.getWidth()/2.5,love.graphics.getHeight()/1.54,17,10)
        buttons.ended_state.exit:draw(love.graphics.getWidth()/2.5,love.graphics.getHeight()/1.34,17,10)

        love.graphics.printf(
            math.floor(game.points),
            fonts.large.font,
            0,love.graphics.getHeight()/2 - fonts.large.size,
            love.graphics.getWidth(),
            "center"
        )
    end

    if not game.state["running"] then
        love.graphics.circle("fill",player.x,player.y,player.radius / 2)
    end
end