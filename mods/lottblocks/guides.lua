

-- I modified books to have less lines per page, and re-formatted all existing books, was a mess
-- I also modified and simplified existing texts a lot

-- This way works way better on smaller screens, text was getting cut off at 800x600 or so
-- Downside is you have to flip pages more.  Probably a way better way to do this?

local lpp = 4
local function guide_on_use(itemstack, user)
	local player_name = user:get_player_name()
	local data = minetest.registered_items[itemstack:get_name()].text
	local page_info = minetest.deserialize(itemstack:get_metadata())
	local title, text, owner = "", "", player_name
	local page, page_max, lines, string = 1, 1, {}, ""

	title = data.title
	text = data.text
	owner = data.owner
	page_max = data.page_max
	background = data.background or "gui_elfbg.png"

	for str in (text .. "\n"):gmatch("([^\n]*)[\n]") do
		lines[#lines+1] = str
	end

	if page_info then
		if page_info.page then
			page = page_info.page
		end
	end

	for i = ((lpp * page) - lpp) + 1, lpp * page do
		if not lines[i] then break end
		string = string .. lines[i] .. "\n"
	end

	local formspec = "size[8,8]" ..
		"background[8,8;1,1;" .. background .. ";true]"..
		"label[0.5,0.5;by " .. owner .. "]" ..
		"label[0.4,0;" .. minetest.colorize("yellow", minetest.formspec_escape(title)) .. "]" ..
		"textarea[0.5,1.5;7.5,6;;" ..
		minetest.formspec_escape(string ~= "" and string or text) .. ";]" ..
		"button[2.4,7.6;0.8,0.8;book_prev;<]" ..
		"label[3.1,7.7;Page " .. page .. " of " .. page_max .. "]" ..
		"button[5.2,7.6;0.8,0.8;book_next;>]"

	minetest.show_formspec(player_name, "lottother:guide", formspec)
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname ~= "lottother:guide" then return end
	local inv = player:get_inventory()
	local stack = player:get_wielded_item()

	if fields.book_next or fields.book_prev then
		local data = minetest.registered_items[stack:get_name()].text
		local page_info = minetest.deserialize(stack:get_metadata())
		if not page_info then
			page_info = {page = 1}
		end

		if fields.book_next then
			page_info.page = page_info.page + 1
			if page_info.page > data.page_max then
				page_info.page = 1
			end
		else
			page_info.page = page_info.page - 1
			if page_info.page == 0 then
				page_info.page = data.page_max
			end
		end

		local data_str = minetest.serialize(page_info)
		stack:set_metadata(data_str)
		guide_on_use(stack, player)
	end

	player:set_wielded_item(stack)
end)





local palantir_guide = dofile(minetest.get_modpath("lottblocks")
	.. "/guide_text/palantir_guide.lua")

minetest.register_craftitem("lottblocks:palantir_guide", {
	description = "Palantir Guidebook",
	inventory_image = "default_book.png^[colorize:darkblue:100",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(palantir_guide),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})

-- Modified recipe for guide for more mese usage!  Using a book makes more sense anyway?

minetest.register_craft({
	--type = "shapeless",
	output = "lottblocks:palantir_guide",
    recipe = {
		{'', "lottores:galvorn_block", ''},
		{"lottores:galvorn_block", 'lottinventory:forbidden_book', "lottores:galvorn_block"},
		{'', "lottores:galvorn_block", ''}
	}
})



-- Also changed this recipe.  Elven lore and all, and was too expensive before.

local ring_guide = dofile(minetest.get_modpath("lottblocks")
	.. "/guide_text/ring_guide.lua")

minetest.register_craftitem("lottblocks:ring_guide", {
	description = "Ring Guidebook",
	inventory_image = "default_book.png^[colorize:violet:100",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(ring_guide),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})

minetest.register_craft({
	--type = "shapeless",
	output = "lottblocks:ring_guide",
    recipe = {
		{'', 'lottweapons:elven_sword', ''},
		{'lottweapons:elven_sword', 'lottinventory:forbidden_book', 'lottweapons:elven_sword'},
		{'', 'lottweapons:elven_sword', ''}
	}
})




-- Added guides for weapons and rods and silmarils


local weapon_guide = dofile(minetest.get_modpath("lottblocks")
	.. "/guide_text/weapon_guide.lua")

minetest.register_craftitem("lottblocks:weapon_guide", {
	description = "Legendary Weapons & Artifacts",
	inventory_image = "default_book.png^[colorize:red:100",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(weapon_guide),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})

minetest.register_craft({
	--type = "shapeless",
	output = "lottblocks:weapon_guide",
    recipe = {
		{'lottweapons:elven_sword', '', 'lottweapons:elven_sword'},
		{'', 'lottinventory:forbidden_book', ''},
		{'', '', ''}
	}
})



local silmaril_guide = dofile(minetest.get_modpath("lottblocks")
	.. "/guide_text/silmaril_guide.lua")

minetest.register_craftitem("lottblocks:silmaril_guide", {
	description = "Silmarillion",
	inventory_image = "default_book.png^[colorize:Gold:100",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(silmaril_guide),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})

local clothing_guide = dofile(minetest.get_modpath("lottblocks")
	.. "/guide_text/clothing_guide.lua")

minetest.register_craftitem("lottblocks:clothing_guide", {
	description = "Magical Clothing",
	inventory_image = "default_book.png^[colorize:magenta:100",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(clothing_guide),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})

local dragon_guide = dofile(minetest.get_modpath("lottblocks")
	.. "/guide_text/dragon_guide.lua")

minetest.register_craftitem("lottblocks:dragon_guide", {
	description = "On Dragons",
	inventory_image = "default_book.png^[colorize:darkgray:100",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(dragon_guide),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})

minetest.register_craft({
	--type = "shapeless",
	output = "lottblocks:dragon_guide",
    recipe = {
		{'bones:bone', 'bones:bone', 'bones:bone'},
		{'lottinventory:potions_book', 'lottinventory:forbidden_book', 'lottinventory:potions_book'},
		{'default:gold_ingot', 'default:gold_ingot', 'default:gold_ingot'}
	}
})



minetest.register_craft({
	--type = "shapeless",
	output = "lottblocks:silmaril_guide",
    recipe = {
		{'lottplants:culumaldasapling', '', 'lottplants:culumaldasapling'},
		{'', 'lottinventory:forbidden_book', ''},
		{'lottplants:mallornsapling', '', 'lottplants:mallornsapling'}
	}
})

minetest.register_craft({
	--type = "shapeless",
	output = "lottblocks:clothing_guide",
    recipe = {
		{'lottclothes:felt_grey', 'lottclothes:felt_grey', 'lottclothes:felt_grey'},
		{'lottclothes:felt_grey', 'lottinventory:forbidden_book', 'lottclothes:felt_grey'},
		{'lottclothes:felt_grey', 'lottclothes:felt_grey', 'lottclothes:felt_grey'}
	}
})


-- Rod Guide
-- Why not bronze?  Use some of that extra ore, or get the stuff from trolls!

local minion_guide = dofile(minetest.get_modpath("lottblocks")
	.. "/guide_text/rod_guide.lua")

minetest.register_craftitem("lottblocks:rod_guide", {
	description = "Mystical Rods",
	inventory_image = "default_book.png^[colorize:green:120",
	groups = {book = 1, forbidden = 1},
	stack_max = 1,
	text = minetest.deserialize(minion_guide),
	on_use = function(itemstack, user)
		guide_on_use(itemstack, user)
	end,
})

minetest.register_craft({
	--type = "shapeless",
	output = "lottblocks:rod_guide",
    recipe = {
		{'', 'lottweapons:bronze_battleaxe', ''},
		{'lottweapons:bronze_warhammer', 'lottinventory:forbidden_book', 'default:sword_bronze'},
		{'', 'lottweapons:bronze_spear', ''}
	}
})




