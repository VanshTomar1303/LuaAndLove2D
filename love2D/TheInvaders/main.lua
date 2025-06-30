function love.load()
    require("src.game"):load()
end

function love.update(dt)
    require("src.game"):update(dt)
end

function love.draw()
    require("src.game"):draw()
end
