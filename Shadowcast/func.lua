func = {} -- FUNCTIONS CLASS

function func.load()

	func.getX, func.getY, func.tableFlags = love.window.getMode()
	func.coordNum = func.getX+func.getY

end

function func.update()

	func.getX, func.getY, func.tableFlags = love.window.getMode()
	func.coordNum = func.getX+func.getY

end

function UPDATE_FUNCTION()

	func.update()

end

function DRAW_FUNCTION()

end