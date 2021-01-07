local topMenu = {}
topMenu.__index = topMenu

setmetatable(topMenu, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function topMenu.new(on, w)
  local self = setmetatable({}, topMenu)
  self.on = on
  self.currentWindow = w
  return self
end

function topMenu:setCurrentWindow(w)
  self.currentWindow = w
end

function topMenu:on()
  return on
end

function topMenu:update(component, draw)
  local tempC = 0xbbbbbb
  if self.currentWindow() == "Home" then tempC = 0xbfbfbf end
  draw:drawMenuElement(component, 1, 1, 14, 3, tempC, "Home", 0x000000)
end

function topMenu:action(x, y)
  if x < 14 then
    self.currentWindow = "Home"
    return true
  elseif x > 17 then
    self.on = false
    return false
  else
    return false
  end
end

function topMenu:initiate(component, draw)
  draw:drawSimpleShape(component, 1, 1, 23, 3, 0xbbbbbb)
  draw:drawMenuElement(component, 1, 1, 14, 3, 0xbfbfbf, "Home", 0x000000)
  draw:drawMenuElement(component, component.gpu.getViewport() - 6, 1, 7, 3, 0xbbbbbb, "X", 0x000000)
end

return topMenu
