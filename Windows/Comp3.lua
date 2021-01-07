local comp3 = {}

function comp3.action(component, x, y)
  return
end

function comp3.update(draw)
  draw.setForeground(0xffffff)
  draw.set(38, 13, "comp3")
end

return comp3
