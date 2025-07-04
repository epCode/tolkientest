function lottmobs.register_dwarf(n, hpmin, hpmax, textures, wv, rv, damg, arm, drops, price)
    mobs:register_mob("lottmobs:dwarf" .. n, {
    	type = "npc",
        race = "GAMEdwarf",
        hp_min = hpmin,
    	hp_max = hpmax,
    	collisionbox = {-0.3,-0.1,-0.3, 0.3,1.4,0.3},
    	textures = textures,
    	visual = "mesh",
    	visual_size = {x=1.2, y=0.8},
    	mesh = "lottarmor_character.b3d",
    	view_range = 12,
    	makes_footstep_sound = true,
    	walk_velocity = wv,
    	run_velocity = rv,
    	armor = arm,
    	damage = damg,
    	drops = drops,
    	light_resistant = true,
    	drawtype = "front",
    	water_damage = 0,
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
    		war_cry = {"dwarf_warcry"},
    		death = "default_death",
    		attack = {"dwarf_atk","dwarf_atk1","dwarf_atk2","dwarf_atk3","dwarf_atk4"},
    	},
    	attacks_monsters = true,
    	on_rightclick = function(self, clicker)
            lottmobs.guard(self, clicker, "default:gold_ingot", "Dwarf", "dwarf", price)
    	end,
        do_custom = lottmobs.do_custom_guard,
    	peaceful = true,
    	group_attack = true,
    	step = 1,
	on_die = lottmobs.guard_die,
    })
    mobs:register_spawn("lottmobs:dwarf" .. n, {"default:stone"}, 15, -1, 24000, 3, -10)
    mobs:register_spawn("lottmobs:dwarf" .. n, {"lottmapgen:ironhill_grass"}, 20, -1, 18000, 3, 31000)
    lottmobs.register_guard_craftitem("lottmobs:dwarf"..n, "Dwarf Guard", "lottmobs_dwarf_guard"..n.."_inv.png")
end

--Normal Dwarves
local textures1 = {
    {"lottmobs_dwarf_1.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
    {"lottmobs_dwarf_2.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
    {"lottmobs_dwarf_3.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
}

local drops1 = {
    {name = "default:iron_lump",
    chance = 3,
    min = 1,
    max = 7,},
    {name = "default:copper_lump",
    chance = 4,
    min = 1,
    max = 4,},
    {name = "default:steel_ingot",
    chance = 3,
    min = 1,
    max = 7,},
    {name = "lottores:tin_lump",
    chance = 8,
    min = 1,
    max = 2,},
    {name = "default:copper_lump",
    chance = 8,
    min = 1,
    max = 2,},
    {name = "default:bronze_ingot",
    chance = 5,
    min = 1,
    max = 6,},
    
}

lottmobs.register_dwarf("", 20, 30, textures1, 2, 4, 5, 175, drops1, 30)

--Dwarves with mithril armor & warhammers.
local textures2 = {
    {"lottmobs_dwarf_1.png", "lottarmor_helmet_mithril.png^lottarmor_chestplate_mithril.png^lottarmor_leggings_mithril.png^lottarmor_boots_mithril.png^lottarmor_shield_mithril.png", "lottweapons_mithril_warhammer.png", "lottarmor_trans.png"},
    {"lottmobs_dwarf_2.png", "lottarmor_helmet_mithril.png^lottarmor_chestplate_mithril.png^lottarmor_leggings_mithril.png^lottarmor_boots_mithril.png^lottarmor_shield_mithril.png", "lottweapons_mithril_warhammer.png", "lottarmor_trans.png"},
    {"lottmobs_dwarf_3.png", "lottarmor_helmet_mithril.png^lottarmor_chestplate_mithril.png^lottarmor_leggings_mithril.png^lottarmor_boots_mithril.png^lottarmor_shield_mithril.png", "lottweapons_mithril_warhammer.png", "lottarmor_trans.png"},
}

local drops2 = {
    {name = "default:iron_lump",
    chance = 3,
    min = 1,
    max = 7,},
    {name = "default:copper_lump",
    chance = 4,
    min = 1,
    max = 4,},
    {name = "default:steel_ingot",
    chance = 3,
    min = 1,
    max = 7,},
    {name = "lottores:tin_lump",
    chance = 8,
    min = 1,
    max = 2,},
    {name = "default:copper_lump",
    chance = 8,
    min = 1,
    max = 2,},
    {name = "default:bronze_ingot",
    chance = 5,
    min = 1,
    max = 6,},
}

lottmobs.register_dwarf("1", 30, 40, textures2, 2.75, 3.5, 13, 75, drops2, 60)

--Dwarves with steel armor & swords.
local textures3 = {
    {"lottmobs_dwarf_1.png", "lottarmor_helmet_steel.png^lottarmor_chestplate_steel.png^lottarmor_leggings_steel.png^lottarmor_boots_steel.png^lottarmor_shield_steel.png", "default_tool_steelsword.png", "lottarmor_trans.png"},
    {"lottmobs_dwarf_2.png", "lottarmor_helmet_steel.png^lottarmor_chestplate_steel.png^lottarmor_leggings_steel.png^lottarmor_boots_steel.png^lottarmor_shield_steel.png", "default_tool_steelsword.png", "lottarmor_trans.png"},
    {"lottmobs_dwarf_3.png", "lottarmor_helmet_steel.png^lottarmor_chestplate_steel.png^lottarmor_leggings_steel.png^lottarmor_boots_steel.png^lottarmor_shield_steel.png", "default_tool_steelsword.png", "lottarmor_trans.png"},
}

local drops3 = {
    {name = "default:iron_lump",
    chance = 3,
    min = 1,
    max = 7,},
    {name = "default:copper_lump",
    chance = 4,
    min = 1,
    max = 4,},
    {name = "default:steel_ingot",
    chance = 3,
    min = 1,
    max = 7,},
    {name = "lottores:tin_lump",
    chance = 8,
    min = 1,
    max = 2,},
    {name = "default:copper_lump",
    chance = 8,
    min = 1,
    max = 2,},
    {name = "default:bronze_ingot",
    chance = 5,
    min = 1,
    max = 6,},
}

lottmobs.register_dwarf("2", 25, 25, textures3, 2.5, 3.5, 7, 100, drops3, 50)
