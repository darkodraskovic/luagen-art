local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'
local shapes = require 'lib.HC.shapes'

local Entity = require 'lib.core.entity'
local Collider = require 'lib.component.collider'
local Draggable = require 'lib.component.draggable'

local Rectangle = require 'graphics.rectangle'

local Slider = Class{
    __includes = Entity,
    type = 'slider',
    name = 'slider',
}

local round = function(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

local clamp = function(n, low, high) return math.min(math.max(n, low), high) end

function Slider:add(opt)
    Entity.add(self, opt)
    
    local opt = Class.clone(opt)
    
    self.properties.min = opt.min or 0
    self.properties.max = opt.max or 1
    self.properties.value = opt.min
    
    self.properties.axis = opt.axis or 'x'
    local x, y, w, h = 'x', 'y', opt.bar.width, opt.handle.height
    if self.properties.axis == 'y' then
        x, y, w, h = y, x, h, w
        opt.bar.width, opt.bar.height = opt.bar.height, opt.bar.width
        opt.handle.width, opt.handle.height = opt.handle.height, opt.handle.width
    end
    self.size = vector(w,h)
    
    local shape = shapes.newPolygonShape(0,0, w,0, w,h, 0,h)
    self:addComponent(Collider, {shape = shape, offset = self.size/2})

    opt.bar.parent = self; opt.handle.parent = self
    local bar = self.scene:addEntity(Rectangle, opt.bar)
    local handle = self.scene:addEntity(Rectangle, opt.handle)

    bar.pos[y] = self.size[y]/2 - bar.size[y]/2
    self.properties.limit = {
        [x] = {0, self.size[x] - handle.size[x]},
        [y] = {handle.pos[y], handle.pos[y]}
    }
    
    if opt.interactive then
        local shape, offset = handle:getShape()
        handle:addComponent(Collider, {shape = shape, offset = offset})
        handle:addComponent(Draggable, {limit = Class.clone(self.properties.limit)})
    end
end

function Slider:getPercent()
    local axis = self.properties.axis
    local handle = self.children[2]
    local lim = self.properties.limit
    return (handle.pos[axis] - lim[axis][1]) / (lim[axis][2] - lim[axis][1])
end

function Slider:setPercent(p)
    local axis = self.properties.axis
    local handle = self.children[2]
    local lim = self.properties.limit
    p = clamp(p, 0, 1)
    handle.pos[axis] = (lim[axis][2] - lim[axis][1]) * p
end

function Slider:getValue()
    local p = self.properties
    local v = p.min + math.abs(p.max - p.min) * self:getPercent()
    return round(v, 2)
end

function Slider:setValue(v)
    local p = self.properties
    v = clamp(v, p.min, p.max)
    local percent = math.abs(v - p.min)/math.abs(p.max - p.min)
    self:setPercent(percent)
end

function Slider:draw()
    Entity.draw(self)
    self.collider:draw()
end

return Slider
