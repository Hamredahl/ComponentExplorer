local Home = {}

function Home.action(x, y)
  return
end

function Home.update(draw)
  draw.setForeground(0xffffff)
  draw.set(38, 13, "Home")
end

return Home
