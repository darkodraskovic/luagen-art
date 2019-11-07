-- love /home/darko/Radovi/AppDev/love2d/luaart/

local vector = require 'lib.hump.vector'

local resources = require 'resources'

local Scene1 = require 'scene.1.scene'
local Scene2 = require 'scene.2.scene'
local Scene3 = require 'scene.3.scene'

local scene
local cnt = 0
function love.load()
    resources.fonts['Vera'] = love.graphics.newFont('res/font/Vera.ttf', 16)
    
    scene = Scene3()
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
    scene.signals:emit('keypressed', key)
end


function love.mousepressed(x, y, button)
    scene.signals:emit('mousepressed', x, y, button)
end

function love.mousereleased(x, y, button)
    scene.signals:emit('mousereleased', x, y, button)
end
