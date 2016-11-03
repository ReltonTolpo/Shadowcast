main = {}
require "menu"
require "images"
require "func"
require "sockets"

function love.load()

	menuOn = true

	menu.load()
	images.load()
	func.load()
	sockets.load()

end

function love.update(deltatime)

	UPDATE_MENU()
	UPDATE_IMAGES()
	UPDATE_FUNCTION()
	if menuOn == false then
		UPDATE_SOCKETS(deltatime)
	end

end

function love.draw()

	DRAW_MENU()
	DRAW_FUNCTION()
	if menuOn == false then
		DRAW_SOCKETS()
	end

end