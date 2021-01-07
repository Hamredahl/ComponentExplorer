local Home = {}

function Home.action(component, x, y)
  return
end

function Home.update(component, draw)
  draw:setSimpleText(component, 38, 13, "Home")
end

return Home
