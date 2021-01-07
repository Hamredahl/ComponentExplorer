local component = require("component")
local event = require("event")
local draw = require("draw")
local tMenu = require("topMenu")
local sMenu = require("sideMenu")
local wHandler = require("windowHandler")

local windowHandler = wHandler.new("Home")
local sideMenu = sMenu.new(windowHandler:getWindows(), windowHandler:getCurrentWindow())
local topMenu = tMenu.new(true, windowHandler:getCurrentWindow())

function initiate()
  draw.drawInit(component, 80, 23)
  windowHandler:setWindows(windowHandler:windowsInhabit())
  topMenu:initiate(component, draw)
  sideMenu:initiate(component, draw)
  event.listen("touch", eventHandler)
end

function shutdown()
  draw.drawShutdown(component)
  event.ignore("touch", eventHandler)
end

function eventHandler(_, _, x, y)
  if y <= 3 then
    if topMenu:action(x, y) then
      windowHandler:setCurrentWindow(topMenu:getCurrentWindow())
      sideMenu:setCurrentWindow(topMenu:getCurrentWindow())
      topMenu:update(component, draw)
      sideMenu:update(component, draw)
    end
  elseif y > 3 and x <= 14 then
    if sideMenu:action(x, y) then
      windowHandler:setCurrentWindow(sideMenu:getCurrentWindow())
      topMenu:setCurrentWindow(sideMenu:getCurrentWindow())
      topMenu:update(component, draw)
      sideMenu:update(component, draw)
  end
  else
    windowHandler:action(component, x, y)
  end
end

-- Startup

initiate()

while topMenu:on() do
  windowHandler:update(component, draw)
end

shutdown()
