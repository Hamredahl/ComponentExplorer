local component = require("component")
local event = require("event")
local dr = require("draw")
local tMenu = require("topMenu")
local sMenu = require("sideMenu")
local wHandler = require("windowHandler")

local draw = dr.new(component.gpu)
local windowHandler = wHandler.new("Home")
local sideMenu = sMenu.new(windowHandler:getCurrentWindow())
local topMenu = tMenu.new(true, windowHandler:getCurrentWindow())

function initiate()
  draw.drawInit(80, 23)
  windowHandler:setWindows(windowHandler:windowsInhabit())
  topMenu:initiate(draw)
  sideMenu:initiate(draw)
  sideMenu:setMenu(windowHandler:getWindows())
  event.listen("touch", eventHandler)
end

function shutdown()
  draw.drawShutdown()
  event.ignore("touch", eventHandler)
end

function eventHandler(_, _, x, y)
  if y <= 3 then
    if topMenu:action(x, y) then
      windowHandler:setCurrentWindow(topMenu:getCurrentWindow())
      sideMenu:setCurrentWindow(topMenu:getCurrentWindow())
      topMenu:update(draw)
      sideMenu:update(draw)
    end
  elseif y > 3 and x <= 14 then
    if sideMenu:action(x, y) then
      windowHandler:setCurrentWindow(sideMenu:getCurrentWindow())
      topMenu:setCurrentWindow(sideMenu:getCurrentWindow())
      topMenu:update(draw)
      sideMenu:update(draw)
  end
  else
    windowHandler:action(component, x, y)
  end
end

-- Startup

initiate()

while topMenu:on() do
  windowHandler:update(draw)
end

shutdown()
