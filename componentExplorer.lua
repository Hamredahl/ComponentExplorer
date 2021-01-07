local component = require("component")
local gpu = component.gpu
local event = require("event")

local on = true
local currentWindow = "Home"
local windows = {}
local sideMenu = nil
local first, last = nil


function initiate()
  drawInit(80, 23)
  windowsInhabit()
  topMenuInitiate()
  sideMenuInitiate()
  event.listen("touch", eventHandler)
end

function shutdown()
  drawShutdown()
  event.ignore("touch", eventHandler)
end

function eventHandler(_, _, x, y)
  if y <= 3 then
    if topMenuAction(x, y) then
      topMenuUpdate()
      sideMenuUpdate()
    end
  elseif y > 3 and x <= 14 then
    if sideMenuAction(x, y) then
      topMenuUpdate()
      sideMenuUpdate()
  end
  else
    windowHandlerAction(component, x, y)
  end
end

-- Draw functions

function drawInit(screenSizeX, screenSizeY)
  gpu.setBackground(0x000000)
  local x, y = gpu.maxResolution()
  gpu.fill(0,0, x, y, " ")
  gpu.setViewport(screenSizeX, screenSizeY)
end

function drawShutdown()
  gpu.setBackground(0x000000)
  local x, y = gpu.maxResolution()
  gpu.fill(0,0, x, y, " ")
  gpu.setViewport(x, y)
end

function drawMenuElement(x, y, xSize, ySize, color, t, tColor)
  gpu.setBackground(color)
  gpu.fill(x, y, xSize, ySize, " ")
  gpu.setForeground(tColor)
  gpu.set(x+((xSize-string.len(t))/2), y+((ySize-1)/2), t)
end

function drawSimpleShape(x, y, xSize, ySize, color)
  gpu.setBackground(color)
  gpu.fill(x, y, xSize, ySize, " ")
end

function setSimpleText(x, y, t, tColor)
  gpu.setForeground(tColor)
  gpu.set(x, y, t)
end

-- topMenu

function topMenuUpdate(draw)
  local tempC = 0xbbbbbb
  if currentWindow == "Home" then
    tempC = 0xbfbfbf
  end
  drawMenuElement(1, 1, 14, 3, tempC, "Home", 0x000000)
end

function topMenuAction(x, y)
  if x < 14 then
    currentWindow = "Home"
    return true
  elseif x > gpu.getViewport() - 7 then
    on = false
    return false
  else
    return false
  end
end

function topMenuInitiate()
  local x, _ = gpu.getViewport()
  drawSimpleShape(1, 1, x, 3, 0xbbbbbb)
  drawMenuElement(1, 1, 14, 3, 0xbfbfbf, "Home", 0x000000)
  drawMenuElement(x - 6, 1, 7, 3, 0xbbbbbb, "X", 0x000000)
end

-- sideMenu

function sideMenuAction(x, y)
  if y <= 20 then
    for k, v in pairs(sideMenu) do
      if y > v and y < v + 3 then
        currentWindow = k
      end
    end
    return true
  elseif x <= 7 then
    for k, v in pairs(sideMenu) do
      if sideMenu[last] > 17 then
        sideMenu[k] = v - 3
      end
    end
    return true
  else
    for k, v in pairs(sideMenu) do
      if sideMenu[first] < 3 then
        sideMenu[k] = v + 3
      end
    end
    return true
  end
end

function sideMenuUpdate()
  for k, v in pairs(sideMenu) do
    if k == currentWindow then
      drawMenuElement(1, v, 14, 3, 0xbfbfbf, k, 0x000000)
    else
      drawMenuElement(1, v, 14, 3, 0xbbbbbb, k, 0x000000)
    end
  end
end

function sideMenuInitiate()
  sideMenu = menuInhabit(windows)
  local i, l = 0, nil
  for k, v in pairs(sideMenu) do
    i = i + 1
    if i == 1 then
      first = k
    end
    drawMenuElement(1, v, 14, 3, 0xbbbbbb, k, 0x000000)
    l = k
  end
  last = l
  drawMenuElement(1, 20, 7, 3, 0xbbbbbb, "  ▽", 0x000000)
  drawMenuElement(8, 20, 7, 3, 0xbbbbbb, "  △", 0x000000)
end

function menuInhabit(t)
  local yPos, t2 = 1, {}
  for k, _ in pairs(t) do
    if k ~= "Home" then
      yPos = yPos + 3
      t2[k] = yPos
    end
  end
  return t2
end

-- windowHandler

function windowHandlerAction(component, x, y)
  windows[currentWindow].action(component, x, y)
end

function windowHandlerUpdate()
  local x, y = getViewport()
  drawSimpleShape(15, 4, x - 14, y - 3, 0x000000)
  windows[currentWindow].update(gpu)
end

function windowsInhabit()
  local pfile = io.popen('ls -a "Windows"')
  for filename in pfile:lines() do
    local file = string.sub(filename, 0, string.len(filename)-4)
    windows[file] = require("Windows/" .. file)
  end
  pfile:close()
end

-- Startup

initiate()

while on do
  windowHandlerUpdate()
  os.sleep(0.1)
end

shutdown()
