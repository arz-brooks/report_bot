local utils = require("samp.events.utils")

math.randomseed(os.clock())

local function check_ver()
	local response, _ = pcall(function()
		return type(isBotSpawned())
	end)
	return response
end

local function random_float(lower, greater)
	return lower + math.random() * (greater - lower)
end

local bot_move = true
local last_rate_time = os.time() + math.random(10, 60)
local last_pos = {x = 0.0, y = 0.0, z = 0.0}
local z_cam = math.random(0, 1) == 0 and random_float(-0.1, -0.2) or random_float(0.1, 0.2)

local AIM_SYNC_RATE = 8

function onLoad()
	if not check_ver() then return print("[AimSync FIX] ERROR: YOU USE OLD VERSION OF RAKSAMP LITE") end
	print("[AimSync FIX] LOADED")
	setRate(AIM_SYNC_RATE, 1000)
end

function onSendPacket(id, bs)
	if id == 203 then
		if not bot_move then
			if isBotSpawned() then
				if last_rate_time < os.time() then
					last_rate_time = os.time() + math.random(10, 60)
					local aim_data = (utils.process_outcoming_sync_data(bs, 'AimSyncData'))[1]
					aim_data.camMode = getBotVehicle() ~= 0 and 18 or 4
					aim_data.camExtZoom = 63
					aim_data.camFront.z = z_cam
				else
					return false
				end
			else
				return false
			end
		else
			bot_move = false
			return false
		end
	end
	if id == 207 or id == 200 then
		local data = id == 207 and (utils.process_outcoming_sync_data(bs, 'PlayerSyncData'))[1] or (utils.process_outcoming_sync_data(bs, 'VehicleSyncData'))[1]
		if data.position.x ~= last_pos.x or data.position.y ~= last_pos.y or data.position.z ~= last_pos.z then
			bot_move = true
		end
		last_pos = {x = data.position.x, y = data.position.y, z = data.position.z}
	end
end

function onReceiveRPC(id, bs)
	if id == 12 then -- send aim sync when setplayerpos
		local pos = {}
		pos.x = bs:readFloat()
		pos.y = bs:readFloat()
		pos.z = bs:readFloat()
		last_pos = {x = pos.x, y = pos.y, z = pos.z}
		last_rate_time = os.time() - 1
	end
end