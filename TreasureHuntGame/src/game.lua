local Map = require 'src.map'
local Player = require 'src.player.Player'
local windfield = require 'libs.windfield'
local coin = require 'src.items.Coin'
local Tree = require 'src.enemy.Tree'

local Game = {}
Game.__index = Game

function Game:new()
    love.graphics.setDefaultFilter("nearest","nearest")
    local world = windfield.newWorld(0, 0)
    world:addCollisionClass('Player')
    world:addCollisionClass('Coin')
    world:addCollisionClass('Tree')
    world:addCollisionClass('Sword')
    local player = Player:new(world)
    local map = Map:new(world)

    local this = {
        map = map,
        player = player,
        world = world,
        coinUi = coin:new(),
        tree = nil
    }

    this.tree = Tree:new(world)

    setmetatable(this, Game)
    return this
end

function Game:update(dt)
    -- Update map or player here later
    self.map:update(dt,self.player)
    self.player:update(dt,self)
    if not self.tree.death then
        self.tree:update(dt,self.player)
    end
    self.world:update(dt)
    
end

function Game:draw()
    self.map:draw()
    self.player:draw()
    if not self.tree.death then
        self.tree:draw()
    end
    --self.world:draw()
    self.coinUi:UI(self.player.coins)
    self.player:UI()
end

function Game:keypressed(key)
    if key == 'x' then
        self.player:swordAttack(self.world)
    end
end

return Game
