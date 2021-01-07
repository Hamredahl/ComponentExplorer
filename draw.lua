local draw = {}

function draw.drawInit(component, screenSizeX, screenSizeY)
  component.gpu.setBackground(0x000000)
  local x, y = component.gpu.maxResolution()
  component.gpu.fill(0,0, x, y, " ")
  component.gpu.setViewport(screenSizeX, screenSizeY)
end

function draw.drawShutdown(component)
  component.gpu.setBackground(0x000000)
  local x, y = component.gpu.maxResolution()
  component.gpu.fill(0,0, x, y, " ")
  component.gpu.setViewport(x, y)
end

function draw.drawMenuElement(component, x, y, xSize, ySize, color, t, tColor)
  component.gpu.setBackground(color)
  component.gpu.fill(x, y, xSize, ySize, " ")
  component.gpu.setForeground(tColor)
  component.gpu.set(x+(xSize-string.len(t)/2), y+((ySize-1)/2), t)
end

function draw.drawSimpleShape(component, x, y, xSize, ySize, color)
  component.gpu.setBackground(color)
  component.gpu.fill(x, y, xSize, ySize, " ")
end

function draw.setSimpleText(component, x, y, t, tColor)
  component.gpu.setForeground(tColor)
  component.gpu.set(x, y, t)
end

return draw
