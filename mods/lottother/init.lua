dofile(minetest.get_modpath("lottother").."/rings/rings.lua")
dofile(minetest.get_modpath("lottother").."/rings/gems.lua")
dofile(minetest.get_modpath("lottother").."/rings/ringsilver.lua")
dofile(minetest.get_modpath("lottother").."/rings/ringcraft.lua")
dofile(minetest.get_modpath("lottother").."/mob_spawners.lua")
dofile(minetest.get_modpath("lottother").."/flames.lua")
dofile(minetest.get_modpath("lottother").."/credits.lua")



minetest.register_node("lottother:dirt", {
	description = "Dirt Substitute",
	tiles = {"default_dirt.png"},
	is_ground_content = true,
     drop = 'default:dirt',
	groups = {crumbly=3,soil=1,not_in_creative_inventory=1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("lottother:snow", {
	description = "Snow Substitute",
	tiles = {"default_snow.png"},
	is_ground_content = true,
     drop = 'default:snowblock',
	freezemelt = "default:water_source",
	groups = {crumbly=3, melts=1, not_in_creative_inventory=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_snow_footstep", gain=0.25},
		dug = {name="default_snow_footstep", gain=0.75},
	}),
})

minetest.register_node("lottother:mordor_stone", {
	description = "Mordor Stone Substitute",
	tiles = {"lottmapgen_mordor_stone.png"},
	is_ground_content = true,
     drop = 'lottmapgen:mordor_stone',
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottother:stone", {
	description = "Stone Substitute",
	tiles = {"default_stone.png"},
	is_ground_content = true,
	drop = 'default:cobble',
	groups = {cracky=3, stone=1, not_in_creative_inventory=1},
	sounds = default.node_sound_stone_defaults(),
	on_construct = function(pos)
		local found_air = 0
		local y = 0
		for h = 1, 50 do
			if minetest.get_node({x = pos.x, y = pos.y + h, z = pos.z}).name == "air" then
				found_air = found_air + 1
			elseif minetest.get_node({x = pos.x, y = pos.y + h + 4, z = pos.z}).name == "default:water_source" then
				return
			end
			for i = -1, 1 do
			for j = -3, -1 do
				local p = {x = pos.x + i, y = pos.y + h, z = pos.z + j}
				if j == -3 and i == 0  then
					minetest.set_node(p, {name = "default:ladder", param2 = 2})
				elseif h % 3 == 0 and j == -2 and i == -1 then
					minetest.set_node(p, {name = "default:torch", param2 = 3})
				elseif h % 3 == 0 and j == -2 and i == 1 then
					minetest.set_node(p, {name = "default:torch", param2 = 2})
				else
					minetest.remove_node(p)
				end
			end
			end
			if found_air > 3 then
				y = h
				break
			end
			if h == 50 then
					y = 50
			end
		end
		for j = -3, 0 do
		for k = -4, 0 do
		for i = -2, 2 do
			if k == 0 or k == -4 or i == -2 or i == 2 or j == 0 then
				minetest.set_node({x=pos.x+i, y = pos.y+y+j, z=pos.z+k}, {name="lottblocks:dwarfstone_black"})
			end
			if j == -3 then
				minetest.set_node({x = pos.x+i, y = pos.y+y+j-1, z = pos.z+k}, {name = "lottblocks:dwarfstone_black"})
			end
			if j == -3 and k == -3 and i == 0  then
				minetest.set_node({x = pos.x+i, y = pos.y+y+j-1, z = pos.z+k}, {name = "default:ladder", param2 = 2})
			end
			if k == 0 and i == 0 then
				if j == -3 then
					minetest.set_node({x = pos.x+i, y = pos.y+y+j, z = pos.z+k}, {name = "lottblocks:door_alder_b_1", param2 = 2})
				elseif j == -2 then
					minetest.set_node({x = pos.x+i, y = pos.y+y+j, z = pos.z+k}, {name = "lottblocks:door_alder_t_1", param2 = 2})
				end
			end
		end
		end
		end
	minetest.set_node(pos, {name = "default:stone"})
	end,
})

minetest.register_node("lottother:air", {
	description = "Air Substitute",
	drawtype = "glasslike",
	tiles = {"lottother_air.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
     walkable = false,
     buildable_to = true,
     pointable = false,
	groups = {not_in_creative_inventory=1,dig_immediate=3},
	sounds = default.node_sound_glass_defaults(),
	drop = "",
})

minetest.register_abm({
	nodenames = {"lottother:dirt"},
	neighbors = {"air"},
	interval = 5,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local down = {x=x,y=y-1,z=z}
          local down2 = {x=x,y=y-2,z=z}
          local down3 = {x=x,y=y-3,z=z}
          local down4 = {x=x,y=y-4,z=z}
          local down5 = {x=x,y=y-5,z=z}
          local down6 = {x=x,y=y-6,z=z}
          local down7 = {x=x,y=y-7,z=z}
		if minetest.get_node(down).name == "air" then
			minetest.set_node(down, {name="default:dirt"})
               minetest.set_node(down2, {name="default:dirt"})
               minetest.set_node(down3, {name="default:dirt"})
               minetest.set_node(down4, {name="default:dirt"})
               minetest.set_node(down5, {name="default:dirt"})
               minetest.set_node(down6, {name="default:dirt"})
               minetest.set_node(down7, {name="lottother:dirt"})
		end
     end,
})

minetest.register_abm({
	nodenames = {"lottother:snow"},
	neighbors = {"air"},
	interval = 5,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local down = {x=x,y=y-1,z=z}
          local down2 = {x=x,y=y-2,z=z}
          local down3 = {x=x,y=y-3,z=z}
          local down4 = {x=x,y=y-4,z=z}
          local down5 = {x=x,y=y-5,z=z}
          local down6 = {x=x,y=y-6,z=z}
          local down7 = {x=x,y=y-7,z=z}
		if minetest.get_node(down).name == "air" then
			minetest.set_node(down, {name="default:snowblock"})
               minetest.set_node(down2, {name="default:snowblock"})
               minetest.set_node(down3, {name="default:snowblock"})
               minetest.set_node(down4, {name="default:snowblock"})
               minetest.set_node(down5, {name="default:snowblock"})
               minetest.set_node(down6, {name="default:snowblock"})
               minetest.set_node(down7, {name="lottother:snow"})
		end
     end,
})

minetest.register_abm({
	nodenames = {"lottother:mordor_stone"},
	neighbors = {"air"},
	interval = 5,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local down = {x=x,y=y-1,z=z}
          local down2 = {x=x,y=y-2,z=z}
          local down3 = {x=x,y=y-3,z=z}
          local down4 = {x=x,y=y-4,z=z}
          local down5 = {x=x,y=y-5,z=z}
          local down6 = {x=x,y=y-6,z=z}
          local down7 = {x=x,y=y-7,z=z}
		if minetest.get_node(down).name == "air" then
			minetest.set_node(down, {name="lottmapgen:mordor_stone"})
               minetest.set_node(down2, {name="lottmapgen:mordor_stone"})
               minetest.set_node(down3, {name="lottmapgen:mordor_stone"})
               minetest.set_node(down4, {name="lottmapgen:mordor_stone"})
               minetest.set_node(down5, {name="lottmapgen:mordor_stone"})
               minetest.set_node(down6, {name="lottmapgen:mordor_stone"})
               minetest.set_node(down7, {name="lottother:mordor_stone"})
		end
     end,
})

minetest.register_abm({
	nodenames = {"lottother:dirt"},
	neighbors = {"default:dirt"},
	interval = 150,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local here = {x=x,y=y,z=z}
		minetest.set_node(here, {name="default:dirt"})
     end,
})

minetest.register_abm({
	nodenames = {"lottother:snow"},
	neighbors = {"default:snowblock"},
	interval = 150,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local here = {x=x,y=y,z=z}
		minetest.set_node(here, {name="default:snowblock"})
     end,
})

minetest.register_abm({
	nodenames = {"lottother:mordor_stone"},
	neighbors = {"lottmapgen:mordor_stone"},
	interval = 150,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local x = pos.x
		local y = pos.y
		local z = pos.z
		local here = {x=x,y=y,z=z}
		minetest.set_node(here, {name="lottmapgen:mordor_stone"})
     end,
})

minetest.register_abm({
	nodenames = {"lottother:air"},
	interval = 7,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.remove_node(pos)
	end,
})
