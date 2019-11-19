-- love /home/darko/Radovi/AppDev/love2d/luaart/

local vector = require 'lib.hump.vector'
local Gamestate = require 'lib.hump.gamestate'

local resources = require 'resources'

local scene1 = require 'scene.1.scene'
local scene2 = require 'scene.2.scene'
local scene3 = require 'scene.3.scene'

local scene
local cnt = 0

function love.load()
    resources.fonts['Vera'] = love.graphics.newFont('res/font/Vera.ttf', 16)
    
    Gamestate.registerEvents()
    Gamestate.switch(scene2)
end

-- function love.keypressed(key)
--     if key == 'c' then
--         love.graphics.captureScreenshot(scene.name .. "_" .. cnt .. ".png")
--         cnt = cnt + 1
--     end
--     -- scene.signals:emit('keypressed', key)
-- end
