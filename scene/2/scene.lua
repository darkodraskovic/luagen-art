local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'

local inspect = require 'inspect'
local Scene = require 'lib.core.scene'
local Drawable = require 'lib.component.drawable'

local Color = require 'util.color'
local Line = require 'extension.graphics.line'
local Ellipse = require 'extension.graphics.ellipse'

local scene2 = Scene()

local w,h = love.graphics.getDimensions()

function scene2:init()
    local ys = {}
    for i = 0, 1, 1/10 do table.insert(ys, math.pow(i, 2)) end

    lines = self:addEntity(); self:addChild(lines)
    local opt = {
        points = {-w/2, 0, 1.5*w, 0}, parent = lines,
        graphics = {
            setColor = Color.palette.yellow,
        },
        pos = vector(0,h/2),
    }
    for i,v in ipairs(ys) do
        opt.pos = vector(0, h/2 + v*h/2)
        local e = self:addEntity(Line, opt)
    end
    lines.size = vector(love.graphics.getDimensions())
    lines.offset = lines.size/2
    lines.pos = lines.offset + vector(0, h*0.2)
    lines.rot = math.pi/8

    local width = 0.2*h
    local opt = {
        pos = vector(0.67*w, 0.3*h), parent = self,
        width = width, offset = vector(width/3, width/3),
        fill = Color.palette.yellow,
    }
    e1 = self:addEntity(Ellipse, opt)
    opt.pos = vector(100,0)
    opt.scl = vector(0.5, 0.5)
    opt.mode = nil
    opt.fill = Color.palette.red
    opt.parent = e1
    local e2 = self:addEntity(Ellipse, opt)
end

function scene2:update(dt)
    Scene.update(self, dt)
    e1.rot = e1.rot + dt
end

function scene2:draw()
    love.graphics.clear(Color.palette.gray_gb)

    Scene.draw(self)
end

return scene2
