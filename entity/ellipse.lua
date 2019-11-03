local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'

local Shape = require 'entity.shape'

local Ellipse = Class{
    __includes = Shape,
    type = 'line',
    name = 'line',
}

function Ellipse:init()
    Shape.init(self)
    self.properties.radius = vector(0,0)
end

function Ellipse:add(opt)
    Shape.add(self, opt)
    
    self.properties.radius = opt.radius or self.properties.radius
end

function Ellipse:draw()
    Shape.draw(self)

    local p = self.properties
    love.graphics.ellipse(p.mode, 0, 0, p.radius:unpack())
end

return Ellipse
