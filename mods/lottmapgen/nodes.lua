minetest.register_node("lottmapgen:fog", {
	description = "Fog",
	drawtype = "glasslike",
	tiles = {"lottmapgen_fog.png"},
	paramtype = "light",
	is_ground_content = false,
	sunlight_propagates = true,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	post_effect_color = {a=128, r=241, g=248, b=255},
	groups = {not_in_creative_inventory=1},
})

minetest.register_node("lottmapgen:angsnowblock", {
	description = "Snow Block",
	tiles = {"default_snow.png"},
	is_ground_content = true,
     drop = 'default:snowblock',
	freezemelt = "default:water_source",
	groups = {crumbly=3, melts=1},
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_snow_footstep", gain=0.25},
		dug = {name="default_snow_footstep", gain=0.75},
	}),
})


minetest.register_node("lottmapgen:dirt_to_stone_1", {
	description = "",
	paramtype2 = "facedir",
	tiles = {
		{name="default_dirt_8.png", align_style="world", scale=8},
		{name="default_granite_8.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_1.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_1.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_1.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_1.png", align_style="world", scale=8},
	},
	is_ground_content = true,
	drop = 'default:dirt',
	is_ground_content = true,
	groups = {crumbly=3, dirt=1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_node("lottmapgen:dirt_to_stone_1_r", {
	description = "",
	paramtype2 = "facedir",
	tiles = {
		{name="default_dirt_8.png", align_style="world", scale=8},
		{name="default_granite_8.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_1.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_1.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_1.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_1.png", align_style="world", scale=8},
	},
	is_ground_content = true,
	drop = 'default:dirt',
	is_ground_content = true,
	groups = {crumbly=3, dirt=1},
	sounds = default.node_sound_dirt_defaults(),
})
minetest.register_node("lottmapgen:dirt_to_stone_1_l", {
	description = "",
	paramtype2 = "facedir",
	tiles = {
		{name="default_dirt_8.png", align_style="world", scale=8},
		{name="default_granite_8.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_1.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_1.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_1.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_1.png", align_style="world", scale=8},
	},
	is_ground_content = true,
	drop = 'default:dirt',
	is_ground_content = true,
	groups = {crumbly=3, dirt=1},
	sounds = default.node_sound_dirt_defaults(),
})

minetest.register_node("lottmapgen:dirt_to_stone_2", {
	description = "",
	paramtype2 = "facedir",
	tiles = {
		{name="default_dirt_8.png", align_style="world", scale=8},
		{name="default_granite_8.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_2.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_2.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_2.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_2.png", align_style="world", scale=8},
	},
	is_ground_content = true,
	drop = 'default:stone',
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("lottmapgen:dirt_to_stone_2_r", {
	description = "",
	paramtype2 = "facedir",
	tiles = {
		{name="default_dirt_8.png", align_style="world", scale=8},
		{name="default_granite_8.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_2_r.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_2_l.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_2_l.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_2_r.png", align_style="world", scale=8},
	},
	is_ground_content = true,
	drop = 'default:stone',
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("lottmapgen:dirt_to_stone_2_l", {
	description = "",
	paramtype2 = "facedir",
	tiles = {
		{name="default_dirt_8.png", align_style="world", scale=8},
		{name="default_granite_8.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_2_l.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_2_r.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_2_r.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_2_l.png", align_style="world", scale=8},
	},
	is_ground_content = true,
	drop = 'default:stone',
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("lottmapgen:dirt_to_stone_2_lr", {
	description = "",
	paramtype2 = "facedir",
	tiles = {
		{name="default_dirt_8.png", align_style="world", scale=8},
		{name="default_granite_8.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_2_lr.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_2_lr.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_2_lr.png", align_style="world", scale=8},
		{name="default_granite_8.png^lottmapgen_dirtlayer_2_lr.png", align_style="world", scale=8},
	},
	is_ground_content = true,
	drop = 'default:stone',
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("lottmapgen:dirt_to_desertstone", {
	description = "",
	tiles = {{name="default_dirt_to_desertstone.png",align_style="world",scale=8}},
	is_ground_content = true,
	drop = 'default:stone',
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottmapgen:frozen_stone", {
	description = "Frozen Stone",
	tiles = {"default_stone.png^lottmapgen_frozen.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	drop = 'default:cobble','default:snow',
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node("lottmapgen:mordor_stone", {
	description = "Mordor Stone",
	tiles = {"lottmapgen_mordor_stone.png"},
	is_ground_content = true,
	groups = {cracky=3, stone=1},
	sounds = default.node_sound_stone_defaults(),
})

minetest.register_node(":default:ice", {
	description = "Ice",
	drawtype = "glasslike",
	tiles = {"lottmapgen_ice.png"},
	is_ground_content = true,
    use_texture_alpha = "blend",
	paramtype = "light",
	freezemelt = "default:water_source",
	groups = {cracky=3, melts=1},
	sounds = default.node_sound_glass_defaults(),
})















-- From Dyed Water

minetest.register_node("lottmapgen:blacksource", {
	description = "MordorWater",
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "dyed_water_white_source_animated.png^[multiply:#000000",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "dyed_water_white_source_animated.png^[multiply:#000000",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "lottmapgen:blackflowing",
	liquid_alternative_source = "lottmapgen:blacksource",
	liquid_viscosity = 1,
	post_effect_color = {a=250, r=14, g=14, b=14},-- {a=224, r=31, g=56, b=8},
	groups = {water = 3, liquid = 3, cools_lava = 1},
	--sounds = liquid_sound,
})

minetest.register_node("lottmapgen:blackflowing", {
	description = "AAa",
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"dyed_water_white.png^[colorize:#000000:128"},
	special_tiles = {
		{
			name = "dyed_water_white_flowing_animated.png^[multiply:#000000",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "dyed_water_white_flowing_animated.png^[multiply:#000000",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "lottmapgen:blackflowing",
	liquid_alternative_source = "lottmapgen:blacksource",
	liquid_viscosity = 1,
	post_effect_color = {a=250, r=14, g=14, b=14},-- {a=224, r=31, g=56, b=8},
	groups = {water = 3, liquid = 3, not_in_creative_inventory = 1,cools_lava = 1},
	--sounds = liquid_sound,
})

minetest.register_node("lottmapgen:black_river_source", {
description = "MordorWater",
	drawtype = "liquid",
	waving = 3,
	tiles = {
		{
			name = "dyed_water_white_source_animated.png^[multiply:#000000",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
		{
			name = "dyed_water_white_source_animated.png^[multiply:#000000",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2.0,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "lottmapgen:blackflowing",
	liquid_alternative_source = "lottmapgen:blacksource",
	liquid_viscosity = 1,
	post_effect_color = {a=250, r=14, g=14, b=14},-- {a=224, r=31, g=56, b=8},
	groups = {water = 3, liquid = 3, cools_lava = 1},
	--sounds = liquid_sound,
})

minetest.register_node("lottmapgen:black_river_flowing", {
description = "AAa",
	drawtype = "flowingliquid",
	waving = 3,
	tiles = {"dyed_water_white.png^[colorize:#000000:128"},
	special_tiles = {
		{
			name = "dyed_water_white_flowing_animated.png^[multiply:#000000",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
		{
			name = "dyed_water_white_flowing_animated.png^[multiply:#000000",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.5,
			},
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "lottmapgen:blackflowing",
	liquid_alternative_source = "lottmapgen:blacksource",
	liquid_viscosity = 1,
	post_effect_color = {a=250, r=14, g=14, b=14},-- {a=224, r=31, g=56, b=8},
	groups = {water = 3, liquid = 3, not_in_creative_inventory = 1,cools_lava = 1},
	--sounds = liquid_sound,
})





--[[

minetest.register_node("lottmapgen:blacksource", {
	description = "Black Water Source",
	drawtype = "liquid",
	tiles = {"lottmapgen_black_water.png"},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "lottmapgen:blackflowing",
	liquid_alternative_source = "lottmapgen:blacksource",
	liquid_viscosity = 1,
	damage_per_second = 2,
	post_effect_color = {a=192, r=140, g=140, b=140},
	groups = {water=3, liquid=3, puts_out_fire=1},
})

minetest.register_node("lottmapgen:blackflowing", {
	drawtype = "flowingliquid",
	tiles = {"lottmapgen_black_water.png"},
	special_tiles = {
		{
			image="lottmapgen_black_water_flow.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1}
		},
		{
			image="lottmapgen_black_water_flow.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1}
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "flowing",
	liquid_alternative_flowing = "lottmapgen:blackflowing",
	liquid_alternative_source = "lottmapgen:blacksource",
	liquid_viscosity = 1,
	damage_per_second = 2,
	post_effect_color = {a=192, r=140, g=140, b=140},-- {a=224, r=31, g=56, b=8},
	groups = {water=3, liquid=3, puts_out_fire=1, not_in_creative_inventory=1},
})

minetest.register_node("lottmapgen:black_river_source", {
	description = "Black River Source",
	drawtype = "liquid",
	tiles = {"lottmapgen_black_water.png"},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "lottmapgen:black_river_flowing",
	liquid_alternative_source = "lottmapgen:black_river_source",
	liquid_viscosity = 1,
	liquid_renewable = false,
	liquid_range = 2,
	damage_per_second = 2,
	post_effect_color = {a=192, r=140, g=140, b=140},
	groups = {water=3, liquid=3, puts_out_fire=1},
})

minetest.register_node("lottmapgen:black_river_flowing", {
	drawtype = "flowingliquid",
	tiles = {"lottmapgen_black_water.png"},
	special_tiles = {
		{
			image="lottmapgen_black_water_flow.png",
			backface_culling=false,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1}
		},
		{
			image="lottmapgen_black_water_flow.png",
			backface_culling=true,
			animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1}
		},
	},
	use_texture_alpha = "blend",
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	liquidtype = "flowing",
	liquid_alternative_flowing = "lottmapgen:black_river_flowing",
	liquid_alternative_source = "lottmapgen:black_river_source",
	liquid_viscosity = 1,
	liquid_renewable = false,
	liquid_range = 2,
	damage_per_second = 2,
	post_effect_color = {a=192, r=140, g=140, b=140},-- {a=224, r=31, g=56, b=8},
	groups = {water=3, liquid=3, puts_out_fire=1, not_in_creative_inventory=1},
})

]]--

bucket.register_liquid(
	"lottmapgen:blacksource",
	"lottmapgen:blackflowing",
	"lottmapgen:bucket_mordor",
	"lottmapgen_bucket_mordor_water.png",
	"Mordor Water Bucket"
)

-- Grasses

minetest.register_node("lottmapgen:dunland_grass", {
	description = "Dunland Grass",
	tiles = {"default_grass.png^[colorize:#35ba3c:50", "default_dirt.png",
		{name = "default_dirt.png^(default_grass_side.png^[colorize:#35ba3c:50)", tileable_vertical = false}
	},
	is_ground_content = true,
	groups = {crumbly=3, soil=1, lottmapgen_grass=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("lottmapgen:ironhill_grass", {
	description = "Iron Hills Grass",
	tiles = {"default_grass.png^[colorize:#1cbca7:60", "default_dirt.png",
		{name =  "default_dirt.png^(default_grass_side.png^[colorize:#1cbca7:60)", tileable_vertical = false}
	},
	is_ground_content = true,
	groups = {crumbly=3, soil=1, lottmapgen_grass=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("lottmapgen:gondor_grass", {
	description = "Gondor Grass",
	tiles = {"default_grass.png", "default_dirt.png", {name = "default_dirt.png^default_grass_side.png", tileable_vertical = false}},
	is_ground_content = true,
	groups = {crumbly=3, soil=1, lottmapgen_grass=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("lottmapgen:lorien_grass", {
	description = "Lorien Grass",
	tiles = {"default_grass.png^[colorize:#5bf7ea:75", "default_dirt.png",
		{name =  "default_dirt.png^(default_grass_side.png^[colorize:#5bf7ea:75)", tileable_vertical = false}
	},
	is_ground_content = true,
	groups = {crumbly=3, soil=1, lottmapgen_grass=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("lottmapgen:fangorn_grass", {
	description = "? Grass",
	tiles = {"default_grass.png^[colorize:#720e6f:30", "default_dirt.png",
		{name = "default_dirt.png^(default_grass_side.png^[colorize:#720e6f:30)", tileable_vertical = false}
	},
	is_ground_content = true,
	groups = {crumbly=3, soil=1, lottmapgen_grass=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("lottmapgen:mirkwood_grass", {
	description = "Mirkwood Grass",
	tiles = {"default_grass.png^[colorize:#331507:120", "default_dirt.png",
		{name =  "default_dirt.png^(default_grass_side.png^[colorize:#331507:120)", tileable_vertical = false}
	},
	is_ground_content = true,
	groups = {crumbly=3, soil=1, lottmapgen_grass=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("lottmapgen:rohan_grass", {
	description = "? Grass",
	tiles = {"default_grass.png^[colorize:#af5301:95", "default_dirt.png",
		{name =  "default_dirt.png^(default_grass_side.png^[colorize:#af5301:95)", tileable_vertical = false}
	},
	is_ground_content = true,
	groups = {crumbly=3, soil=1, lottmapgen_grass=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("lottmapgen:shire_grass", {
	description = "Shire Grass",
	tiles = {"default_grass.png^[colorize:#86ad06:105", "default_dirt.png",
		{name =  "default_dirt.png^(default_grass_side.png^[colorize:#86ad06:105)", tileable_vertical = false}
	},
	is_ground_content = true,
	groups = {crumbly=3, soil=1, lottmapgen_grass=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("lottmapgen:ithilien_grass", {
	description = "Ithilien Grass",
	tiles = {"default_grass.png^[colorize:#ba6f35:50", "default_dirt.png",
		{name = "default_dirt.png^(default_grass_side.png^[colorize:#ba6f35:50)", tileable_vertical = false}
	},
	is_ground_content = true,
	groups = {crumbly=3, soil=1, lottmapgen_grass=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults({
		footstep = {name="default_grass_footstep", gain=0.25},
	}),
})

minetest.register_node("lottmapgen:default_grass", {
	tiles = {"default_grass.png", "default_dirt.png", {name = "default_dirt.png^default_grass_side.png", tileable_vertical = false}},
	is_ground_content = true,
	groups = {crumbly=3, soil=1, lottmapgen_grass=1, not_in_creative_inventory=1},
	drop = 'default:dirt',
	sounds = default.node_sound_dirt_defaults()
})

minetest.register_abm({
	nodenames = {"default:dirt_with_grass"},
	interval = 2,
	chance = 1,
	action = function(pos, node)
		local count_grasses = {};
		local curr_max  = 0;
		local curr_type = "lottmapgen:default_grass";

		local positions = minetest.find_nodes_in_area( {x=(pos.x-2), y=(pos.y-2), z=(pos.z-2)},
							       {x=(pos.x+2), y=(pos.y+2), z=(pos.z+2)},
							   "group:lottmapgen_grass" );
		for _,p in ipairs(positions) do
			local n = minetest.get_node( p );
			if( n and n.name ) then
				if( not( count_grasses[ n.name ] )) then
					count_grasses[ n.name ] = 1;
				else
					count_grasses[ n.name ] = count_grasses[ n.name ] + 1;
				end
				if( count_grasses[ n.name ] > curr_max ) then
					curr_max  = count_grasses[ n.name ];
					curr_type = n.name;
				end
			end
		end
		minetest.set_node(pos, {name = curr_type })
        end
})

minetest.register_abm({
	nodenames = {"group:lottmapgen_grass"},
	interval = 2,
	chance = 20,
	action = function(pos, node)
		local above = {x=pos.x, y=pos.y+1, z=pos.z}
		local name = minetest.get_node(above).name
		local nodedef = minetest.registered_nodes[name]
		if name ~= "ignore" and nodedef
				and not ((nodedef.sunlight_propagates or nodedef.paramtype == "light")
				and nodedef.liquidtype == "none") then
			minetest.set_node(pos, {name = "default:dirt"})
		end
	end
})
