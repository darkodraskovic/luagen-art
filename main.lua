-- love /home/darko/Radovi/AppDev/love2d/luaart/

local vector = require 'lib.hump.vector'

local Scene1 = require 'scene.1.scene'

local scene
local cnt = 0
function love.load()
    scene = Scene1()
end

function love.update(dt)
    scene:update(dt)
end

function love.draw()
    scene:draw()
end

function love.keypressed(key)
    if key == 'c' then
        love.graphics.captureScreenshot(scene.name .. "_" .. cnt .. ".png")
        cnt = cnt + 1
    end
end
