lottmobs = {}
lottmobs.connected_player_names = {}
lottmobs.player_guards = {}

local file = io.open(minetest.get_worldpath().."/"..SAVEDIR.."/guard_hunger.txt", "r")
if file then
	lottmobs.player_guards = minetest.deserialize(file:read("*all"))
	file:close()
end

minetest.register_on_joinplayer(function(player)
	lottmobs.connected_player_names[player:get_player_name()] = true
end)




minetest.register_on_leaveplayer(function(player)

	-- Remove guards, lest they become normal NPCs with no master!

	-- This removes ALL GUARDS when a player leaves, even hired ones

	local pname = player:get_player_name()

	for id, entity in pairs(minetest.luaentities) do
		if entity.owner == pname then
			entity.object:remove()
		end
	end

	lottmobs.player_guards[pname] = nil
	lottmobs.save_guard_hunger()

	lottmobs.connected_player_names[player:get_player_name()] = nil

end)





minetest.register_globalstep(function(dtime)
                lottmobs.do_guard_hunger(dtime)
end)

minetest.register_on_shutdown(function()
                lottmobs.save_guard_hunger()
end)


dofile(minetest.get_modpath("lottmobs").."/functions.lua")
dofile(minetest.get_modpath("lottmobs").."/craftitems.lua")
dofile(minetest.get_modpath("lottmobs").."/elves.lua")
dofile(minetest.get_modpath("lottmobs").."/dwarves.lua")
dofile(minetest.get_modpath("lottmobs").."/hobbits.lua")
dofile(minetest.get_modpath("lottmobs").."/horse.lua")
dofile(minetest.get_modpath("lottmobs").."/warg.lua")
dofile(minetest.get_modpath("lottmobs").."/trader_goods.lua")
dofile(minetest.get_modpath("lottmobs").."/trader.lua")
dofile(minetest.get_modpath("lottmobs").."/special_mobs.lua")
dofile(minetest.get_modpath("lottmobs").."/animals.lua")
dofile(minetest.get_modpath("lottmobs").."/guardians.lua")

-- Mobs


mobs:register_mob("lottmobs:ent", {
	type = "npc",
	race = "ents",
	hp_min = 50,
	hp_max = 70,
	collisionbox = {-0.5, 0, -0.5, 0.5, 5, 0.5},
	textures = {
		{"lottmobs_ent.png"},
	},
	visual_size = {x=3.5,y=3.5},
	visual = "mesh",
	mesh = "ent_model.x",
	view_range = 20,
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 5,
	armor = 100,
	damage = 5,
	drops = {
		{name = "default:sapling",
		chance = 15,
		min = 1,
		max = 3,},
		{name = "lottplants:aldersapling",
		chance = 15,
		min = 1,
		max = 3,},
		{name = "lottplants:applesapling",
		chance = 15,
		min = 1,
		max = 3,},
		{name = "lottplants:birchsapling",
		chance = 15,
		min = 1,
		max = 3,},
		{name = "lottplants:beechsapling",
		chance = 15,
		min = 1,
		max = 3,},
		{name = "lottplants:culumaldasapling",
		chance = 15,
		min = 1,
		max = 3,},
		{name = "lottplants:elmsapling",
		chance = 15,
		min = 1,
		max = 3,},
		{name = "lottplants:lebethronsapling",
		chance = 15,
		min = 1,
		max = 3,},
		{name = "lottplants:plumsapling",
		chance = 15,
		min = 1,
		max = 3,},
		{name = "lottplants:rowansapling",
		chance = 15,
		min = 1,
		max = 3,},
		{name = "lottplants:yavannamiresapling",
		chance = 60,
		min = 1,
		max = 1,},

	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 60,
	light_damage = 0,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 17,
		stand_end = 17,
		walk_start = 10,
		walk_end = 80,
		run_start = 10,
		run_end = 80,
		punch_start = 1,
		punch_end = 1,
	},
	jump = true,
	sounds = {
		war_cry = {"mobs_die_yell"},
		death = "mobs_yeti_death",
		attack = {"default_punch2"},
	},
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
	on_die = lottmobs.guard_die,
})
mobs:register_spawn("lottmobs:ent", {"lottmapgen:fangorn_grass"}, 20, -1, 6000, 3, 31000)







mobs:register_mob("lottmobs:spider", {
	type = "monster",
	hp_min = 20,
	hp_max = 40,
	collisionbox = {-0.9, -0.01, -0.7, 0.7, 0.6, 0.7},
	textures = {
		{"lottmobs_spider.png"},
		{"lottmobs_spider_1.png"},
		{"lottmobs_spider_2.png"},
	},
	visual_size = {x=7,y=7},
	visual = "mesh",
	mesh = "spider_model.x",
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 4,
	armor = 100,
	damage = 4,
	drops = {
		{name = "farming:string",
		chance = 3,
		min = 1,
		max = 6,},
		{name = "wool:white",
		chance = 10,
		min = 1,
		max = 3,},
		{name = "lottmobs:meat_raw",
		chance = 5,
		min = 1,
		max = 2,},


		{name = "lottclothes:hood_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:shoes_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:trousers_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:shirt_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:cloak_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 5,
	lava_damage = 10,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 1,
		stand_end = 1,
		walk_start = 20,
		walk_end = 40,
		run_start = 20,
		run_end = 40,
		punch_start = 50,
		punch_end = 90,
	},
	on_rightclick = function(self, clicker)
		local player_inv = clicker:get_inventory()
		local item = clicker:get_wielded_item()
		if item:get_name() == "vessels:glass_bottle" then
			if player_inv:room_for_item("main", 1) then
                item:take_item(1)
                player_inv:add_item("main", "lottmobs:spiderpoison")
            end
			clicker:set_wielded_item(item)
		end
	end,
	jump = true,
	sounds = {
		war_cry = {"spider_warcry"},
		death = "spider_death",
		attack = {"spider_attack"},
	},
	step = 1,
	on_die = lottmobs.guard_die,

	attack_monsters = false,
})


mobs:register_spawn("lottmobs:spider", {"lottmapgen:mirkwood_grass"}, 20, -10, 4000, 4, 31000)







mobs:register_mob("lottmobs:rohan_guard", {
        type = "npc",
        race = "GAMEman",
	hp_min = 20,
	hp_max = 30,
	collisionbox = {-0.3,0,-0.3, 0.3,1.8,0.3},
	textures = {
		{"lottmobs_rohan_guard.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_rohan_guard_1.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_rohan_guard_2.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_rohan_guard_3.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
	},
	visual = "mesh",
	mesh = "lottarmor_character.b3d",
	makes_footstep_sound = true,
	view_range = 12,
	walk_velocity = 2,
	run_velocity = 5,
	armor = 100,
	damage = 5,
	drops = {
		{name = "lottmobs:horseh1",
		chance = 15,
		min = 1,
		max = 1,},
		{name = "default:bronze_ingot",
		chance = 7,
		min = 1,
		max = 5,},
		{name = "lottmobs:horsepeg1",
		chance = 15,
		min = 1,
		max = 1,},
		{name = "lottmobs:horsearah1",
		chance = 15,
		min = 1,
		max = 1,},
		{name = "default:steel_sword",
		chance = 10,
		min = 1,
		max = 1,},
		{name = "lottweapons:steel_spear",
		chance = 10,
		min = 1,
		max = 1,},
		{name = "lottarmor:helmet_bronze",
		chance = 30,
		min = 1,
		max = 1,},
		{name = "lottarmor:chestplate_steel",
		chance = 27,
		min = 1,
		max = 1,},
		{name = "lottarmor:leggings_tin",
		chance = 25,
		min = 1,
		max = 1,},
		{name = "lottarmor:boots_bronze",
		chance = 30,
		min = 1,
		max = 1,},
	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 10,
	light_damage = 0,
	attack_type = "dogfight",
	--follow = "lottother:narya",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	},
	jump = true,
	sounds = {
		war_cry = {"man_yell_1","man_yell_2","man_yell_3","man_yell_4","man_yell_5","man_yell_6"},
		death = "man_death",
		attack = {"man_ugh_1","man_ugh_2","man_ugh_3","man_ugh_4","man_ugh_5","man_ugh_6","man_ugh_7","man_ugh_8"},
	},
	on_rightclick = function(self, clicker)
		lottmobs.guard(self, clicker, "default:gold_ingot", "Rohan Guard", "human")
	end,
	do_custom = lottmobs.do_custom_guard,
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
	on_die = lottmobs.guard_die,
})
mobs:register_spawn("lottmobs:rohan_guard", {"lottmapgen:rohan_grass"}, 20, -1, 6000, 3, 31000)
lottmobs.register_guard_craftitem("lottmobs:rohan_guard", "Rohan Guard", "lottmobs_rohan_guard_inv.png")





mobs:register_mob("lottmobs:gondor_guard", {
	type = "npc",
	race = "GAMEman",
	hp_min = 20,
	hp_max = 30,
	collisionbox = {-0.3,0,-0.3, 0.3,1.8,0.3},
	textures = {
		{"lottmobs_gondor_guard.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_gondor_guard_1.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_gondor_guard_2.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_gondor_guard_3.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
	},
	visual = "mesh",
	mesh = "lottarmor_character.b3d",
	makes_footstep_sound = true,
	view_range = 12,
	walk_velocity = 2,
	run_velocity = 5,
	armor = 100,
	damage = 5,
	drops = {
		{name = "default:steel_ingot",
		chance = 10,
		min = 2,
		max = 5,},
		{name = "default:steel_sword",
		chance = 10,
		min = 1,
		max = 1,},
		{name = "lottplants:whitesapling",
		chance = 100,
		min = 1,
		max = 1,},
		{name = "lottweapons:steel_battleaxe",
		chance = 10,
		min = 1,
		max = 1,},
		{name = "lottweapons:steel_warhammer",
		chance = 10,
		min = 1,
		max = 1,},
		{name = "lottarmor:helmet_steel",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottarmor:chestplate_steel",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottarmor:leggings_steel",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottarmor:boots_steel",
		chance = 20,
		min = 1,
		max = 1,},
	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 10,
	light_damage = 0,
	attack_type = "dogfight",
	--follow = "lottother:narya",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	},
	jump = true,
	sounds = {
		war_cry = {"gondor_warcry_1","gondor_warcry_2","gondor_warcry_3","gondor_warcry_4","gondor_warcry_5","gondor_warcry_6"},
		death = "man_death",
		attack = {"man_ugh_1","man_ugh_2","man_ugh_3","man_ugh_4","man_ugh_5","man_ugh_6","man_ugh_7","man_ugh_8"},
	},
	on_rightclick = function(self, clicker)
		lottmobs.guard(self, clicker, "default:gold_ingot", "Gondor Guard", "human")
	end,
	do_custom = lottmobs.do_custom_guard,
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
	on_die = lottmobs.guard_die,
})
mobs:register_spawn("lottmobs:gondor_guard", {"lottmapgen:gondor_grass"}, 20, -1, 6000, 3, 31000)
lottmobs.register_guard_craftitem("lottmobs:gondor_guard", "Gondor Guard", "lottmobs_gondor_guard_inv.png")

mobs:register_mob("lottmobs:ithilien_ranger", {
	type = "npc",
        race = "GAMEman",
        hp_min = 25,
	hp_max = 40,
	collisionbox = {-0.3,0,-0.3, 0.3,1.8,0.3},
	textures = {
		{"lottmobs_ithilien_ranger.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_ithilien_ranger.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottclothes_cloak_ranger.png"},
		{"lottmobs_ithilien_ranger_1.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_ithilien_ranger_1.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottclothes_cloak_ranger.png"},
	},
	visual = "mesh",
	mesh = "lottarmor_character.b3d",
	makes_footstep_sound = true,
	view_range = 16,
	walk_velocity = 2.5,
	run_velocity = 5,
	armor = 100,
	damage = 6,
	drops = {
		{name = "default:steel_ingot",
		chance = 10,
		min = 2,
		max = 5,},
		{name = "default:steel_sword",
		chance = 10,
		min = 1,
		max = 1,},
		{name = "lottweapons:steel_spear",
		chance = 10,
		min = 1,
		max = 1,},
		{name = "lottweapons:steel_dagger",
		chance = 10,
		min = 1,
		max = 1,},
		{name = "lottclothes:cloak_ranger",
		chance = 15,
		min = 1,
		max = 1,},
		{name = "lottclothes:cap_chetwood",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottclothes:jacket_chetwood",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottclothes:pants_chetwood",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottclothes:boots_chetwood",
		chance = 20,
		min = 1,
		max = 1,},
	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 10,
	light_damage = 0,
	attack_type = "dogfight",
	--follow = "lottother:narya",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	},
	jump = true,
	sounds = {
		war_cry = {"man_yell_1","man_yell_2","man_yell_3","man_yell_4","man_yell_5","man_yell_6"},
		death = "man_death",
		attack = {"man_ugh_1","man_ugh_2","man_ugh_3","man_ugh_4","man_ugh_5","man_ugh_6","man_ugh_7","man_ugh_8"},
	},
	on_rightclick = function(self, clicker)
		lottmobs.guard(self, clicker, "default:gold_ingot", "Ithilien Ranger", "human")
	end,
	do_custom = lottmobs.do_custom_guard,
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
	on_die = lottmobs.guard_die,
})
mobs:register_spawn("lottmobs:ithilien_ranger", {"lottmapgen:ithilien_grass"}, 20, -1, 6000, 3, 31000)
lottmobs.register_guard_craftitem("lottmobs:ithilien_ranger", "Ithilien Ranger", "lottmobs_ithilien_ranger_inv.png")

mobs:register_mob("lottmobs:dunlending", {
        type = "npc",
        race = "GAMEorc",
        hp_min = 17,
	hp_max = 27,
	collisionbox = {-0.3,0,-0.3, 0.3,1.8,0.3},
	visual = "mesh",
	mesh = "lottarmor_character.b3d",
	textures = {
		{"lottmobs_dunlending.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_dunlending_1.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_dunlending_2.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_dunlending_3.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
	},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	armor = 200,
	run_velocity = 5,
	damage = 3,
	drops = {
		{name = "lottores:tinpick",
		chance = 10,
		min = 1,
		max = 1,},
		{name = "lottores:tinaxe",
		chance = 10,
		min = 1,
		max = 1,},
		{name = "lottores:tinshovel",
		chance = 10,
		min = 1,
		max = 1,},
		{name = "lottores:tinspear",
		chance = 10,
		min = 1,
		max = 1,},
		{name = "lottweapons:tin_battleaxe",
		chance = 15,
		min = 1,
		max = 1,},
		{name = "lottweapons:tin_spear",
		chance = 15,
		min = 1,
		max = 1,},
		{name = "lottweapons:tin_warhammer",
		chance = 15,
		min = 1,
		max = 1,},
		{name = "lottweapons:tin_dagger",
		chance = 15,
		min = 1,
		max = 1,},
		{name = "lottarmor:helmet_tin",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottarmor:chestplate_tin",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottarmor:leggings_tin",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottarmor:boots_tin",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottmobs:dirty_trousers",
		chance = 10,
		min = 1,
		max = 1,},
		{name = "lottmobs:dirty_shirt",
		chance = 10,
		min = 1,
		max = 1,},

		{name = "lottclothes:hood_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:shoes_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:trousers_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:shirt_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:cloak_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},

	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 5,
	lava_damage = 10,
	light_damage = 0,
	on_rightclick = function(self, clicker)
		lottmobs.guard(self, clicker, "default:gold_ingot", "Dunlending", "human")
	end,
        do_custom = lottmobs.do_custom_guard,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	},
	jump = true,
	sounds = {
		war_cry = {"mobs_barbarian_yell2"},
		death = "mobs_barbarian_death",
		attack = {"default_punch2"},
	},
	step = 1,
	on_die = lottmobs.guard_die,
})
mobs:register_spawn("lottmobs:dunlending", {"lottmapgen:dunland_grass"}, 20, -1, 6000, 3, 31000)
lottmobs.register_guard_craftitem("lottmobs:dunlending", "Dunlending", "lottmobs_dunlending_inv.png")

local orc_armor = "lottarmor_chestplate_steel.png^lottarmor_leggings_steel.png^lottarmor_helmet_steel.png^lottarmor_boots_steel.png^lottarmor_shield_steel.png^[colorize:#00000055"

mobs:register_mob("lottmobs:orc", {
	type = "npc",
	race = "GAMEorc",
	hp_min = 15,
	hp_max = 35,
	collisionbox = {-0.3,0,-0.3, 0.3,1.8,0.3},
	visual = "mesh",
	mesh = "lottarmor_character.b3d",
	textures = {
		{"lottmobs_orc.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_orc.png", orc_armor, "lottweapons_orc_sword.png", "lottarmor_trans.png"},
		{"lottmobs_orc.png", orc_armor, "lottweapons_orc_sword.png", "lottclothes_cloak_mordor.png"},
		{"lottmobs_orc_1.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_orc_1.png", orc_armor, "lottweapons_orc_sword.png", "lottarmor_trans.png"},
		{"lottmobs_orc_1.png", orc_armor, "lottweapons_orc_sword.png", "lottclothes_cloak_mordor.png"},
		{"lottmobs_orc_2.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_orc_2.png", orc_armor, "lottweapons_orc_sword.png", "lottarmor_trans.png"},
		{"lottmobs_orc_2.png", orc_armor, "lottweapons_orc_sword.png", "lottclothes_cloak_mordor.png"},
	},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1.5,
	armor = 150,
	run_velocity = 5,
	damage = 2,
	drops = {
		{name = "bones:bone",
		chance = 5,
		min = 1,
		max = 2,},
		{name = "lottmobs:meat_raw",
		chance = 7,
		min = 1,
		max = 3,},
		{name = "lottfarming:orc_food",
		chance = 17,
		min = 1,
		max = 3,},
		{name = "lottfarming:orc_medicine",
		chance = 17,
		min = 1,
		max = 3,},
		{name = "lottfarming:potato",
		chance = 14,
		min = 1,
		max = 2,},
		{name = "lottfarming:turnip",
		chance = 14,
		min = 1,
		max = 2,},
		{name = "lottfarming:red_mushroom",
		chance = 10,
		min = 1,
		max = 8,},
		{name = "lottclothes:cloak_mordor",
		chance = 17,
		min = 1,
		max = 1,},
		{name = "lottpotion:wine",
		chance = 26,
		min = 1,
		max = 2,},

		{name = "lottclothes:hood_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:shoes_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:trousers_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:shirt_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:cloak_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},

	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 5,
	lava_damage = 10,
	light_damage = 0,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	},
	jump = true,
	sounds = {
		war_cry = {"mobs_barbarian_yell1"},
		death = "mobs_death1",
		attack = {"default_punch2"},
	},
	on_rightclick = function(self, clicker)
		lottmobs.guard(self, clicker, "default:gold_ingot", "Orc", "orc")
	end,
	do_custom = lottmobs.do_custom_guard,
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
	on_die = lottmobs.guard_die,
})
mobs:register_spawn("lottmobs:orc", {"lottmapgen:mordor_stone"}, 20, -1, 500, 3, 31000)
mobs:register_spawn("lottmobs:orc", {"default:snowblock"}, 15, -1, 8000, 3, 31000)
mobs:register_spawn("lottmobs:orc", {"default:dirt_with_snow"}, 15, -1, 8000, 3, 31000)
mobs:register_spawn("lottmobs:orc", {"lottmapgen:angsnowblock"}, 20, -1, 6000, 5, 31000)
lottmobs.register_guard_craftitem("lottmobs:orc", "Orc Guard", "lottmobs_orc_guard_inv.png")

mobs:register_mob("lottmobs:raiding_orc", {
	type = "npc",
        race = "GAMEorc",
        hp_min = 15,
	hp_max = 35,
	collisionbox = {-0.3,0,-0.3, 0.3,1.8,0.3},
	visual = "mesh",
	mesh = "lottarmor_character.b3d",
	textures = {
		{"lottmobs_orc.png", orc_armor, "lottweapons_orc_sword.png", "lottarmor_trans.png"},
		{"lottmobs_orc_1.png", orc_armor, "lottweapons_orc_sword.png", "lottarmor_trans.png"},
		{"lottmobs_orc_2.png", orc_armor, "lottweapons_orc_sword.png", "lottarmor_trans.png"},
	},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	armor = 70,
	run_velocity = 5,
	damage = 3,
	drops = {
		{name = "lottweapons:orc_sword",
		chance = 10,
		min = 1,
		max = 1,},
		{name = "lottarmor:helmet_steel",
		chance = 17,
		min = 1,
		max = 1,},
		{name = "lottarmor:chestplate_steel",
		chance = 17,
		min = 1,
		max = 1,},
		{name = "lottarmor:leggings_steel",
		chance = 17,
		min = 1,
		max = 1,},
		{name = "lottarmor:boots_steel",
		chance = 17,
		min = 1,
		max = 1,},
		{name = "lottarmor:shield_steel",
		chance = 17,
		min = 1,
		max = 1,},
		{name = "lottmobs:meat_raw",
		chance = 10,
		min = 1,
		max = 3,},
		{name = "lottfarming:orc_food",
		chance = 20,
		min = 1,
		max = 3,},
		{name = "farming:bread",
		chance = 10,
		min = 1,
		max = 3,},
		{name = "lottpotion:wine",
		chance = 25,
		min = 1,
		max = 5,},
		{name = "lottfarming:potato",
		chance = 10,
		min = 1,
		max = 5,},

		{name = "lottclothes:hood_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:shoes_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:trousers_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:shirt_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:cloak_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},


	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 5,
	lava_damage = 10,
	light_damage = 2,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	},
	jump = true,
	sounds = {
		war_cry = {"mobs_barbarian_yell1"},
		death = "mobs_death1",
		attack = {"default_punch2"},
	},
	on_rightclick = function(self, clicker)
		lottmobs.guard(self, clicker, "default:gold_ingot", "Raiding Orc", "orc", "lottmobs:orc")
	end,
	do_custom = lottmobs.do_custom_guard,
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
	on_die = lottmobs.guard_die,
})
mobs:register_spawn("lottmobs:raiding_orc", {"lottmapgen:ithilien_grass"}, 2, -1, 4000, 5, 31000)
mobs:register_spawn("lottmobs:raiding_orc", {"lottmapgen:rohan_grass"}, 2, -1, 4000, 5, 31000)
mobs:register_spawn("lottmobs:raiding_orc", {"lottmapgen:gondor_grass"}, 2, -1, 4000, 5, 31000)


-- Because orcs live underground, right?
mobs:register_spawn("lottmobs:raiding_orc", {"default:stone"}, 20, -1, 20000, 2, -40)


mobs:register_mob("lottmobs:uruk_hai", {
	type = "npc",
        race = "GAMEorc",
        hp_min = 25,
	hp_max = 40,
	collisionbox = {-0.3,0,-0.3, 0.3,1.8,0.3},
	visual = "mesh",
	mesh = "lottarmor_character.b3d",
	textures = {
		{"lottmobs_uruk_hai.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_uruk_hai_1.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_uruk_hai_2.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_uruk_hai_3.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
	},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	armor = 70,
	run_velocity = 5,
	damage = 4,
	drops = {
		{name = "default:bronze_sword",
		chance = 10,
		min = 1,
		max = 1,},
		{name = "lottarmor:helmet_bronze",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottarmor:chestplate_bronze",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottarmor:leggings_bronze",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottarmor:boots_bronze",
		chance = 10,
		min = 1,
		max = 1,},
		{name = "lottweapons:bronze_warhammer",
		chance = 15,
		min = 1,
		max = 1,},
		{name = "lottweapons:bronze_battleaxe",
		chance = 15,
		min = 1,
		max = 1,},
		{name = "lottweapons:bronze_spear",
		chance = 15,
		min = 1,
		max = 1,},
		{name = "lottfarming:potato",
		chance = 5,
		min = 1,
		max = 5,},
		{name = "lottmobs:meat_raw",
		chance = 5,
		min = 1,
		max = 3,},

		{name = "lottclothes:hood_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:shoes_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:trousers_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:shirt_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:cloak_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},

	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 10,
	light_damage = 0,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	},
	jump = true,
	sounds = {
		war_cry = {"mobs_barbarian_yell2"},
		death = "mobs_death2",
		attack = {"mobs_slash_attack"},
	},
	on_rightclick = function(self, clicker)
		lottmobs.guard(self, clicker, "default:gold_ingot", "Uruk Hai", "orc")
	end,
	do_custom = lottmobs.do_custom_guard,
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
	on_die = lottmobs.guard_die,
})
mobs:register_spawn("lottmobs:uruk_hai", {"lottmapgen:mordor_stone"}, 15, -1, 2000, 3, 31000)
mobs:register_spawn("lottmobs:uruk_hai", {"lottmapgen:fangorn_grass"}, 2, -1, 2000, 3, 31000)
lottmobs.register_guard_craftitem("lottmobs:uruk_hai", "Uruk Hai Guard", "lottmobs_uruk_hai_guard_inv.png")


-- Because orcs live underground, right?
mobs:register_spawn("lottmobs:uruk_hai", {"default:stone"}, 20, -1, 20000, 2, -40)


mobs:register_mob("lottmobs:battle_troll", {
	type = "npc",
        race = "GAMEorc",
        hp_min = 45,
	hp_max = 60,
	collisionbox = {-1.4, -0.02, -1.4, 1.4, 5.2, 1.4},
	visual = "mesh",
	mesh = "troll_model.x",
	textures = {
		{"lottmobs_battle_troll.png"},
	},
	visual_size = {x=16, y=16},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 3,

	damage = 15,
	reach = 4,

	drops = {
		{name = "bones:bone",
		chance = 5,
		min = 1,
		max = 5,},
		{name = "lottmobs:meat_raw",
		chance = 5,
		min = 1,
		max = 5,},
		{name = "lottweapons:steel_warhammer",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottweapons:bronze_warhammer",
		chance = 20,
		min = 1,
		max = 5,},
		{name = "lottweapons:silver_warhammer",
		chance = 20,
		min = 1,
		max = 5,},
		{name = "lottweapons:tin_warhammer",
		chance = 20,
		min = 1,
		max = 5,},
		{name = "lottweapons:copper_warhammer",
		chance = 20,
		min = 1,
		max = 5,},

		{name = "lottclothes:hood_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:shoes_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:trousers_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:shirt_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:cloak_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},

	},
	light_resistant = true,
	armor = 50,
	drawtype = "front",
	water_damage = 5,
	lava_damage = 10,
	light_damage = 0,
	on_rightclick = nil,
        do_custom = lottmobs.do_custom_guard,
	attack_type = "dogfight",
	animation = {
		stand_start = 0,
		stand_end = 19,
		walk_start = 20,
		walk_end = 35,
		punch_start = 36,
		punch_end = 48,
		speed_normal = 15,
		speed_run = 15,
	},
	jump = true,
	sounds = {
		war_cry = {"troll_warcry"},
		death = "troll_death",
		attack = {"mobs_stone_death"},
	},
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
})
mobs:register_spawn("lottmobs:battle_troll", {"lottmapgen:mordor_stone"}, 10, -1, 10000, 5, 31000)

mobs:register_mob("lottmobs:half_troll", {
	type = "npc",
        race = "GAMEorc",
        hp_min = 20,
	hp_max = 30,
	collisionbox = {-0.3,0,-0.3, 0.3,0.8,0.3},
	visual = "mesh",
	mesh = "lottarmor_character.b3d",
	textures = {
		{"lottmobs_half_troll.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
	},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 3,

	damage = 10,
	reach = 4,

	armor = 100,
	drops = {
		{name = "default:sword_steel",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "default:sword_bronze",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottores:coppersword",
		chance = 20,
		min = 1,
		max = 5,},
		{name = "lottores:tinsword",
		chance = 20,
		min = 1,
		max = 5,},
		{name = "lottores:goldsword",
		chance = 40,
		min = 1,
		max = 1,},
		{name = "lottfarming:potato",
		chance = 20,
		min = 1,
		max = 2,},
		{name = "lottfarming:turnip",
		chance = 20,
		min = 1,
		max = 2,},
		{name = "lottfarming:red_mushroom",
		chance = 27,
		min = 1,
		max = 8,},
		{name = "lottpotion:wine",
		chance = 20,
		min = 1,
		max = 2,},

		{name = "lottclothes:hood_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:shoes_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:trousers_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:shirt_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:cloak_elven2",
    	chance = 600,
    	min = 1,
    	max = 1,},

	},
	light_resistant = true,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 10,
	light_damage = 0,
	on_rightclick = nil,
        do_custom = lottmobs.do_custom_guard,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	},
	jump = true,
	sounds = {
		war_cry = {"troll_warcry"},
		death = "troll_death",
		attack = {"mobs_stone_death"},
	},
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
})
mobs:register_spawn("lottmobs:half_troll", {"default:snow"}, 15, -1, 8000, 3, 31000)
mobs:register_spawn("lottmobs:half_troll", {"default:snowblock"}, 15, -1, 8000, 3, 31000)
mobs:register_spawn("lottmobs:half_troll", {"default:dirt_with_snow"}, 15, -1, 8000, 3, 31000)
mobs:register_spawn("lottmobs:half_troll", {"lottmapgen:angsnowblock"}, 20, -1, 6000, 5, 31000)

mobs:register_mob("lottmobs:nazgul", {
	type = "monster",
	hp_min = 90,
	hp_max = 110,
	collisionbox = {-0.3,-1.0,-0.3, 0.3,1,0.3},
	visual = "mesh",
	mesh = "ringwraith_model.x",
	textures = {
		{"lottmobs_nazgul.png"},
	},
	visual_size = {x=2, y=2},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 3,
	damage = 10,
	drops = {
		{name = "lottores:mithril_ingot",
		chance = 5,
		min = 1,
		max = 5,},

		{name = "lottweapons:gold_spear",
		chance = 5,
		min = 1,
		max = 1,},

		{name = "lottarmor:boots_dwarf",
    	chance = 400,
    	min = 1,
    	max = 1,},
    	{name = "lottarmor:leggings_dwarf",
    	chance = 400,
    	min = 1,
    	max = 1,},
    	{name = "lottarmor:helmet_dwarf",
    	chance = 400,
    	min = 1,
    	max = 1,},

	},
	drawtype = "front",
	armor = 100,
	water_damage = 10,
	lava_damage = 0,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "dogfight",
	--arrow = "lottmobs:darkball",
	--shoot_interval = 3,
	--shoot_offset = 1,
	--sounds = {
		--shoot_attack = {"lottmobs:darkball"},
	--},
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 1,
		stand_end = 1,
		walk_start = 20,
		walk_end = 60,
		punch_start = 70,
		punch_end = 110,
	},
	jump = true,
	sounds = {
		war_cry = {"mobs_die_yell"},
		death = "default_death",
		attack = {"default_punch2"},
	},
	attacks_monsters = false,
	peaceful = true,
	group_attack = true,
	step = 1,
})
mobs:register_spawn("lottmobs:nazgul", {"default:stone"}, 20, -1, 20000, 3, -50)

mobs:register_mob("lottmobs:witch_king", {
	type = "monster",
	hp_min = 150, --250
	hp_max = 200, --350
	collisionbox = {-0.3,-0.1,-0.3,0.3,1.8,0.3},
	visual = "mesh",
	mesh = "lottarmor_character.b3d",
	textures = {
		{"lottmobs_witch_king.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
	},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	armor = 100,
	run_velocity = 3,
	damage = 12,
	shoot_offset = -0.5,

	drops = {

		{name = "lottores:mithril_ingot",
		chance = 5,
		min = 1,
		max = 5,},
		{name = "lottarmor:chestplate_mithril",
		chance = 46,
		min = 1,
		max = 1,},
		{name = "lottarmor:leggings_mithril",
		chance = 46,
		min = 1,
		max = 1,},
		{name = "lottarmor:helmet_mithril",
		chance = 46,
		min = 1,
		max = 1,},
		{name = "lottarmor:boots_mithril",
		chance = 46,
		min = 1,
		max = 1,},
		{name = "lottweapons:mithril_spear",
		chance = 46,
		min = 1,
		max = 1,},
		{name = "lottores:mithrilsword",
		chance = 46,
		min = 1,
		max = 1,},


		{name = "lottarmor:boots_dwarf",
    	chance = 200,
    	min = 1,
    	max = 1,},
    	{name = "lottarmor:leggings_dwarf",
    	chance = 200,
    	min = 1,
    	max = 1,},
    	{name = "lottarmor:helmet_dwarf",
    	chance = 200,
    	min = 1,
    	max = 1,},

	},
	drawtype = "front",
	water_damage = 1,
	lava_damage = 0,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "shoot",
	arrow = "lottmobs:darkball",
	shoot_interval = 1.5,
	--sounds = {
		--attack = "lottmobs:darkball",
	--},
	animation = {
		speed_normal = 18,
		speed_run = 18,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		punch_start = 189,
		punch_end = 198,
	},
	jump = true,
	sounds = {
		war_cry = {"mobs_die_yell"},
		death = "default_death",
		attack = {"default_punch2"},
	},
	attacks_monsters = false,
	peaceful = true,
	group_attack = true,
	step = 1,
	on_die = lottmobs.guard_die,
})
mobs:register_spawn("lottmobs:witch_king", {"default:stone"}, 20, -1, 60000, 6, -1000) --40000 10






mobs:register_mob("lottmobs:balrog", {
	type = "monster",
	rotate = 180,
	hp_min = 1000,
	hp_max = 1250,
	collisionbox = {-0.8, -2.1, -0.8, 0.8, 2.6, 0.8},
	visual_size = {x=2, y=2},
	visual = "mesh",
	mesh = "balrog_model.b3d",
	textures = {
		{"lottmobs_balrog.png"},
	},
	makes_footstep_sound = true,
	view_range = 40,
	armor = 100,
	walk_velocity = 1,
	run_velocity = 4,

	damage = 30,
	reach = 10,

	drops = {
		{name = "lottweapons:balrog_whip",
		chance = 40,
		min = 1,
		max = 1,},
		{name = "lottarmor:boots_ranger", chance = 40, min = 1, max = 1,},
	},
	drawtype = "front",
	water_damage = 0,
	lava_damage = 0,
	light_damage = 0,
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		stand_start = 0,
		stand_end = 240,
		walk_start = 240,
		walk_end = 300,
		punch_start = 300,
		punch_end = 380,
		speed_normal = 18,
		speed_run = 18,
	},
	jump = true,
	sounds = {
		war_cry = {"mobs_howl"},
		death = "mobs_howl",
		attack = {"mobs_stone_death"},
	},
	attacks_monsters = false,
	peaceful = true,
	group_attack = true,
	step = 1,
	on_die = lottmobs.guard_die,
})
mobs:register_spawn("lottmobs:balrog", {"default:stone"}, 20, -1, 60000, 2, -4000)




mobs:register_mob("lottmobs:dead_men", {
	type = "monster",
	hp_min = 20,
	hp_max = 30,
	collisionbox = {-0.3,-0.1,-0.3, 0.3,1.8,0.3},
	visual = "mesh",
	mesh = "lottarmor_character.b3d",
	textures = {
		{"lottmobs_dead_men.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
	},
	makes_footstep_sound = true,
	view_range = 10,
	walk_velocity = 1,
	run_velocity = 4,
	damage = 5,
	armor = 40,
	drops = {
		{name = "lottweapons:steel_spear",
		chance = 10,
		min = 1,
		max = 1,},
		{name = "default:steel_sword",
		chance = 10,
		min = 1,
		max = 1,},
		{name = "lottarmor:helmet_steel",
		chance = 17,
		min = 1,
		max = 1,},
		{name = "lottarmor:chestplate_steel",
		chance = 17,
		min = 1,
		max = 1,},
		{name = "lottarmor:leggings_steel",
		chance = 17,
		min = 1,
		max = 1,},
		{name = "lottarmor:boots_steel",
		chance = 17,
		min = 1,
		max = 1,},
		{name = "lottarmor:shield_steel",
		chance = 17,
		min = 1,
		max = 1,},
	},
	water_damage = 0,
	lava_damage = 10,
	light_damage = 1,
	drawtype = "front",
	on_rightclick = nil,
	attack_type = "dogfight",
	animation = {
		speed_normal = 15,
		speed_run = 15,
		stand_start = 0,
		stand_end = 79,
		walk_start = 168,
		walk_end = 187,
		run_start = 168,
		run_end = 187,
		punch_start = 189,
		punch_end = 198,
	},
	jump = true,
	sounds = {
		war_cry = {"zombie1"},
		death = "zombie3",
		attack = {"zombie2"},
	},
	attacks_monsters = false,
	peaceful = true,
	group_attack = true,
	step = 1,

	-- Immune to physical weapons, need something magic
	immune_to = {"lottweapons:elven_sword","lottores:silversword","lottores:galvornsword","lottores:coppersword","lottores:tinsword","lottores:goldsword","lottores:mithrilsword"},
})
mobs:register_spawn("lottmobs:dead_men", {"default:stone"}, 20, -1, 6000, 2, -100)




mobs:register_mob("lottmobs:troll", {
	type = "npc",
        race = "GAMEorc",
        hp_min = 50,
	hp_max = 65,
	collisionbox = {-1.4, -0.02, -1.4, 1.4, 5.2, 1.4},
	visual = "mesh",
	mesh = "troll_model.x",
	textures = {
		{"lottmobs_troll.png"},
		{"lottmobs_troll_1.png"},
		{"lottmobs_troll_2.png"},
		{"lottmobs_troll_3.png"},
	},
	visual_size = {x=8, y=8},
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 3,

	damage = 10,
	reach = 4,

	armor = 100,
	drops = {
		{name = "default:stone",
		chance = 5,
		min = 1,
		max = 7,},
		{name = "lottweapons:steel_battleaxe",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottweapons:steel_warhammer",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottweapons:bronze_battleaxe",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottweapons:bronze_warhammer",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottweapons:tin_battleaxe",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottweapons:tin_warhammer",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottweapons:copper_battleaxe",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottweapons:copper_warhammer",
		chance = 10,
		min = 1,
		max = 1,},
		{name = "lottweapons:silver_battleaxe",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottweapons:silver_warhammer",
		chance = 20,
		min = 1,
		max = 1,},

		{name = "lottclothes:hood_elven2",
    	chance = 800,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:shoes_elven2",
    	chance = 800,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:trousers_elven2",
    	chance = 800,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:shirt_elven2",
    	chance = 800,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:cloak_elven2",
    	chance = 800,
    	min = 1,
    	max = 1,},

	},
	drawtype = "front",
	water_damage = 0,
	lava_damage = 10,
	light_damage = 60,
	on_rightclick = nil,
        do_custom = lottmobs.do_custom_guard,
	attack_type = "dogfight",
	animation = {
		stand_start = 0,
		stand_end = 19,
		walk_start = 20,
		walk_end = 35,
		punch_start = 36,
		punch_end = 48,
		speed_normal = 15,
		speed_run = 15,
	},
	jump = true,
	sounds = {
		war_cry = {"troll_warcry"},
		death = "troll_death",
		attack = {"mobs_stone_death"},
	},
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
})

mobs:register_spawn("lottmobs:troll", {"default:stone"}, 20, -1, 8000, 5, -10)
mobs:register_spawn("lottmobs:troll", {"default:snow"}, 20, -1, 6000, 5, 31000)
mobs:register_spawn("lottmobs:troll", {"default:snowblock"}, 20, -1, 6000, 5, 31000)
mobs:register_spawn("lottmobs:troll", {"lottmapgen:angsnowblock"}, 20, -1, 6000, 5, 31000)








mobs:register_arrow("lottmobs:darkball", {
	visual = "sprite",
	visual_size = {x=1, y=1},
	textures = {"lottmobs_darkball.png"},
	velocity = 10,

	-- Added by Ben because this was not hitting other mobs (like dwarf warriors or guards).
	-- The fire could kill them, but the missle itself was not damaging.
	-- Also changed missle damage to players, buffed it to 10.  With armor, still not bad.

	hit_mob = function(self, player)
		local s = self.object:getpos()
		local p = player:getpos()
		local vec = {x=s.x-p.x, y=s.y-p.y, z=s.z-p.z}
		player:punch(self.object, 1.5,  {
			full_punch_interval=1.0,
			damage_groups = {fleshy=10},
		}, vec)
		local pos = self.object:getpos()
	end,



	hit_player = function(self, player)
		local s = self.object:getpos()
		local p = player:getpos()
		local vec = {x=s.x-p.x, y=s.y-p.y, z=s.z-p.z}

		player:punch(self.object, 1.5,  {
			full_punch_interval=1.0,
			damage_groups = {fleshy=15},
		}, vec)

		local pos = self.object:getpos()
                local node1def = minetest.get_node(pos)
                local n = node1def.name
		for dx=-1,1 do
			for dy=-1,1 do
				for dz=-1,1 do
					local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
                    local node2def = minetest.get_node(p)
                    local n2 = node2def.name

					--[[
					if minetest.registered_nodes[n].groups.flammable or n2 == "air" then
						minetest.set_node(p, {name="fire:basic_flame"})
					end
					]]--

					if n2 == "air" then
						minetest.set_node(p, {name="lottother:orange_flame"})
					end

				end
			end
		end
	end,
	hit_node = function(self, pos, node)
                local node1def = minetest.get_node(pos)
                local n = node1def.name
		for dx=-1,1 do
			for dy=-1,1 do
				for dz=-1,1 do
					local p = {x=pos.x+dx, y=pos.y+dy, z=pos.z+dz}
                    local node2def = minetest.get_node(p)
                    local n2 = node2def.name


					--[[
					if minetest.registered_nodes[n].groups.flammable or n2 == "air" then
						minetest.set_node(p, {name="fire:basic_flame"})
					end
					]]--

					if n2 == "air" then
						minetest.set_node(p, {name="lottother:orange_flame"})
					end


				end
			end
		end
	end
})







-- Saruman fireball
-- Big tail, heavy damage
-- Textures and ideas borrowed from Hyrule and Dmobs


mobs:register_arrow("lottmobs:saruman_fire", {

	visual = "sprite",
	visual_size = {x=.1, y=.1},
	--textures = {"hyruletools_flame.png"},
	textures = {"saruman_fire.png"},
	velocity = 8,
	tail = 1, -- enable tail
	tail_texture = "saruman_fire.png",

	hit_player = function(self, player)

		player:punch(self.object, 1.0, {
		full_punch_interval = 1.0,
		damage_groups = {fleshy = 10},
		}, nil)

		playereffects.apply_effect_type("on_fire", 10, player)

	end,

   hit_mob = function(self, player)
	  player:punch(self.object, 1.0, {
	 full_punch_interval = 1.0,
	 damage_groups = {fleshy = 15},
	  }, nil)
   end,

   hit_node = function(self, pos, node)
	  self.object:remove()
   end,


})



-- Web attack for Shelob's Brood
-- Ouch :)

mobs:register_arrow("lottmobs:web", {
	visual = "sprite",
	visual_size = {x = 4, y = 4},
	textures = {"web.png"},
	velocity = 20,

   --tail = 0, -- enable tail
   --tail_texture = "mobs_loz_swdbeam.png",

	hit_player = function(self, player)

		local s = self.object:getpos()
		local p = player:getpos()
		local vec = {x=s.x-p.x, y=s.y-p.y, z=s.z-p.z}
		player:punch(self.object, 2,  {
			full_punch_interval=1.0,
			damage_groups = {fleshy=20},
		}, vec)

		playereffects.apply_effect_type("spider_poison_health", 5, player)
		playereffects.apply_effect_type("spider_poison_slow", 5, player)

	end,

   hit_mob = function(self, player)
      player:punch(self.object, 1.0, {
         full_punch_interval = 1.0,
         damage_groups = {fleshy = 10},
      }, nil)
   end,

   hit_node = function(self, pos, node)
		--minetest.set_node(pos, {name="fire:basic_flame"})
      self.object:remove()
   end,
})









-- Mini web attack for tiny spideys

mobs:register_arrow("lottmobs:web", {
	visual = "sprite",
	visual_size = {x = .6, y = .6},
	textures = {"web.png"},
	velocity = 18,

   --tail = 1, -- enable tail
   --tail_texture = "web.png",

	hit_player = function(self, player)


		local s = self.object:getpos()
		local p = player:getpos()
		local vec = {x=s.x-p.x, y=s.y-p.y, z=s.z-p.z}
		player:punch(self.object, 2,  {
			full_punch_interval=1.0,
			damage_groups = {fleshy=8},
		}, vec)

		playereffects.apply_effect_type("spider_poison_health", 2, player)
		playereffects.apply_effect_type("spider_poison_slow", 2, player)

   end,

   hit_mob = function(self, player)
      player:punch(self.object, 1.0, {
         full_punch_interval = 1.0,
         damage_groups = {fleshy = 7},
      }, nil)
   end,

   hit_node = function(self, pos, node)
		--minetest.set_node(pos, {name="fire:basic_flame"})
      self.object:remove()
   end,
})
