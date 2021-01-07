local sideMenu = {}
sideMenu.__index = sideMenu

setmetatable(sideMenu, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function sideMenu.new(t, w)
  local self = setmetatable({}, sideMenu)
  self.first = nil
  self.last = nil
  self.menu = menuInhabit(t)
  self.currentWindow = w
  return self
end

function sideMenu:action(x, y)
  if y <= 20 then
    for k, v in pairs(self.menu) do
      if y > v and y < v + 3 then
        self.currentWindow = k
      end
    end
    return true
  elseif x <= 7 then
    for k, v in pairs(self.menu) do
      if self.menu[self.last] > 17 then
        self.menu[k] = v - 3
      end
    end
    return true
  else
    for k, v in pairs(self.menu) do
      if self.menu[self.first] < 3 then
        self.menu[k] = v + 3
      end
    end
    return true
  end
end

-- comment

function sideMenu:update(component, draw)
  for k, v in pairs(self.menu) do
    if k == self.currentWindow then
      draw:drawMenuElement(component, 1, v, 14, 3, 0xbfbfbf, k, 0x000000)
    else
      draw:drawMenuElement(component, 1, v, 14, 3, 0xbbbbbb, k, 0x000000)
    end
  end
end

function sideMenu:getCurrentWindow()
  return self.currentWindow
end

function sideMenu:setCurrentWindow(w)
  self.currentWindow = w
  update()
end

function sideMenu:initiate(component, draw)
  local i, tSize = 0, table.getn(self.menu)
  for k, v in pairs(self.menu) do
    i = i + 1
    if i == 1 then
      self.first = k
    elseif i == tSize then
      self.last = k
    end
    draw:drawMenuElement(component, 1, v, 14, 3, 0xbbbbbb, k, 0x000000)
  end
  local _, arrowPos = component.gpu.getViewport() - 3
  draw:drawMenuElement(component, 1, arrowPos, 7, 3, 0xbbbbbb, "▽", 0x000000)
  draw:drawMenuElement(component, 8, arrowPos, 7, 3, 0xbbbbbb, "△", 0x000000)
end

function sideMenu:menuInhabit(t)
  local yPos, t2 = 1, {}
  for k, _ in pairs(t) do
    if k ~= "Home" then
      yPos = yPos + 3
      t2[k] = yPos
    end
  end
  return t2
end

return sideMenu
