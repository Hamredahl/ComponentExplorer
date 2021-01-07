local windowHandler = {}
windowHandler.__index = windowHandler

setmetatable(windowHandler, {
  __call = function (cls, ...)
    return cls.new(...)
  end,
})

function windowHandler.new(w)
  local self = setmetatable({}, windowHandler)
  self.currentWindow = w
  self.windows
  return self
end

function windowHandler:setWindows(w)
  self.windows = w
end

function windowHandler:setCurrentWindow(w)
  self.currentWindow = w
end

function windowHandler:getCurrentWindow()
  return self.currentWindow
end

function windowHandler:getWindows()
  return self.windows
end

function windowHandler:action(component, x, y)
  self.windows[self.currentWindow].action(component, x, y)
end

function windowHandler:update(component, draw)
  self.windows[self.currentWindow].update(component, draw)
end

-- No need to look below this --

function windowHandler:windowsInhabit()
  local t, pfile = {}, io.popen('ls -a "Windows"')
  for filename in pfile:lines() do
    local file = string.sub(filename, 0, string.len(filename)-4)
    t[file] = require("Windows/" .. file)
  end
  pfile:close()
  return t
end

return windowHandler
