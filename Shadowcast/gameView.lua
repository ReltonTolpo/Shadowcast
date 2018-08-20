gameView = {}
require "sockets"
require "images"

function gameView.load()

	speed = 100

end

function gameView.draw()

	for k, v in pairs(world) do
		love.graphics.setColor(100, 100, 100)
		love.graphics.draw(images.bPlayer, v.x, v.y)
	end

end

function DRAW_GAMEVIEW()

	gameView.draw()

end