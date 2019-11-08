local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'

local inspect = require 'inspect'
local Scene = require 'lib.core.scene'
local Drawable = require 'lib.component.drawable'

local Color = require 'util.color'
local Line = require 'graphics.line'
local Ellipse = require 'graphics.ellipse'

local Scene2 = Class{
    __includes = Scene,
    name = 'scene_2',
}

local w,h = love.graphics.getDimensions()

function Scene2:init()
    Scene.init(self)

    local ys = {}
    for i = 0, 1, 1/10 do table.insert(ys, math.pow(i, 2)) end

    local opt = {
        points = {-w/2, 0, 1.5*w, 0},
        graphics = {
            setColor = Color.palette.yellow,
        },
        pos = vector(0,h/2),
    }
    lines = self:addEntity()
    self.root:addChild(lines)
    for i,v in ipairs(ys) do
        opt.pos = vector(0, h/2 + v*h/2)
        local e = self:addEntity(Line, opt)
        lines:addChild(e)
    end
    lines.size = vector(love.graphics.getDimensions())
    lines.offset = lines.size/2
    lines.pos = lines.offset + vector(0, h*0.2)
    lines.rot = math.pi/8

    local opt = {
        pos = vector(0.67*w, 0.3*h),
        width = 0.2*h,
        mode = 'fill',
        graphics = {
            setColor = Color.palette.yellow,
        }
    }
    e1 = self:addEntity(Ellipse, opt)
    self.root:addChild(e1)
    opt.pos = vector(100,0)
    opt.scale = vector(0.5, 0.5)
    opt.mode = nil
    opt.fill = Color.palette.red
    local e2 = self:addEntity(Ellipse, opt)
    e1:addChild(e2)
end

function Scene2:update(dt)
    Scene.update(self, dt)
    e1.rot = e1.rot + dt
end

function Scene2:draw()
    love.graphics.clear(Color.palette.gray_gb)

    Scene.draw(self)
end

return Scene2
