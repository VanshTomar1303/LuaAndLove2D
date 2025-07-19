local sti = require 'lib.sti' -- used for load and draw maps

local Map = {} -- map class
Map.__index = Map -- onject

function Map.new(world)
    local map = sti('assets/map-1.lua',{"bump"}) -- load map and bump plugin for collision

    map:bump_init(world) -- attach to bump world -- also added collision layer
    
    local width = map.width * map.tilewidth
    local height = map.height * map.tileheight

    return setmetatable({map = map},Map) -- adding map to class
end

function Map:update(dt)
    self.map:update(dt) -- update map
end

function Map:draw()
    -- self.map:draw() -- draw the map
    self.map:drawLayer(self.map.layers['ground'])
    self.map:drawLayer(self.map.layers['walls'])
end


return Map