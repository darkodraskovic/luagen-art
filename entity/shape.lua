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
    self.name = opt.name or self.name
    
    self.pos = (opt.pos and opt.pos:clone()) or self.pos
    self.scale = (opt.scale and opt.scale:clone()) or self.scale
    self.rot = opt.rot or self.rot
    
    for k,v in pairs(opt) do
        local p = k:gsub("^%l", string.upper)
        if love.graphics['set' .. p] then self.properties.graphics['set' .. p] = v end
    end

    self.properties.mode = opt.mode
    self.properties.fill = opt.fill
    self.properties.line = opt.line
end

function Shape._modeDraw(o, ...)
    local mode, fill, line = o.properties.mode, o.properties.fill, o.properties.line
    if mode then love.graphics[o.type](mode,...) return end
    if fill then
        love.graphics.setColor(fill)
        love.graphics[o.type]('fill',...)
    end
    if line then
        love.graphics.setColor(line)
        love.graphics[o.type]('line',...)
    end
end

function Shape:draw()
    Entity.draw(self)
    love.graphics.reset()
    for k,v in pairs(self.properties.graphics) do love.graphics[k](v) end
    love.graphics.applyTransform(self.transform)
end

return Shape
