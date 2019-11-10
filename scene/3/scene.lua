local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'

local inspect = require 'inspect'
local Scene = require 'lib.core.scene'
local Collider = require 'lib.component.collider'
local Drawable = require 'lib.component.drawable'
local Draggable = require 'lib.component.draggable'

local Color = require 'util.color'
local Rectangle = require 'extension.graphics.rectangle'
local Ellipse = require 'extension.graphics.ellipse'
local Text = require 'extension.graphics.text'

local Slider = require 'extension.ui.slider'
local Checkbox = require 'extension.ui.checkbox'

local Scene3 = Class{
    __includes = Scene,
    name = 'scene_3',
}

local w,h = love.graphics.getDimensions()

function Scene3:init()
    Scene.init(self)
    self.signals:register('keypressed', function(key) self:keypressed(key) end)

    local opt = {
        min = -12, max = 12, axis = 'y', interactive = true, parent = self,
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
    r0.pos = vector(300,300)

    local txtOpt = {
        size = r0.size, hAlign = 'center', parent = r0, vAlign = 'bellow',
        graphics = { setColor = Color.palette.yellow}}
    t0 = self:addEntity(Text, txtOpt)
    r0:setValue(0)

    opt = {
        parent = self, pos = vector(100,100),
        outer = {
            fill = Color.palette.gray_dark,
            width = 32, height = 32,            
        },
        inner  = {
            fill = Color.palette.gray,
            width = 20, height = 20,
        }
    }
    cb1 = self:addEntity(Checkbox, opt)
    local txtOpt = {
        size = cb1.size, hAlign = 'center', parent = cb1, vAlign = 'bellow',
        text = tostring(cb1.checked),
        graphics = { setColor = Color.palette.yellow}}
    t1 = self:addEntity(Text, txtOpt)
    cb1:register('checked', function(e, checked) t1.properties.text = tostring(e.checked) end)
    
end

function Scene3:keypressed(key)
    -- print("keypressed", key)
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
