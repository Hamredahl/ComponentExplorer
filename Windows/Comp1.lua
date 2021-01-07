local Comp1 = {}

function Comp1.action(component, x, y)
  return
end

function Comp1.update(draw)
  draw.setForeground(0xffffff)
  draw.set(38, 13, "Comp1")
end

return Comp1
