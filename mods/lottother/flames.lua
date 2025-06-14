-- Global namespace for functions
lottfire = {}


-- 'Enable fire' setting
local fire_enabled = minetest.settings:get_bool("enable_fire")
if fire_enabled == nil then
	-- enable_fire setting not specified, check for disable_fire
	local fire_disabled = minetest.settings:get_bool("disable_fire")
	if fire_disabled == nil then
		-- Neither setting specified, check whether singleplayer
		fire_enabled = minetest.is_singleplayer()
	else
		fire_enabled = not fire_disabled
	end
end



-- Flame nodes


local blue_fire_node = {
	drawtype = "firelike",
	tiles = {{
		name = "lottother_flame_blue_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1
		}}
	},
	inventory_image = "lottother_blue_flame.png",
	paramtype = "light",
	light_source = 13,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	floodable = true,
	damage_per_second = 6,
	groups = {igniter = 2, fire = 1},
	drop = "",
	--on_flood = flood_flame
}

-- Basic flame node
local blue_flame_fire_node = table.copy(blue_fire_node)
blue_flame_fire_node.description = "Blue Fire"
blue_flame_fire_node.groups.not_in_creative_inventory = 1
blue_flame_fire_node.on_timer = function(pos)
	--if not minetest.find_node_near(pos, 1, {"group:flammable"}) then
		minetest.remove_node(pos)
		return
	--end
	-- Restart timer
	--return true
end
blue_flame_fire_node.on_construct = function(pos)
	minetest.get_node_timer(pos):start(math.random(4, 10))
end

minetest.register_node("lottother:blue_flame", blue_flame_fire_node)







local red_fire_node = {
	drawtype = "firelike",
	tiles = {{
		name = "lottother_flame_red_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1
		}}
	},
	inventory_image = "lottother_red_flame.png",
	paramtype = "light",
	light_source = 13,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	floodable = true,
	damage_per_second = 6,
	groups = {igniter = 2, fire = 1},
	drop = "",
	--on_flood = flood_flame
}

-- Basic flame node
local red_flame_fire_node = table.copy(red_fire_node)
red_flame_fire_node.description = "red Fire"
red_flame_fire_node.groups.not_in_creative_inventory = 1
red_flame_fire_node.on_timer = function(pos)
	--if not minetest.find_node_near(pos, 1, {"group:flammable"}) then
		minetest.remove_node(pos)
		return
	--end
	-- Restart timer
	--return true
end
red_flame_fire_node.on_construct = function(pos)
	minetest.get_node_timer(pos):start(math.random(4, 10))
end

minetest.register_node("lottother:red_flame", red_flame_fire_node)



local orange_fire_node = {
	drawtype = "firelike",
	tiles = {{
		name = "lottother_flame_orange_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1
		}}
	},
	inventory_image = "lottother_orange_flame.png",
	paramtype = "light",
	light_source = 13,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	floodable = true,
	damage_per_second = 10,
	groups = {igniter = 2, fire = 1},
	drop = "",
	--on_flood = flood_flame
}

-- Basic flame node
local orange_flame_fire_node = table.copy(orange_fire_node)
orange_flame_fire_node.description = "orange Fire"
orange_flame_fire_node.groups.not_in_creative_inventory = 1
orange_flame_fire_node.on_timer = function(pos)
	--if not minetest.find_node_near(pos, 1, {"group:flammable"}) then
		minetest.remove_node(pos)
		return
	--end
	-- Restart timer
	--return true
end
orange_flame_fire_node.on_construct = function(pos)
	minetest.get_node_timer(pos):start(math.random(4, 10))
end

minetest.register_node("lottother:orange_flame", orange_flame_fire_node)



local purple_fire_node = {
	drawtype = "firelike",
	tiles = {{
		name = "lottother_flame_purple_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1
		}}
	},
	inventory_image = "lottother_purple_flame.png",
	paramtype = "light",
	light_source = 13,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	floodable = true,
	damage_per_second = 10,
	groups = {igniter = 2, fire = 1},
	drop = "",
	--on_flood = flood_flame
}

-- Basic flame node
local purple_flame_fire_node = table.copy(purple_fire_node)
purple_flame_fire_node.description = "purple Fire"
purple_flame_fire_node.groups.not_in_creative_inventory = 1
purple_flame_fire_node.on_timer = function(pos)
	--if not minetest.find_node_near(pos, 1, {"group:flammable"}) then
		minetest.remove_node(pos)
		return
	--end
	-- Restart timer
	--return true
end
purple_flame_fire_node.on_construct = function(pos)
	minetest.get_node_timer(pos):start(math.random(4, 10))
end

minetest.register_node("lottother:purple_flame", purple_flame_fire_node)



local green_fire_node = {
	drawtype = "firelike",
	tiles = {{
		name = "lottother_flame_green_animated.png",
		animation = {
			type = "vertical_frames",
			aspect_w = 16,
			aspect_h = 16,
			length = 1
		}}
	},
	inventory_image = "lottother_green_flame.png",
	paramtype = "light",
	light_source = 13,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	floodable = true,
	damage_per_second = 10,
	groups = {igniter = 2, fire = 1},
	drop = "",
	--on_flood = flood_flame
}

-- Basic flame node
local green_flame_fire_node = table.copy(green_fire_node)
green_flame_fire_node.description = "green Fire"
green_flame_fire_node.groups.not_in_creative_inventory = 1
green_flame_fire_node.on_timer = function(pos)
	--if not minetest.find_node_near(pos, 1, {"group:flammable"}) then
		minetest.remove_node(pos)
		return
	--end
	-- Restart timer
	--return true
end
green_flame_fire_node.on_construct = function(pos)
	minetest.get_node_timer(pos):start(math.random(4, 10))
end

minetest.register_node("lottother:green_flame", green_flame_fire_node)



















--
-- Sound
--

-- Enable if no setting present
local flame_sound = minetest.settings:get_bool("flame_sound", true)

if flame_sound then
	local handles = {}
	local timer = 0

	-- Parameters
	local radius = 8 -- Flame node search radius around player
	local cycle = 3 -- Cycle time for sound updates

	-- Update sound for player
	function lottfire.update_player_sound(player)
		local player_name = player:get_player_name()
		-- Search for flame nodes in radius around player
		local ppos = player:get_pos()
		local areamin = vector.subtract(ppos, radius)
		local areamax = vector.add(ppos, radius)
		local fpos, num = minetest.find_nodes_in_area(
			areamin,
			areamax,
			{"lottother:blue_flame", "lottother:red_flame", "lottother:green_flame", "lottother:purple_flame", "lottother:orange_flame"}
		)
		-- Total number of flames in radius
		local flames = (num["lottother:blue_flame"] or 0) + (num["lottother:red_flame"] or 0) + (num["lottother:green_flame"] or 0) + (num["lottother:purple_flame"] or 0) + (num["lottother:orange_flame"] or 0)
		-- Stop previous sound
		if handles[player_name] then
			minetest.sound_stop(handles[player_name])
			handles[player_name] = nil
		end
		-- If flames
		if flames > 0 then
			-- Find centre of flame positions
			local fposmid = fpos[1]
			-- If more than 1 flame
			if #fpos > 1 then
				local fposmin = areamax
				local fposmax = areamin
				for i = 1, #fpos do
					local fposi = fpos[i]
					if fposi.x > fposmax.x then
						fposmax.x = fposi.x
					end
					if fposi.y > fposmax.y then
						fposmax.y = fposi.y
					end
					if fposi.z > fposmax.z then
						fposmax.z = fposi.z
					end
					if fposi.x < fposmin.x then
						fposmin.x = fposi.x
					end
					if fposi.y < fposmin.y then
						fposmin.y = fposi.y
					end
					if fposi.z < fposmin.z then
						fposmin.z = fposi.z
					end
				end
				fposmid = vector.divide(vector.add(fposmin, fposmax), 2)
			end
			-- Play sound
			local handle = minetest.sound_play("fire_fire", {
				pos = fposmid,
				to_player = player_name,
				gain = math.min(0.06 * (1 + flames * 0.125), 0.18),
				max_hear_distance = 32,
				loop = true -- In case of lag
			})
			-- Store sound handle for this player
			if handle then
				handles[player_name] = handle
			end
		end
	end

	-- Cycle for updating players sounds
	minetest.register_globalstep(function(dtime)
		timer = timer + dtime
		if timer < cycle then
			return
		end

		timer = 0
		local players = minetest.get_connected_players()
		for n = 1, #players do
			lottfire.update_player_sound(players[n])
		end
	end)

	-- Stop sound and clear handle on player leave
	minetest.register_on_leaveplayer(function(player)
		local player_name = player:get_player_name()
		if handles[player_name] then
			minetest.sound_stop(handles[player_name])
			handles[player_name] = nil
		end
	end)
end


-- Deprecated function kept temporarily to avoid crashes if mod fire nodes call it
function lottfire.update_sounds_around() end

--
-- ABMs
--

if fire_enabled then

	-- Remove flammable nodes around basic flame
	minetest.register_abm({
		label = "Remove flammable LOTT nodes",
		nodenames = {"lottother:blue_flame", "lottother:red_flame", "lottother:green_flame", "lottother:purple_flame", "lottother:orange_flame"},
		neighbors = "group:flammable",
		interval = 2,
		chance = 4,
		catch_up = false,
		action = function(pos)
			local p = minetest.find_node_near(pos, 1, {"group:flammable"})
			if not p then
				return
			end
			local flammable_node = minetest.get_node(p)
			local def = minetest.registered_nodes[flammable_node.name]
			if def.on_burn then
				def.on_burn(p)
			else
				minetest.remove_node(p)
				minetest.check_for_falling(p)
			end
		end
	})
end
