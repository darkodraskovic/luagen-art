local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'

local Entity = require 'lib.core.entity'

local Shape = Class{
    __includes = Entity,
    type = 'shape',
    name = 'shape',
}

function Shape:init()
    Entity.init(self)
    self.properties.graphics = {}
end

function Shape:add(opt)
    self.pos = opt.pos or vector(0,0)
    self.scale = opt.scale or vector(1,1)
    self.rot = opt.rot or 0
    
    for k,v in pairs(opt) do
        local p = k:gsub("^%l", string.upper)
        if love.graphics['set' .. p] then self.properties.graphics['set' .. p] = v end
    end
    self.properties.mode = opt.mode or 'fill'
end

function Shape:draw()
    Entity.draw(self)
    love.graphics.reset()
    for k,v in pairs(self.properties.graphics) do love.graphics[k](v) end
    love.graphics.applyTransform(self.transform)
end

return Shape
