local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'

local inspect = require 'inspect'
local Scene = require 'lib.core.scene'
local Drawable = require 'lib.component.drawable'

local Color = require 'util.color'
local Rectangle = require 'graphics.rectangle'
local Ellipse = require 'graphics.ellipse'
local Text = require 'graphics.text'

local Slider = require 'ui.slider'

local Scene3 = Class{
    __includes = Scene,
    name = 'scene_3',
}

local w,h = love.graphics.getDimensions()

function Scene3:init()
    Scene.init(self)
    self.signals:register('keypressed', function(key) self:keypressed(key) end)

    local opt = {
        min = -12, max = 12, axis = 'y', interactive = true,
    }
    opt.bar = {
        fill = Color.palette.gray_dark,
        width = 256, height = 16,
    }
    opt.handle = {
        fill = Color.palette.gray,
        width = 16, height = 32,
    }
    r0 = self:addEntity(Slider, opt)
    r0.pos = vector(100,100)
    self.root:addChild(r0)
    
    t0 = self:addEntity(
        Text,
        {size = r0.size, hAlign = 'center',
         color = Color.palette.yellow})
    -- t0.pos.y = 40
    r0:addChild(t0)
    r0:setValue(0)
end

function Scene3:keypressed(key)

end

function Scene3:update(dt)
    Scene.update(self, dt)
end

function Scene3:draw()
    love.graphics.clear(Color.palette.gray_gb)

    t0.properties.text = r0:getValue()

    Scene.draw(self)
end

return Scene3
