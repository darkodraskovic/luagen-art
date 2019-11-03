local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'

local inspect = require 'inspect'
local Scene = require 'lib.core.scene'

local Color = require 'util.color'
local Line = require 'entity.line'
local Ellipse = require 'entity.ellipse'

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
        points = {0, 0, w, 0},
        color = Color.palette.yellow,
        pos = vector(0,h/2),
    }    
    for i,v in ipairs(ys) do
        opt.pos = vector(0, h/2 + v*h/2)
        local l = self:addEntity(Line, opt)
        self.root:addChild(l)
    end

    local opt = {
        pos = vector(0.67*w, 0.25*h),
        radius = vector(0.1*h, 0.1*h),
        color = Color.palette.yellow,
    }
    local l = self:addEntity(Ellipse, opt)
    self.root:addChild(l)
end

function Scene1:draw()
    love.graphics.clear(Color.palette.gray_gb)

    Scene.draw(self)
end

return Scene1
