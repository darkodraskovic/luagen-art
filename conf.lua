function love.conf(t)
    t.identity = 'luagen-art'
    t.window.width = 1024
    t.window.height = 768
    t.window.x = 0
    t.window.y = 0
    t.window.title = "luagen-art"
    t.window.fullscreen = false
    t.window.msaa = 2
    
    t.modules.joystick = false
    t.modules.physics = false
end
