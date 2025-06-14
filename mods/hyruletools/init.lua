
local players = {}

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	players[name] = true
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	players[name] = nil
end)




minetest.register_node("hyruletools:beaconb", {
	description = "Beacon (red)",
	drawtype = "glasslike",
	tiles = {"hyruletools_beacon_boxb.png"},
	use_texture_alpha = "blend",
	paramtype = "light",
	light_source = 5,
	groups = {cracky=1, oddly_breakable_by_hand=1},
	on_construct = function(pos, node, clicker, itemstack)
		if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "air" then
			minetest.set_node({x=pos.x, y=pos.y+1, z=pos.z}, {name="hyruletools:beacon_lightb"})
		end
	end,
	on_destruct = function(pos, oldnode)
		if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "hyruletools:beacon_lightb" then
			minetest.remove_node({x=pos.x, y=pos.y+1, z=pos.z})
		end
	end,
	sounds = default.node_sound_glass_defaults()
})

minetest.register_node("hyruletools:beacon_lightb", {
	description = "Beacon Light",
	tiles = {"hyruletools_beaconb.png"},
	use_texture_alpha = "blend",
	drawtype = "nodebox",
	paramtype = "light",
	pointable = false,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.3125, 0.3125, 0.5, 0.3125}, -- NodeBox1
		}
	},
	light_source = 12,
	groups = {cracky=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	walkable = false,
	drop = "",
	on_construct = function(pos, node)
	if pos.y >= 41000 then return end
		if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "air" then
			minetest.set_node({x=pos.x, y=pos.y+1, z=pos.z}, {name="hyruletools:beacon_lightb"})
		end
	end,
	on_destruct = function(pos, oldnode)
		if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "hyruletools:beacon_lightb" then
			minetest.remove_node({x=pos.x, y=pos.y+1, z=pos.z})
		end
	end,
	sounds = default.node_sound_glass_defaults()
})

minetest.register_abm({
	nodenames = {"hyruletools:beaconb"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		minetest.add_particle({
			pos = {x=pos.x, y=pos.y+0.1, z=pos.z},
			velocity = {x=0, y=0, z=0},
			acceleration = {x=0, y=0, z=0},
			expirationtime = 5,
			size = 30,
			collisiondetection = false,
			collisionremoval = false,
			vertical = false,
			texture = "hyruletools_beacon_centerb.png",
			animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 0.30},
			glow = 9
		})
	end
})

minetest.register_node("hyruletools:beacon", {
	description = "Beacon (blue)",
	drawtype = "glasslike",
	tiles = {"hyruletools_beacon_box.png"},
	use_texture_alpha = "blend",
	paramtype = "light",
	light_source = 5,
	groups = {cracky=1, oddly_breakable_by_hand=1},
	on_construct = function(pos, node, clicker, itemstack)
		if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "air" then
			minetest.set_node({x=pos.x, y=pos.y+1, z=pos.z}, {name="hyruletools:beacon_light"})
		end
	end,
	on_destruct = function(pos, oldnode)
		if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "hyruletools:beacon_light" then
			minetest.remove_node({x=pos.x, y=pos.y+1, z=pos.z})
		end
	end,
	sounds = default.node_sound_glass_defaults()
})

minetest.register_node("hyruletools:beacon_light", {
	description = "Beacon Light",
	tiles = {"hyruletools_beacon.png"},
	use_texture_alpha = "blend",
	drawtype = "nodebox",
	paramtype = "light",
	pointable = false,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.3125, -0.5, -0.3125, 0.3125, 0.5, 0.3125}, -- NodeBox1
		}
	},
	light_source = 12,
	groups = {cracky=1, oddly_breakable_by_hand=1, not_in_creative_inventory=1},
	walkable = false,
	drop = "",
	on_construct = function(pos, node)
	if pos.y >= 41000 then return end
		if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "air" then
			minetest.set_node({x=pos.x, y=pos.y+1, z=pos.z}, {name="hyruletools:beacon_light"})
		end
	end,
	on_destruct = function(pos, oldnode)
		if minetest.get_node({x=pos.x, y=pos.y+1, z=pos.z}).name == "hyruletools:beacon_light" then
			minetest.remove_node({x=pos.x, y=pos.y+1, z=pos.z})
		end
	end,
	sounds = default.node_sound_glass_defaults()
})

minetest.register_abm({
	nodenames = {"hyruletools:beacon"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		minetest.add_particle({
			pos = {x=pos.x, y=pos.y+0.1, z=pos.z},
			velocity = {x=0, y=0, z=0},
			acceleration = {x=0, y=0, z=0},
			expirationtime = 5,
			size = 30,
			collisiondetection = false,
			collisionremoval = false,
			vertical = false,
			texture = "hyruletools_beacon_center.png",
			animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 0.30},
			glow = 2
		})
	end
})

minetest.register_craft({
	output = 'hyruletools:beacon',
	recipe = {
		{'default:glass'},
		{'dye:blue'},
	}
})

minetest.register_craft({
	output = 'hyruletools:beaconb',
	recipe = {
		{'default:glass'},
		{'dye:red'},
	}
})


minetest.register_node("hyruletools:shield", {
	description = "Wall Shield",
	drawtype = "signlike",
	tiles = {"hyruletools_swdshld.png"},
	inventory_image = "hyruletools_swdshld.png",
	wield_image = "hyruletools_swdshld.png",
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	is_ground_content = false,
	walkable = false,
	selection_box = {
		type = "wallmounted",
	},
	groups = {choppy=2,dig_immediate=2,attached_node=1}})

minetest.register_craft( {
	output = "hyruletools:shield 1",
	recipe = {
		{ "default:steel_ingot", "", "default:steel_ingot" },
		{ "default:steel_ingot", "", "default:steel_ingot" },
		{ "", "lottweapons:copper_spear", "" }
	}
})



minetest.register_craftitem("hyruletools:ocarina", {
	description = "Ocarina",
	inventory_image = "hyruletools_ocarina.png",
	on_use = function(pos, placer)
		local sound_pos = placer:get_pos()
		minetest.sound_play("ocarina1", {object = placer, gain = 0.5, max_hear_distance = 15})
		local dir = placer:get_look_dir();
			local playerpos = placer:getpos();
			minetest.add_particlespawner(
			5, --amount
			0.1, --time
			{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
			{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
			{x=-0, y=-0, z=-0}, --minvel
			{x=0, y=0, z=0}, --maxvel
			{x=-0.5,y=4,z=-0.5}, --minacc
			{x=0.5,y=4,z=0.5}, --maxacc
			0.5, --minexptime
			1, --maxexptime
			1, --minsize
			2, --maxsize
			false, --collisiondetection
			"hyruletools_note.png" --texture
		)
	end
})

minetest.register_craft({
	output = "hyruletools:ocarina",
	recipe = {
		{"", "", ""},
		{"", "default:coalblock", ""},
		{"default:clay", "default:clay",  "default:clay"}
	}
})

minetest.register_craftitem("hyruletools:ocarina2", {
	description = "Bunny Ocarina",
	inventory_image = "hyruletools_ocarina_red.png",
	on_use = function(pos, placer, itemstack)
		
		local player = placer:get_player_name()
		
		if mana.subtract(player, 20) then
			local sound_pos = placer:get_pos()
			minetest.sound_play("ocarina2", {object = placer, gain = 0.5, max_hear_distance = 15})
			local dir = placer:get_look_dir();
				local playerpos = placer:getpos();
				minetest.add_particlespawner(
				5, --amount
				0.1, --time
				{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
				{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
				{x=-0, y=-0, z=-0}, --minvel
				{x=0, y=0, z=0}, --maxvel
				{x=-0.5,y=4,z=-0.5}, --minacc
				{x=0.5,y=4,z=0.5}, --maxacc
				0.5, --minexptime
				1, --maxexptime
				1, --minsize
				2, --maxsize
				false, --collisiondetection
				"hyruletools_note.png" --texture
			)
			
			local playerpos = placer:getpos();
			if math.random(10) == 1 then
				local dir = placer:get_look_dir();
				local obj = minetest.env:add_entity({x=playerpos.x+1+dir.x,y=playerpos.y+1+dir.y,z=playerpos.z+1+dir.z}, "lottmobs:bunny")
			end
			
			--[[
			local playerpos = placer:getpos();
			local dir = placer:get_look_dir();
			local player = placer:get_player_name()
			if minetest.setting_getbool("enable_weather") then	
			hyrule_weather.weather = "storm"
			hyrule_weather.current = 3
			else
			minetest.chat_send_player(player, "weather not enabled!")
			end
			]]
		end
	end
})

minetest.register_craft({
	output = "hyruletools:ocarina2",
	recipe = {
		{"", "", ""},
		{"", "dye:red", ""},
		{"", "hyruletools:ocarina",  ""}
	}
})

minetest.register_craftitem("hyruletools:ocarina3", {
	description = "Pig Ocarina",
	inventory_image = "hyruletools_ocarina_yellow.png",
	on_use = function(pos, placer, itemstack)
		
		local player = placer:get_player_name()
		
		if mana.subtract(player, 20) then
			minetest.sound_play("ocarina3", {object = placer, gain = 0.5, max_hear_distance = 15})
			local dir = placer:get_look_dir();
				local playerpos = placer:getpos();
				minetest.add_particlespawner(
				5, --amount
				0.1, --time
				{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
				{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
				{x=-0, y=-0, z=-0}, --minvel
				{x=0, y=0, z=0}, --maxvel
				{x=-0.5,y=4,z=-0.5}, --minacc
				{x=0.5,y=4,z=0.5}, --maxacc
				0.5, --minexptime
				1, --maxexptime
				1, --minsize
				2, --maxsize
				false, --collisiondetection
				"hyruletools_note.png" --texture
			)
			local playerpos = placer:getpos();
			if math.random(10) == 1 then
				local dir = placer:get_look_dir();
				local obj = minetest.env:add_entity({x=playerpos.x+1+dir.x,y=playerpos.y+1+dir.y,z=playerpos.z+1+dir.z}, "lottmobs:pumba")
			end
		end
	end
})

minetest.register_craft({
	output = "hyruletools:ocarina3",
	recipe = {
		{"", "", ""},
		{"", "dye:yellow", ""},
		{"", "hyruletools:ocarina",  ""}
	}
})

minetest.register_craftitem("hyruletools:ocarina4", {
	description = "Sheep Ocarina",
	inventory_image = "hyruletools_ocarina_green.png",
	on_use = function(pos, placer, itemstack)
		
		local player = placer:get_player_name()
		
		if mana.subtract(player, 20) then
			minetest.sound_play("ocarina4", {object = placer, gain = 0.5, max_hear_distance = 15})
			local dir = placer:get_look_dir();
				local playerpos = placer:getpos();
				minetest.add_particlespawner(
				5, --amount
				0.1, --time
				{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
				{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
				{x=-0, y=-0, z=-0}, --minvel
				{x=0, y=0, z=0}, --maxvel
				{x=-0.5,y=4,z=-0.5}, --minacc
				{x=0.5,y=4,z=0.5}, --maxacc
				0.5, --minexptime
				1, --maxexptime
				1, --minsize
				2, --maxsize
				false, --collisiondetection
				"hyruletools_note.png" --texture
			)
			local playerpos = placer:getpos();
			
			if math.random(10) == 1 then
				local dir = placer:get_look_dir();
				local obj = minetest.env:add_entity({x=playerpos.x+1+dir.x,y=playerpos.y+2+dir.y,z=playerpos.z+1+dir.z}, "lottmobs:sheep")
			end
		end
	end
})

minetest.register_craft({
	output = "hyruletools:ocarina4",
	recipe = {
		{"", "", ""},
		{"", "dye:green", ""},
		{"", "hyruletools:ocarina",  ""}
	}
})




minetest.register_craftitem("hyruletools:ocarina5", {
	description = minetest.colorize("black", "Black Ocarina") ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "hyruletools_ocarina_black.png",
	groups = {forbidden = 1},
	
	on_use = function(pos, placer, itemstack)
		
		local player = placer:get_player_name()
		
		if mana.subtract(player, 20) then
			local sound_pos = placer:get_pos()
			minetest.sound_play("flute", {object = placer, gain = 0.25, max_hear_distance = 15})
			local dir = placer:get_look_dir();
				local playerpos = placer:getpos();
				minetest.add_particlespawner(
				5, --amount
				0.1, --time
				{x=playerpos.x-1, y=playerpos.y+1, z=playerpos.z-1}, --minpos
				{x=playerpos.x+1, y=playerpos.y+1, z=playerpos.z+1}, --maxpos
				{x=-0, y=-0, z=-0}, --minvel
				{x=0, y=0, z=0}, --maxvel
				{x=-0.5,y=4,z=-0.5}, --minacc
				{x=0.5,y=4,z=0.5}, --maxacc
				0.5, --minexptime
				1, --maxexptime
				1, --minsize
				2, --maxsize
				false, --collisiondetection
				"hyruletools_note.png" --texture
			)
			local playerpos = placer:getpos();
			
			if math.random(10) == 1 then
				
				local mob = math.random(21)
				local ent = ""
				
				if mob == 1 then
					ent = "lottmobs:rat"
				elseif mob == 2 then
					ent = "lottmobs:chicken"
				elseif mob == 3 then
					ent = "lottmobs:badger"
				elseif mob == 4 then
					ent = "lottmobs:kitten"
				elseif mob == 5 then
					ent = "lottmobs:treeman"
				elseif mob == 6 then
					ent = "lottmobs:troll"
				elseif mob == 7 then
					ent = "lottmobs:uruk_hai"
				elseif mob == 8 then
					ent = "lottmobs:ithilien_ranger"
				elseif mob == 9 then
					ent = "dmobs:fox"
				elseif mob == 10 then
					ent = "dmobs:skeleton"
				elseif mob == 11 then
					ent = "dmobs:elephant"
				elseif mob == 12 then
					ent = "dmobs:panda"
				elseif mob == 13 then
					ent = "dmobs:hedgehog"
				elseif mob == 14 then
					ent = "dmobs:owl"
				elseif mob == 15 then
					ent = "dmobs:tortoise"
				elseif mob == 16 then
					ent = "dmobs:wyvern"
				elseif mob == 17 then
					ent = "lottmobs:battle_troll"
				elseif mob == 18 then
					ent = "dmobs:gnorm"
				elseif mob == 19 then
					ent = "dmobs:pig_evil"
				elseif mob == 20 then
					ent = "dmobs:wasp"
				elseif mob == 21 then
					ent = "dmobs:golem"
				end
				
				local dir = placer:get_look_dir();
				local obj = minetest.env:add_entity({x=playerpos.x+1+dir.x,y=playerpos.y+1+dir.y,z=playerpos.z+1+dir.z}, ent)
			end
		end
	end
})

minetest.register_craft({
	output = "hyruletools:ocarina5",
	recipe = {
		{"hyruletools:ocarina4", "hyruletools:ocarina3", "hyruletools:ocarina2"},
		{"", "lottblocks:master_whistle", ""},
		{"lottmapgen:mordor_stone 50", "lottores:marble 50",  "lottblocks:orc_brick 50"}
	}
})






















minetest.register_node("hyruletools:fire", {
	description = "Magical Fire",
	drawtype = "plantlike",
	sunlight_propagates = true,
	paramtype = "light",
	light_source = 14,
	walkable = false,
	damage_per_second = 2,
	tiles = {{
		name = "hyruletools_fire.png",
		animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 1.00},
	}}
,
	inventory_image = "hyruletools_fire_inv.png",
	wield_image = "hyruletools_fire_inv.png",
	groups = {crumbly=1, dig_immediate = 3},
	selection_box = {
			type = "fixed",
			fixed = {-0.3, -0.5, -0.3, 0.3, 0, 0.3}
		}
})


minetest.register_node("hyruletools:light", {
	drawtype = "airlike",
	groups = {not_in_creative_inventory=1},
	walkable = false,
	pointable = false,
	light_source = 10,
})




minetest.register_entity("hyruletools:fireball", {
	textures = {"hyruletools_flame.png"},
	velocity = 15,
	damage = 2,
	collisionbox = {0, 0, 0, 0, 0, 0},
	on_step = function(self, obj, pos)		
		local remove = minetest.after(2, function() 
		self.object:remove()
		end)
		local pos = self.object:getpos()
		local objs = minetest.get_objects_inside_radius({x=pos.x,y=pos.y,z=pos.z}, 2)	
			for k, obj in pairs(objs) do
				if obj:get_luaentity() ~= nil then
					if obj:get_luaentity().name ~= "hyruletools:fireball" and obj:get_luaentity().name ~= "__builtin:item" then
						obj:punch(self.object, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=2},
						}, nil)
					self.object:remove()
					end
				end
			end
			for dx=0,0.5 do
						for dy=0,0.5 do
							for dz=0,0.5 do
								local p = {x=pos.x+dx, y=pos.y, z=pos.z+dz}
								local t = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
								local n = minetest.env:get_node(p).name
								if n ~= "hyruletools:fireball" and n ~="default:dirt_with_grass" and n ~="default:dirt_with_dry_grass" and n ~="default:stone"  then	
									if minetest.registered_nodes[n].groups.flammable then
										minetest.env:set_node(t, {name="fire:basic_flame"})
									self.object:remove()
									return
									end
								end
							end
						end
					end
	end,
})

