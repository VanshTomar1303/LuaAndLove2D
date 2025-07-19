local UI = {}
UI.__index = UI

function UI.new(player)
    local self = {
        player = player -- reference to the player
    }
    return setmetatable(self, UI)
end

function UI:draw()
    -- background box
    love.graphics.setColor(0, 0, 0, 0.6)
    love.graphics.rectangle("fill", 10, 10, 200, 60, 10)

    -- text info
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("X: " .. math.floor(self.player.x), 15, 15, 200, "left")
    love.graphics.printf("Y: " .. math.floor(self.player.y), 15, 30, 200, "left")
    love.graphics.printf("FPS: " .. love.timer.getFPS(), 15, 45, 200, "left")
end

return UI
