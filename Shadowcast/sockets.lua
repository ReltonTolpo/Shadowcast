sockets = {}

local socket = require "socket"
 
-- the address and port of the server
local address, port = "localhost", 67967
 
local entity -- entity is what we'll be controlling
local updaterate = 0.1 -- how long to wait, in seconds, before requesting an update
 
local world = {} -- the empty world-state
local t -- a variable we use to help us with the update rate in love.update

function sockets.load()

	udp = socket.udp()
	udp:settimeout(0)
	udp:setpeername(address, port)
	math.randomseed(os.time()) 
	entity = tostring(math.random(99999))
	local dg = string.format("%s %s %d %d", entity, 'at', 320, 240)
	udp:send(dg) -- the magic line in question.
	t = 0
	speed = 20

end

function sockets.update(deltatime)

	t = t + deltatime -- increase t by the deltatime
 
	if t > updaterate then

		local x, y = 0, 0
		if love.keyboard.isDown('w') then y=y-(speed*t) end
		if love.keyboard.isDown('s') then y=y+(speed*t) end
		if love.keyboard.isDown('a') then x=x-(speed*t) end
		if love.keyboard.isDown('d') then x=x+(speed*t) end
		if love.keyboard.isDown('lctrl') then speed = 200 else speed = 20 end
		local dg = string.format("%s %s %f %f", entity, 'move', x, y)
		udp:send(dg)
		local dg = string.format("%s %s $", entity, 'update')
		udp:send(dg)
		t=t-updaterate -- set t for the next round

		repeat
			data, msg = udp:receive()
			if data then
				ent, cmd, parms = data:match("^(%S*) (%S*) (.*)")
				if cmd == 'at' then
					local x, y = parms:match("^(%-?[%d.e]*) (%-?[%d.e]*)$")
					assert(x and y)
					x, y = tonumber(x), tonumber(y)
					world[ent] = {x=x, y=y}
				else
					print("unrecognised command:", cmd)
				end
			elseif msg ~= 'timeout' then 
				error("Network error: "..tostring(msg))
			end
		until not data

	end

end

function sockets.draw()
	for k, v in pairs(world) do
		love.graphics.print(k, v.x, v.y)
	end
end

function UPDATE_SOCKETS(deltatime)

	sockets.update(deltatime)

end

function DRAW_SOCKETS()

	sockets.draw()

end