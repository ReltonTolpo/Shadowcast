menu = {}
require "images"

function menu.load()

	--TODO Code

end

function menu.update()

	if love.keyboard.isDown("space") and menuOn == true then
		menuOn = not menuOn
		love.timer.sleep(0.5)
	end

end

function menu.draw()

	if menuOn == true then
		love.graphics.draw(images.logo64, func.getX/4.8, 0, 0, func.coordNum/170, func.coordNum/170)
		love.graphics.print("Press SPACE to start", func.getX/6.2, func.getY/1.5, 0, func.coordNum/300, func.coordNum/300)
	end

end

function UPDATE_MENU()

	menu.update()

end

function DRAW_MENU()

	menu.draw()

end