minetest.register_tool("lottclothes:hood_elven", {
	description = "Elven Hood",
	inventory_image = "lottclothes_inv_hood_elven.png",
	groups = {armor_feet=0, armor_heal=0, clothes=1, clothes_head=1},
	wear = 0
})

minetest.register_tool("lottclothes:shirt_elven", {
	description = "Elven Shirt",
	inventory_image = "lottclothes_inv_shirt_elven.png",
	groups = {armor_feet=0, armor_heal=0, clothes=1, clothes_torso=1},
	wear = 0
})

minetest.register_tool("lottclothes:trousers_elven", {
	description = "Elven Trousers",
	inventory_image = "lottclothes_inv_trousers_elven.png",
	groups = {armor_feet=0, armor_heal=0, clothes=1, clothes_legs=1},
	wear = 0
})

minetest.register_tool("lottclothes:shoes_elven", {
	description = "Elven Shoes",
	inventory_image = "lottclothes_inv_shoes_elven.png",
	groups = {armor_feet=0, armor_heal=0, clothes=1, clothes_feet=1},
	wear = 0
})

minetest.register_tool("lottclothes:cloak_elven", {
	description = "Elven Cloak",
	inventory_image = "lottclothes_inv_cloak_elven.png",
	groups = {armor_feet=0, armor_heal=0, clothes=1, clothes_cloak=1},
	wear = 0
})

minetest.register_craft({
	output = "lottclothes:hood_elven",
	recipe = {
		{"lottclothes:flax_grey", "lottclothes:flax_grey", "lottclothes:flax_grey"},
		{"lottclothes:flax_grey", "" , "lottclothes:flax_grey"},
	}
})

minetest.register_craft({
	output = "lottclothes:shirt_elven",
	recipe = {
		{"lottclothes:flax_grey", "", "lottclothes:flax_grey"},
		{"lottclothes:flax_grey", "lottclothes:flax_grey", "lottclothes:flax_grey"},
		{"lottclothes:flax_grey", "lottclothes:flax_grey", "lottclothes:flax_grey"}
	}
})

minetest.register_craft({
	output = "lottclothes:trousers_elven",
	recipe = {
		{"lottclothes:flax_grey", "lottclothes:flax_grey", "lottclothes:flax_grey"},
		{"lottclothes:flax_grey", "" , "lottclothes:flax_grey"},
		{"lottclothes:flax_grey", "" , "lottclothes:flax_grey"}
	}
})

minetest.register_craft({
	output = "lottclothes:shoes_elven",
	recipe = {
		{"lottclothes:flax_grey", "" , "lottclothes:flax_grey"},
		{"lottclothes:felt_black", "" , "lottclothes:felt_black"}
	}
})

minetest.register_craft({
	output = "lottclothes:cloak_elven",
	recipe = {
		{"lottclothes:flax_grey", "lottclothes:flax_grey"},
		{"lottclothes:flax_grey", "lottclothes:flax_grey"},
		{"lottclothes:flax_grey", "lottclothes:flax_grey"}
	}
})












-- Lothlorien clothing, my idea :)
-- Code for armor values in lottclothes/clothing

minetest.register_tool("lottclothes:hood_elven2", {
	description = minetest.colorize("Navy", "Lothlorien Hood") ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "lottclothes_inv_hood_elven2.png",
	groups = {armor_feet=0, armor_heal=0, clothes=1, clothes_head=1, elf=1},
	wear = 0
})

minetest.register_tool("lottclothes:shirt_elven2", {
	description = minetest.colorize("Navy", "Lothlorien Shirt") ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "lottclothes_inv_shirt_elven2.png",
	groups = {armor_feet=0, armor_heal=0, clothes=1, clothes_torso=1, elf=1},
	wear = 0
})

minetest.register_tool("lottclothes:trousers_elven2", {
	description = minetest.colorize("Navy", "Lothlorien Trousers") ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	description = "Lothlorien Trousers",
	inventory_image = "lottclothes_inv_trousers_elven2.png",
	groups = {armor_feet=0, armor_heal=0, clothes=1, clothes_legs=1, elf=1},
	wear = 0
})

minetest.register_tool("lottclothes:shoes_elven2", {
	description = minetest.colorize("Navy", "Lothlorien Shoes") ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "lottclothes_inv_shoes_elven2.png",
	groups = {armor_feet=0, armor_heal=0, clothes=1, clothes_feet=1, elf=1},
	wear = 0
})

minetest.register_tool("lottclothes:cloak_elven2", {
	description = minetest.colorize("Navy", "Lothlorien Cloak") ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "lottclothes_inv_cloak_elven2.png",
	groups = {armor_feet=0, armor_heal=0, clothes=1, clothes_cloak=1, elf=1},
	wear = 0
})












