local Camera = {}
local CameraLib = require("libs.camera")
local Player = require("player")

function Camera:load()
    self.camera = CameraLib(Player.x, Player.y)
    
    -- Optional: set zoom level
    self.camera:zoomTo(1)
end

function Camera:update(dt)
    -- Map boundary clamp example
    local mapWidth, mapHeight = 2000, 2000
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()

    local camX = math.max(screenWidth / 2, math.min(Player.x, mapWidth - screenWidth / 2))
    local camY = math.max(screenHeight / 2, math.min(Player.y, mapHeight - screenHeight / 2))

    self.camera:lookAt(camX, camY)
end

function Camera:attach()
    self.camera:attach()
end

function Camera:detach()
    self.camera:detach()
end

function Camera:getInstance()
    return self.camera
end

return Camera
