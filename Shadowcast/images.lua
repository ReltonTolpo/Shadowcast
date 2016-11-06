images = {}

function images.load()

	--↓ Misc images 
	images.logo64 = love.graphics.newImage("images/other/logo64.png") --A 64x64 game logo

	--↓ Player images 

	images.bPlayer = love.graphics.newImage("images/player/basicPlayerImage.png")

end

function images.update()

	--TODO LOGIC CODE

end

function UPDATE_IMAGES(dt)

	images.update()

end