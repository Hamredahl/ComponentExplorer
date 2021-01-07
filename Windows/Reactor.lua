local Reactor = {}

function Reactor.action(component, x, y)
  return
end

function Reactor.update(draw)
  draw.setForeground(0xffffff)
  draw.set(38, 13, "Reactor")
end

return Reactor
