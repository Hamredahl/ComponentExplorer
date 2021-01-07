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
  self.windows = windowsInhabit()
  return self
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
    t[deleteAppend(filename)] = request("Windows/" .. deleteAppend(filename))
  end
  pfile:close()
  return t
end

function windowHandler:deleteAppend(s)
  return string.sub(s, 0, string.len(s)-4)
end

return windowHandler
