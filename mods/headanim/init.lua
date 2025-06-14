local get_connected_players = minetest.get_connected_players
local abs = math.abs
local deg = math.deg
local basepos = vector.new(0, 6.35, 0)
local lastdir = {}

minetest.register_globalstep(function(dtime)
	for _, player in pairs(get_connected_players()) do
		local name = player:get_player_name()
		local ldeg = -deg(player:get_look_vertical())

		if abs((lastdir[name] or 0) - ldeg) > 4 
		and not playereffects.has_effect_type(name, "rat_polymorph")
		and not playereffects.has_effect_type(name, "blaze_polymorph")
		and not playereffects.has_effect_type(name, "dragon_polymorph")
		and not playereffects.has_effect_type(name, "bat_polymorph")
		--and not playereffects.has_effect_type(name, "invisible")
		and not playereffects.has_effect_type(name, "ghost_polymorph")
		and not playereffects.has_effect_type(name, "bunny_polymorph")
		and not playereffects.has_effect_type(name, "butterfly_polymorph")
		and not playereffects.has_effect_type(name, "troll_polymorph")
		--and not playereffects.has_effect_type(name, "priest_polymorph")
		then
	
			lastdir[name] = ldeg
			player:set_bone_position("Head", basepos, {x = ldeg, y = 0, z = 0})
		end
	end
end)

minetest.register_on_leaveplayer(function(player)
	lastdir[player:get_player_name()] = nil
end)
