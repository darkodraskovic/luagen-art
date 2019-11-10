local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'

local inspect = require 'inspect'
local Scene = require 'lib.core.scene'

local Color = require 'util.color'
local Line = require 'extension.graphics.line'
local Ellipse = require 'extension.graphics.ellipse'

local Scene1 = Class{
    __includes = Scene,
    name = 'scene_1',
}

local w,h = love.graphics.getDimensions()

function Scene1:init()
    Scene.init(self)
    
    local ys = {}
    for i = 0, 1, 1/10 do table.insert(ys, math.pow(i, 2)) end

    local opt = {
        points = {0, 0, w, 0}, parent = self,
        pos = vector(0,h/2),
        graphics = {
            setColor = Color.palette.yellow,    
        }
    }    
    for i,v in ipairs(ys) do
        opt.pos = vector(0, h/2 + v*h/2)
        local e = self:addEntity(Line, opt)
    end

    local opt = {
        pos = vector(0.67*w, 0.25*h), offset = vector(0.1*h, 0.1*h),
        width = 0.2*h, parent = self,
        fill = Color.palette.yellow,
    }
    local e1 = self:addEntity(Ellipse, opt)
end

function Scene1:update(dt)
    Scene.update(self, dt)
end

function Scene1:draw()
    love.graphics.clear(Color.palette.gray_gb)

    Scene.draw(self)
end

return Scene1
