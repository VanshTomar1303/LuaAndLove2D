local sti = require("lib.sti")
local bump = require("lib.bump")
local Camera = require("lib.camera")

local Player = require("src.player")
local Map = require("src.map")

local game = {}


function game:load()
    self.world = bump.newWorld(32)
    self.map = Map(self.world)
    self.player = Player(self.world, 100, 100)

    self.camera = Camera()
end

function game:update(dt)
    self.player:update(dt)
    self.map:update(dt)
    self.camera:lookAt(self.player.x, self.player.y)
end

function game:draw()
    self.camera:attach()

    self.map:draw()
    self.player:draw()

    self.camera:detach()
end

return game