local Class = require 'lib.hump.class'
local vector = require 'lib.hump.vector'

local Shape = require 'entity.shape'

local Line = Class{
    __includes = Shape,
    type = 'line',
    name = 'line',
}

function Line:init()
    Shape.init(self)
    
    self.properties.points = {0,0,0,0}
end

function Line:add(opt)
    Shape.add(self, opt)
    
    self.properties.points = opt.points or self.properties.points
end

function Line:draw()
    Shape.draw(self)

    love.graphics.line(unpack(self.properties.points))
end

return Line
