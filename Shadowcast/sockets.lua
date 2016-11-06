sockets = {}

local socket = require "socket"
 
-- the address and port of the server
local address, port = "localhost", 67967
 
local updaterate = 0.1 -- how long to wait, in seconds, before requesting an update
local t -- a variable we use to help us with the update rate in love.update
--entity  -- entity is what we'll be controlling
world = {} -- the empty world-state

function sockets.load()

	udp = socket.udp()
	udp:settimeout(0)
	udp:setpeername(address, port)
	math.randomseed(os.time()) 
	entity = tostring(math.random(99999))
	local dg = string.format("%s %s %d %d", entity, 'at', 320, 240)
	udp:send(dg) -- the magic line in question.
	t = 0

end

function sockets.update(dt)

	t = t + dt -- increase t by the deltatime
 
	if t > updaterate then

		x, y = 0, 0
		if love.keyboard.isDown('w') then y=y-(speed*dt) end
		if love.keyboard.isDown('s') then y=y+(speed*dt) end
		if love.keyboard.isDown('a') then x=x-(speed*dt) end
		if love.keyboard.isDown('d') then x=x+(speed*dt) end
		if love.keyboard.isDown('lctrl') then speed = 1000 else speed = 100 end
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

function UPDATE_SOCKETS(dt)

	sockets.update(dt)

end