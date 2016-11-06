main = {}
require "menu"
require "images"
require "func"
require "sockets"
require "gameView"

function love.load()

	menuOn = true

	menu.load()
	images.load()
	func.load()
	sockets.load()
	gameView.load()

end

function love.update(dt)

	UPDATE_MENU()
	UPDATE_IMAGES()
	UPDATE_FUNCTION()
	if menuOn == false then
		UPDATE_SOCKETS(dt)
	end

end

function love.draw()

	DRAW_MENU()
	if menuOn == false then
		DRAW_GAMEVIEW()
	end

end