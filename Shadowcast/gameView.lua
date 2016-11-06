gameView = {}
require "sockets"
require "images"

function gameView.load()

	speed = 100
	doOnce = true

end

function gameView.draw()

	--[[if doOnce == true then
		random = love.math.random(1, 255)
		doOnce = false
	end]]

	for k, v in pairs(world) do
		r, g, b = k/10000, k/10000, k/10000
		r = r * 100
		g = g * 100
		b = b * 100
		print(r)
		love.graphics.setColor(r, g, b)
		love.graphics.draw(images.bPlayer, v.x, v.y)
	end

end

function DRAW_GAMEVIEW()

	gameView.draw()

end