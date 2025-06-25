dofile(minetest.get_modpath(minetest.get_current_modname()).."/multiskin.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/armor.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/shield.lua")
dofile(minetest.get_modpath(minetest.get_current_modname()).."/wieldview.lua")





-- Special Armor
-- Using Gondor/Rohan/Dwarf textures because they were already there!



minetest.register_craftitem("lottarmor:placeholder", {
	description = "you shouldn't be seeing this...",
	inventory_image = "grass.png",
	noitem = true,
})

minetest.register_tool("lottarmor:leggings_dwarf", {
	description = minetest.colorize("Gray", "Dwarven Leggings") ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "lottarmor_inv_leggings_dwarf.png",
	groups = {armor_legs=10, armor_heal=0, armor_healing=0, physics_speed=0, immortal=1},
	wear = 0,
})

minetest.register_tool("lottarmor:boots_dwarf", {
	description = minetest.colorize("Gray", "Dwarven Boots") ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "lottarmor_inv_boots_dwarf.png",
	groups = {armor_feet=8, armor_heal=0, armor_healing=0, physics_speed=0, immortal=1},
	wear = 0,
})

minetest.register_tool("lottarmor:helmet_dwarf", {
	description = minetest.colorize("Gray", "Dwarven Helm") ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "lottarmor_inv_helmet_dwarf.png",
	groups = {armor_head=8, armor_heal=0, armor_healing=0, physics_speed=0, immortal=1},
	wear = 0,
})


minetest.register_tool("lottarmor:boots_ranger", {
	description = minetest.colorize("Brown", "Worn Ranger Boots") ..
		minetest.get_background_escape_sequence("lightgoldenrodyellow"),
	inventory_image = "lottarmor_inv_boots_ranger.png",
	groups = {armor_feet=5, armor_heal=0, armor_healing=0, physics_speed=0, immortal=1},
	wear = 0,
})















-- Wood Armor
minetest.register_tool("lottarmor:helmet_wood", {
	description = "Training Helmet",
	inventory_image = "lottarmor_inv_helmet_wood.png",
	groups = {armor_head=2, armor_heal=0, armor_use=2000, armor_healing=0, physics_speed=0.04},
	wear = 0,
})

minetest.register_tool("lottarmor:chestplate_wood", {
	description = "Training Chestplate",
	inventory_image = "lottarmor_inv_chestplate_wood.png",
	groups = {armor_torso=3, armor_heal=0, armor_use=2000, armor_healing=0, physics_speed=0.04},
	wear = 0,
})

minetest.register_tool("lottarmor:leggings_wood", {
	description = "Training Leggings",
	inventory_image = "lottarmor_inv_leggings_wood.png",
	groups = {armor_legs=2, armor_heal=0, armor_use=2000, armor_healing=0, physics_speed=0.04},
	wear = 0,
})

minetest.register_tool("lottarmor:boots_wood", {
	description = "Training Boots",
	inventory_image = "lottarmor_inv_boots_wood.png",
	groups = {armor_feet=2, armor_heal=0, armor_use=2100, armor_healing=0, physics_speed=0.04},
	wear = 0,
})

-- Tin Armor
minetest.register_tool("lottarmor:helmet_tin", {
	description = "Tin Helmet",
	inventory_image = "lottarmor_inv_helmet_tin.png",
	groups = {armor_head=3, armor_heal=0, armor_use=1500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:chestplate_tin", {
	description = "Tin Chestplate",
	inventory_image = "lottarmor_inv_chestplate_tin.png",
	groups = {armor_torso=5, armor_heal=0, armor_use=1500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:leggings_tin", {
	description = "Tin Leggings",
	inventory_image = "lottarmor_inv_leggings_tin.png",
	groups = {armor_legs=3, armor_heal=0, armor_use=1500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:boots_tin", {
	description = "Tin Boots",
	inventory_image = "lottarmor_inv_boots_tin.png",
	groups = {armor_feet=3, armor_heal=0, armor_use=2000, armor_healing=0},
	wear = 0,
})

--Copper Armor
minetest.register_tool("lottarmor:helmet_copper", {
	description = "Copper Helmet",
	inventory_image = "lottarmor_inv_helmet_copper.png",
	groups = {armor_head=3, armor_heal=0, armor_use=1500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:chestplate_copper", {
	description = "Copper Chestplate",
	inventory_image = "lottarmor_inv_chestplate_copper.png",
	groups = {armor_torso=5, armor_heal=0, armor_use=1500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:leggings_copper", {
	description = "Copper Leggings",
	inventory_image = "lottarmor_inv_leggings_copper.png",
	groups = {armor_legs=3, armor_heal=0, armor_use=1500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:boots_copper", {
	description = "Copper Boots",
	inventory_image = "lottarmor_inv_boots_copper.png",
	groups = {armor_feet=3, armor_heal=0, armor_use=2000, armor_healing=0},
	wear = 0,
})

--Steel Armor
minetest.register_tool("lottarmor:helmet_steel", {
	description = "Steel Helmet",
	inventory_image = "lottarmor_inv_helmet_steel.png",
	groups = {armor_head=5, armor_heal=0, armor_use=500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:chestplate_steel", {
	description = "Steel Chestplate",
	inventory_image = "lottarmor_inv_chestplate_steel.png",
	groups = {armor_torso=8, armor_heal=0, armor_use=500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:leggings_steel", {
	description = "Steel Leggings",
	inventory_image = "lottarmor_inv_leggings_steel.png",
	groups = {armor_legs=8, armor_heal=0, armor_use=500, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:boots_steel", {
	description = "Steel Boots",
	inventory_image = "lottarmor_inv_boots_steel.png",
	groups = {armor_feet=5, armor_heal=0, armor_use=500, armor_healing=0},
	wear = 0,
})

--Bronze Armor
minetest.register_tool("lottarmor:helmet_bronze", {
	description = "Bronze Helmet",
	inventory_image = "lottarmor_inv_helmet_bronze.png",
	groups = {armor_head=5, armor_heal=0, armor_use=250, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:chestplate_bronze", {
	description = "Bronze Chestplate",
	inventory_image = "lottarmor_inv_chestplate_bronze.png",
	groups = {armor_torso=8, armor_heal=0, armor_use=250, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:leggings_bronze", {
	description = "Bronze Leggings",
	inventory_image = "lottarmor_inv_leggings_bronze.png",
	groups = {armor_legs=8, armor_heal=0, armor_use=250, armor_healing=0},
	wear = 0,
})

minetest.register_tool("lottarmor:boots_bronze", {
	description = "Bronze Boots",
	inventory_image = "lottarmor_inv_boots_bronze.png",
	groups = {armor_feet=5, armor_heal=0, armor_use=250, armor_healing=0},
	wear = 0,
})


--Silver Armor
minetest.register_tool("lottarmor:helmet_silver", {
	description = "Silver Helmet",
	inventory_image = "lottarmor_inv_helmet_silver.png",
	groups = {armor_head=6, armor_heal=0, armor_use=300, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

minetest.register_tool("lottarmor:chestplate_silver", {
	description = "Silver Chestplate",
	inventory_image = "lottarmor_inv_chestplate_silver.png",
	groups = {armor_torso=9, armor_heal=0, armor_use=300, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

minetest.register_tool("lottarmor:leggings_silver", {
	description = "Silver Leggings",
	inventory_image = "lottarmor_inv_leggings_silver.png",
	groups = {armor_legs=9, armor_heal=0, armor_use=300, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

minetest.register_tool("lottarmor:boots_silver", {
	description = "Silver Boots",
	inventory_image = "lottarmor_inv_boots_silver.png",
	groups = {armor_feet=6, armor_heal=0, armor_use=300, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

--Gold Armor
minetest.register_tool("lottarmor:helmet_gold", {
	description = "Gold Helmet",
	inventory_image = "lottarmor_inv_helmet_gold.png",
	groups = {armor_head=5, armor_heal=0, armor_use=250, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

minetest.register_tool("lottarmor:chestplate_gold", {
	description = "Gold Chestplate",
	inventory_image = "lottarmor_inv_chestplate_gold.png",
	groups = {armor_torso=8, armor_heal=0, armor_use=250, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

minetest.register_tool("lottarmor:leggings_gold", {
	description = "Gold Leggings",
	inventory_image = "lottarmor_inv_leggings_gold.png",
	groups = {armor_legs=8, armor_heal=0, armor_use=250, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

minetest.register_tool("lottarmor:boots_gold", {
	description = "Gold Boots",
	inventory_image = "lottarmor_inv_boots_gold.png",
	groups = {armor_feet=5, armor_heal=0, armor_use=250, armor_healing=0, physics_speed=-0.05},
	wear = 0,
})

--Galvorn Armor
minetest.register_tool("lottarmor:helmet_galvorn", {
	description = "Galvorn Helmet",
	inventory_image = "lottarmor_inv_helmet_galvorn.png",
	groups = {armor_head=8, armor_heal=0, armor_use=100, armor_healing=0, physics_speed=0.01, forbidden=1},
	wear = 0,
})

minetest.register_tool("lottarmor:chestplate_galvorn", {
	description = "Galvorn Chestplate",
	inventory_image = "lottarmor_inv_chestplate_galvorn.png",
	groups = {armor_torso=10, armor_heal=0, armor_use=100, armor_healing=0, physics_speed=0.01, forbidden=1},
	wear = 0,
})

minetest.register_tool("lottarmor:leggings_galvorn", {
	description = "Galvorn Leggings",
	inventory_image = "lottarmor_inv_leggings_galvorn.png",
	groups = {armor_legs=10, armor_heal=0, armor_use=100, armor_healing=0, physics_speed=0.01, forbidden=1},
	wear = 0,
})

minetest.register_tool("lottarmor:boots_galvorn", {
	description = "Galvorn Boots",
	inventory_image = "lottarmor_inv_boots_galvorn.png",
	groups = {armor_feet=8, armor_heal=0, armor_use=100, armor_healing=0, physics_speed=0.01, forbidden=1},
	wear = 0,
})

--Mithril Armor
minetest.register_tool("lottarmor:helmet_mithril", {
	description = "Mithril Helmet",
	inventory_image = "lottarmor_inv_helmet_mithril.png",
	groups = {armor_head=8, armor_heal=0, armor_use=50, armor_healing=0, physics_speed=0.02, forbidden=1},
	wear = 0,
})

minetest.register_tool("lottarmor:chestplate_mithril", {
	description = "Mithril Chestplate",
	inventory_image = "lottarmor_inv_chestplate_mithril.png",
	groups = {armor_torso=10, armor_heal=0, armor_use=50, armor_healing=0, physics_speed=-0.02, forbidden=1},
	wear = 0,
})

minetest.register_tool("lottarmor:leggings_mithril", {
	description = "Mithril Leggings",
	inventory_image = "lottarmor_inv_leggings_mithril.png",
	groups = {armor_legs=10, armor_heal=0, armor_use=50, armor_healing=0, physics_speed=-0.02, forbidden=1},
	wear = 0,
})

minetest.register_tool("lottarmor:boots_mithril", {
	description = "Mithril Boots",
	inventory_image = "lottarmor_inv_boots_mithril.png",
	groups = {armor_feet=7, armor_heal=0, armor_use=50, armor_healing=0, physics_speed=-0.02, forbidden=1},
	wear = 0,
})

minetest.register_tool("lottarmor:helmet_thorium", {
	description = "Thorium Helmet",
	inventory_image = "lottarmor_inv_helmet_thorium.png",
	groups = {armor_head=11, armor_heal=0, armor_use=50, armor_healing=0, physics_speed=0.02, forbidden=1},
	wear = 0,
})

minetest.register_tool("lottarmor:chestplate_thorium", {
	description = "Thorium Chestplate",
	inventory_image = "lottarmor_inv_chestplate_thorium.png",
	groups = {armor_torso=15, armor_heal=0, armor_use=50, armor_healing=0, physics_speed=-0.02, forbidden=1},
	wear = 0,
})

minetest.register_tool("lottarmor:leggings_thorium", {
	description = "Thorium Leggings",
	inventory_image = "lottarmor_inv_leggings_thorium.png",
	groups = {armor_legs=15, armor_heal=0, armor_use=50, armor_healing=0, physics_speed=-0.02, forbidden=1},
	wear = 0,
})

minetest.register_tool("lottarmor:boots_thorium", {
	description = "Thorium Boots",
	inventory_image = "lottarmor_inv_boots_thorium.png",
	groups = {armor_feet=11, armor_heal=0, armor_use=50, armor_healing=0, physics_speed=-0.02, forbidden=1},
	wear = 0,
})
-- Register Craft Recipes

local craft_ingreds = {
	wood = "group:wood",
	tin = "lottores:tin_ingot",
	copper = "default:copper_ingot",
	steel = "default:steel_ingot",
	bronze = "default:bronze_ingot",
	silver = "lottores:silver_ingot",
	gold = "default:gold_ingot",
	galvorn = "lottores:galvorn_ingot",
	mithril = "lottores:mithril_ingot",
	thorium = "lottores:thorium_ingot",
}

for k, v in pairs(craft_ingreds) do
	minetest.register_craft({
		output = "lottarmor:helmet_"..k,
		recipe = {
			{v, v, v},
			{v, "", v},
			{"", "", ""},
		},
	})
	minetest.register_craft({
		output = "lottarmor:chestplate_"..k,
		recipe = {
			{v, "", v},
			{v, v, v},
			{v, v, v},
		},
	})
	minetest.register_craft({
		output = "lottarmor:leggings_"..k,
		recipe = {
			{v, v, v},
			{v, "", v},
			{v, "", v},
		},
	})
	minetest.register_craft({
		output = "lottarmor:boots_"..k,
		recipe = {
			{v, "", v},
			{v, "", v},
		},
	})
end








-- Add a HUD bar for armor

local S
if (minetest.get_modpath("intllib")) then
	S = intllib.Getter()
else
	S = function ( s ) return s end
end

if (not armor) or (not armor.def) then
	minetest.log("error", "[hbarmor] Outdated 3d_armor version. Please update your version of 3d_armor!")
end

local hbarmor = {}

-- HUD statbar values
hbarmor.armor = {}

-- Stores if player's HUD bar has been initialized so far.
hbarmor.player_active = {}

-- Time difference in seconds between updates to the HUD armor bar.
-- Increase this number for slow servers.
hbarmor.tick = 0.4

-- If true, the armor bar is hidden when the player does not wear any armor
hbarmor.autohide = false

--load custom settings
local set = minetest.settings:get_bool("hbarmor_autohide")
if set ~= nil then
	hbarmor.autohide = set
end

set = minetest.settings:get("hbarmor_tick")
if tonumber(set) ~= nil then
	hbarmor.tick = tonumber(set)
end


local must_hide = function(playername, arm)
	return ((not armor.def[playername].count or armor.def[playername].count == 0) and arm == 0)
end

local arm_printable = function(arm)
	return math.ceil(math.floor(arm+0.5))
end

local function custom_hud(player)
	local name = player:get_player_name()

	if minetest.settings:get_bool("enable_damage") then
		local ret = hbarmor.get_armor(player)
		if ret == false then
			minetest.log("error", "[hbarmor] Call to hbarmor.get_armor in custom_hud returned with false!")
		end
		local arm = tonumber(hbarmor.armor[name])
		if not arm then arm = 0 end
		local hide
		if hbarmor.autohide then
			hide = must_hide(name, arm)
		else
			hide = false
		end


		hb.init_hudbar(player, "armor", arm_printable(arm), 100)

	end
end

--register and define armor HUD bar
--hb.register_hudbar("armor", 0xFFFFFF, S("Armor"), { icon = "lottarmor_inv_shield_silver.png", bar = "armor_bar.png" }, 0, 100, hbarmor.autohide, S("%s: %d/100"))





hb.register_hudbar("armor", 0xFFFFFF, S("Armor"), { bar = "armor_bar.png", icon = "lottarmor_inv_shield_silver.png" }, 0, 100, false)


function hbarmor.get_armor(player)
	if not player or not armor.def then
		return false
	end
	local name = player:get_player_name()
	local def = armor.def[name] or nil

	if def and def.level then
		hbarmor.set_armor(name, def.level)
	else
		return false
	end
	return true
end



function hbarmor.set_armor(player_name, level)

	-- I tweaked this code to show the actual armor LEVEL, not durability
	-- 100 armor level is only obtained by wearing Nenya and Narya together

	hbarmor.armor[player_name] = level

end

-- update hud elemtens if value has changed
local function update_hud(player)
	local name = player:get_player_name()
	--armor
	local arm = tonumber(hbarmor.armor[name])
	if not arm then
		arm = 0
		hbarmor.armor[name] = 0
	end
	if hbarmor.autohide then
		-- hide armor bar completely when there is none
		if must_hide(name, arm) then
			hb.hide_hudbar(player, "armor")
		else
			hb.change_hudbar(player, "armor", arm_printable(arm))
			hb.unhide_hudbar(player, "armor")
		end
	else
		hb.change_hudbar(player, "armor", arm_printable(arm))
	end
end

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	custom_hud(player)
	hbarmor.player_active[name] = true
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	hbarmor.player_active[name] = false
end)

local main_timer = 0
local timer = 0
minetest.register_globalstep(function(dtime)
	main_timer = main_timer + dtime
	timer = timer + dtime
	if main_timer > hbarmor.tick or timer > 4 then
		if minetest.settings:get_bool("enable_damage") then
			if main_timer > hbarmor.tick then main_timer = 0 end
			for _,player in ipairs(minetest.get_connected_players()) do
				local name = player:get_player_name()
				if hbarmor.player_active[name] == true then
					local ret = hbarmor.get_armor(player)
					if ret == false then
						minetest.log("error", "[hbarmor] Call to hbarmor.get_armor in globalstep returned with false!")
					end
					-- update all hud elements
					update_hud(player)
				end
			end
		end
	end
	if timer > 4 then timer = 0 end
end)
