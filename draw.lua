local draw = {}
draw.__index = draw

setmetatable(draw, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function draw.new(g)
  local self = setmetatable({}, draw)
  self.gpu = g
  return self
end

function draw:drawInit(screenSizeX, screenSizeY)
  self.gpu.setBackground(0x000000)
  local x, y = self.gpu.maxResolution()
  self.gpu.fill(0,0, x, y, " ")
  self.gpu.setViewport(screenSizeX, screenSizeY)
end

function draw:drawShutdown()
  self.gpu.setBackground(0x000000)
  local x, y = self.gpu.maxResolution()
  self.gpu.fill(0,0, x, y, " ")
  self.gpu.setViewport(x, y)
end

function draw:drawMenuElement(x, y, xSize, ySize, color, t, tColor)
  self.gpu.setBackground(color)
  self.gpu.fill(x, y, xSize, ySize, " ")
  self.gpu.setForeground(tColor)
  self.gpu.set(x+(xSize-string.len(t)/2), y+((ySize-1)/2), t)
end

function draw:drawSimpleShape(x, y, xSize, ySize, color)
  self.gpu.setBackground(color)
  self.gpu.fill(x, y, xSize, ySize, " ")
end

function draw:setSimpleText(x, y, t, tColor)
  self.gpu.setForeground(tColor)
  self.gpu.set(x, y, t)
end

return draw
