local Map = require 'src.map'
local Player = require 'src.player.Player'
local Camera = require 'libs.camera'

Game = {}
Game.__index=Game

function Game:new()
    local this = {
        map = Map:new(),
        player = Player:new(),
        cam = Camera()
    }
    setmetatable(this,Game)

    return this
end

function Game:update(dt)
    self.map:update(dt)
    self.player:update(dt)

    self.cam:lookAt(self.player.x,self.player.y)

    -- fixing cam not to show extra space
    local sw = love.graphics.getWidth()
    local sh = love.graphics.getHeight()
    if self.cam.x < sw/2 then -- left side
        self.cam.x = sw/2
    end
    if self.cam.y < sh/2 then -- up side
        self.cam.y = sh/2
    end
    -- for right and down
    local mapW = self.map.map.width * self.map.map.tilewidth * 3
    local mapH = self.map.map.height * self.map.map.tileheight * 3 

    if self.cam.x > (mapW - sw/2) then -- right side
        self.cam.x = (mapW - sw/2)
    end
    if self.cam.y > (mapH - sh/2) then -- down side
        self.cam.y = (mapH - sh/2)
    end
end

function Game:draw()
    self.cam:attach()
        self.map:draw()   
        self.player:draw()
    self.cam:detach()
end

return Game