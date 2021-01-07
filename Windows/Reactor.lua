local Reactor = {}

function Reactor.action(component, x, y)
  return
end

function Reactor.update(component, draw)
  draw:setSimpleText(component, 38, 13, "Home")
end

return Reactor
