local Color = {}


Color.hex2rgb = function(hex)
    hex = hex:gsub("#","")
    return {tonumber("0x"..hex:sub(1,2))/255, tonumber("0x"..hex:sub(3,4))/255, tonumber("0x"..hex:sub(5,6))/255, tonumber("0x"..hex:sub(7,8))/255}
end

Color.palette = {
    white = {1,1,1,1},
    black = {0,0,0,0},
    gray_gb = Color.hex2rgb('334141ff'),
    yellow = Color.hex2rgb('ffdd55ff'),
    red = Color.hex2rgb('ff2b5bff'),
    blue = Color.hex2rgb('00ffebff'),
}

return Color
