
screwdriver = screwdriver or {}

church_altar = {}

--------------------
-- Formspec
--------------------
local altar_formspec =
	"size[8,5.25]"..
	default.gui_bg..
	default.gui_bg_img..
	default.gui_slots..
	"list[current_name;main;0,0;8,1;]"..
	"list[current_player;main;0,1.5;8,4;]"..
	"listring[current_name;main]" ..
	"listring[current_player;main]"
	--default.get_hotbar_bg(0,4.85)

--------------------
-- Register Nodes
--------------------
minetest.register_node("church_altar:altar_end_stone", {
	description = "Stone Altar End",
	tiles = {"church_altar_stone_end_top.png",
	"church_altar_stone_end_top.png^[transformFXR180",
	"church_altar_stone_sides.png",
	"church_altar_stone_sides.png",
	"church_altar_stone_end.png^[transformFX",
	"church_altar_stone_end.png"},
	drawtype = 'nodebox',
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3},
	on_rotate = screwdriver.rotate_simple,
	sounds = default.node_sound_stone_defaults(),
	node_box = {
		type = 'fixed',
		fixed = {
			{-0.4375, 0.3125, -0.5, 0.5, 0.5, 0.5},
			{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
			{-0.3125, -0.125, -0.375, 0.5, 0.25, 0.375},
			{-0.375, 0.25, -0.4375, 0.5, 0.3125, 0.4375},
			{-0.4375, -0.25, -0.4375, 0.5, -0.125, 0.4375},
			{-0.0625, -0.3125, -0.5, 0.125, 0.3125, 0.5},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},
})

minetest.register_node("church_altar:altar_end_marble", {
	description = "Marble Altar End",
	tiles = {"church_altar_marble_end_top.png",
	"church_altar_marble_end_top.png^[transformFXR180",
	"church_altar_marble_sides.png",
	"church_altar_marble_sides.png",
	"church_altar_marble_end.png^[transformFX",
	"church_altar_marble_end.png"},
	drawtype = 'nodebox',
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3},
	on_rotate = screwdriver.rotate_simple,
	sounds = default.node_sound_stone_defaults(),
	node_box = {
		type = 'fixed',
		fixed = {
			{-0.4375, 0.3125, -0.5, 0.5, 0.5, 0.5},
			{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
			{-0.3125, -0.125, -0.375, 0.5, 0.25, 0.375},
			{-0.375, 0.25, -0.4375, 0.5, 0.3125, 0.4375},
			{-0.4375, -0.25, -0.4375, 0.5, -0.125, 0.4375},
			{-0.0625, -0.3125, -0.5, 0.125, 0.3125, 0.5},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},
})

minetest.register_node("church_altar:altar_middle_stone", {
	description = "Stone Donation Altar",
	tiles = {"church_altar_stone_center_top.png",
	"church_altar_stone_center_top.png^[transformFX",
	"church_altar_stone_sides.png",
	"church_altar_stone_sides.png",
	"church_altar_stone_center.png^[transformFX",
	"church_altar_stone_center.png"},
	drawtype = 'nodebox',
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3},
	on_rotate = screwdriver.rotate_simple,
	sounds = default.node_sound_stone_defaults(),
	node_box = {
		type = 'fixed',
		fixed = {
			{-0.5, 0.3125, -0.5, 0.5, 0.5, 0.5},
			{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
			{-0.5, -0.125, -0.375, 0.5, 0.25, 0.375},
			{-0.5, 0.25, -0.4375, 0.5, 0.3125, 0.4375},
			{-0.5, -0.25, -0.4375, 0.5, -0.125, 0.4375},
			{-0.25, -0.25, -0.5, 0.25, 0.3125, 0.5},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", altar_formspec)
		meta:set_string("infotext", "Altar")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*1)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if not minetest.is_protected(pos, player:get_player_name()) then
			return 1000
		else
			return 0
		end

	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
		" moves stuff in altar at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
		" moves stuff to altar at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
		" takes stuff from altar at "..minetest.pos_to_string(pos))
	end,
	on_blast = function() end,
})

minetest.register_node("church_altar:altar_middle_marble", {
	description = "Marble Donation Altar",
	tiles = {"church_altar_marble_center_top.png",
	"church_altar_marble_center_top.png^[transformFX",
	"church_altar_marble_sides.png",
	"church_altar_marble_sides.png",
	"church_altar_marble_center.png^[transformFX",
	"church_altar_marble_center.png"},
	drawtype = 'nodebox',
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky = 3},
	on_rotate = screwdriver.rotate_simple,
	sounds = default.node_sound_stone_defaults(),
	node_box = {
		type = 'fixed',
		fixed = {
			{-0.5, 0.3125, -0.5, 0.5, 0.5, 0.5},
			{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
			{-0.5, -0.125, -0.375, 0.5, 0.25, 0.375},
			{-0.5, 0.25, -0.4375, 0.5, 0.3125, 0.4375},
			{-0.5, -0.25, -0.4375, 0.5, -0.125, 0.4375},
			{-0.25, -0.25, -0.5, 0.25, 0.3125, 0.5},
		},
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
		},
	},
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", altar_formspec)
		meta:set_string("infotext", "Altar")
		local inv = meta:get_inventory()
		inv:set_size("main", 8*1)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index, to_list, to_index, count, player)
		minetest.log("action", player:get_player_name()..
		" moves stuff in marble altar at "..minetest.pos_to_string(pos))
	end,
	allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		if not minetest.is_protected(pos, player:get_player_name()) then
			return 1000
		else
			return 0
		end
	end,
	on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
		" moves stuff to marble altar at "..minetest.pos_to_string(pos))
	end,
	on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name()..
		" takes stuff from marble altar at "..minetest.pos_to_string(pos))
	end,
	on_blast = function() end,
})


-------------------
-- Register ABM
-------------------
-- suck in items [code by jordan4ibanez / from the Hopper mod]
minetest.register_abm({
	nodenames = {"church_altar:altar_middle_stone", "church_altar:altar_middle_marble"},
	interval = 1.0,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local posob

		for _,object in ipairs(minetest.get_objects_inside_radius(pos, 2)) do
			if not object:is_player() and object:get_luaentity() and object:get_luaentity().name == "__builtin:item" then
				if inv and inv:room_for_item("main", ItemStack(object:get_luaentity().itemstring)) then
					posob = object:getpos()
					if math.abs(posob.x-pos.x) <= 1.5 and (posob.y-pos.y <= 0.85 and posob.y-pos.y >= 0.3) then
						inv:add_item("main", ItemStack(object:get_luaentity().itemstring))
						object:get_luaentity().itemstring = ""
						object:remove()
					end
				end
			end
		end
	end,
})

-----------------------------
-- Register Craft Recipes
-----------------------------
minetest.register_craft({
	output = 'church_altar:altar_end_stone 2',
	recipe = {
		{'group:stone', 'group:stone', ''},
		{'group:stone', '', ''},
		{'group:stone', 'group:stone', ''}
	}
})

minetest.register_craft({
	output = 'church_altar:altar_end_stone 2',
	recipe = {
		{'', 'group:stone', 'group:stone'},
		{'', '', 'group:stone'},
		{'', 'group:stone', 'group:stone'}
	}
})

minetest.register_craft({
	output = 'church_altar:altar_middle_stone',
	recipe = {
		{'', 'stairs:slab_stone', ''},
		{'', 'group:stone', ''},
		{'', 'stairs:slab_stone', ''}
	}
})

minetest.register_craft({
	output = 'church_altar:altar_end_marble 2',
	recipe = {
		{'lottores:marble', 'lottores:marble', ''},
		{'lottores:marble', '', ''},
		{'lottores:marble', 'lottores:marble', ''}
	}
})

minetest.register_craft({
	output = 'church_altar:altar_end_marble 2',
	recipe = {
		{'', 'lottores:marble', 'lottores:marble'},
		{'', '', 'lottores:marble'},
		{'', 'lottores:marble', 'lottores:marble'}
	}
})

minetest.register_craft({
	output = 'church_altar:altar_middle_marble',
	recipe = {
		{'lottores:marble'},
		{'lottores:marble'},
		{'lottores:marble'}
	}
})
