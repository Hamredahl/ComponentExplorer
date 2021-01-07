local comp2 = {}

function comp2.action(component, x, y)
  return
end

function comp2.update(draw)
  draw.setForeground(0xffffff)
  draw.set(38, 13, "comp2")
end

return comp2
