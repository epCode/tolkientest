function lottmobs.register_elf(n, hpmin, hpmax, textures, wv, rv, damg, arm, drops, price)
	mobs:register_mob("lottmobs:elf" .. n, {
		type = "npc",
                race = "GAMEelf",
                hp_min = hpmin,
		hp_max = hpmax,
		collisionbox = {-0.3,0,-0.3, 0.3,1.91,0.3},
		textures = textures,
		visual = "mesh",
		visual_size = {x=0.95, y=1.15},
		mesh = "lottarmor_character.b3d",
		view_range = 20,
		makes_footstep_sound = true,
		walk_velocity = wv,
		run_velocity = rv,
		damage = damg,
		armor = arm,
		drops = drops,
		light_resistant = true,
		drawtype = "front",
		water_damage = 1,
		lava_damage = 10,
		light_damage = 0,
		attack_type = "dogfight",
		--follow = "lottother:narya",
		animation = {
			speed_normal = 15,
			speed_run = 20,
			stand_start = 0,
			stand_end = 79,
			walk_start = 168,
			walk_end = 187,
			run_start = 168,
			run_end = 187,
			punch_start = 189,
			punch_end = 198,
		},
		sounds = {
			war_cry = {"mobs_die_yell"},
			death = "default_death",
			attack = {"mobs_slash_attack"},
		},
		attacks_monsters = true,
		on_rightclick = function(self, clicker)
			lottmobs.guard(self, clicker, "default:gold_ingot", "Elf", "elf", price)
		end,
		do_custom = lottmobs.do_custom_guard,
		peaceful = true,
		group_attack = true,
		step = 1,
		on_die = lottmobs.guard_die,
	})
	mobs:register_spawn("lottmobs:elf" .. n, {"lottmapgen:lorien_grass"}, 20, 0, 4000, 3, 31000)
        lottmobs.register_guard_craftitem("lottmobs:elf"..n, "Elven Guard", "lottmobs_elven_guard"..n.."_inv.png")
end

--Basic elves

local textures1 = {
    {"lottmobs_lorien_elf_1.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
    {"lottmobs_lorien_elf_2.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
    {"lottmobs_lorien_elf_3.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
}

local drops1 = {
	{name = "lottplants:mallornsapling",
	chance = 5,
	min = 1,
	max = 3,},
	{name = "lottplants:mallornwood",
	chance = 5,
	min = 1,
	max = 6,},
	{name = "lottores:silveringot",
	chance = 20,
	min = 1,
	max = 7},
	{name = "lottores:silversword",
	chance = 20,
	min = 1,
	max = 1},
	{name = "lottarmor:helmet_silver",
	chance = 30,
	min = 1,
	max = 1},
	{name = "lottarmor:chestplate_silver",
	chance = 30,
	min = 1,
	max = 1},
	{name = "lottweapons:silver_spear",
	chance = 25,
	min = 1,
	max = 1,},
	{name = "lottores:blue_gem",
	chance = 200,
	min = 1,
	max = 1,},
	{name = "lottplants:yavannamiresapling",
	chance = 100,
	min = 1,
	max = 1,},
}

lottmobs.register_elf("", 20, 35, textures1, 2.5, 5, 4, 200, drops1, 30)

--Elves in full armor

local textures2 = {
    {"lottmobs_lorien_elf_1.png", "lottarmor_chestplate_galvorn.png^lottarmor_leggings_galvorn.png^lottarmor_helmet_galvorn.png^lottarmor_boots_galvorn.png", "lottores_galvornsword.png", "lottarmor_trans.png"},
    {"lottmobs_lorien_elf_2.png", "lottarmor_chestplate_steel.png^lottarmor_leggings_steel.png^lottarmor_helmet_steel.png^lottarmor_boots_steel.png^lottarmor_shield_steel.png", "lottweapons_steel_battleaxe.png", "lottarmor_trans.png"},
    {"lottmobs_lorien_elf_3.png", "lottarmor_chestplate_silver.png^lottarmor_leggings_silver.png^lottarmor_helmet_silver.png^lottarmor_boots_silver.png^lottarmor_shield_silver.png", "lottores_silversword.png", "lottarmor_trans.png"},
}

local drops2 = {
	{name = "lottplants:mallornsapling",
	chance = 5,
	min = 1,
	max = 3,},
	{name = "lottplants:mallornwood",
	chance = 5,
	min = 1,
	max = 6,},
	{name = "lottores:silveringot",
	chance = 20,
	min = 1,
	max = 7},
	{name = "lottores:silversword",
	chance = 20,
	min = 1,
	max = 1},
	{name = "lottarmor:helmet_silver",
	chance = 30,
	min = 1,
	max = 1},
	{name = "lottarmor:chestplate_silver",
	chance = 30,
	min = 1,
	max = 1},
	{name = "lottweapons:silver_spear",
	chance = 25,
	min = 1,
	max = 1,},
	{name = "lottores:blue_gem",
	chance = 200,
	min = 1,
	max = 1,},
	{name = "lottplants:yavannamiresapling",
	chance = 100,
	min = 1,
	max = 1,},
}

lottmobs.register_elf(1, 20, 35, textures2, 2, 4.5, 6, 100, drops2, 50)

--Elves with chestplates and powerful weapons!

local textures3 = {
    {"lottmobs_lorien_elf_1.png", "lottarmor_chestplate_galvorn.png", "lottweapons_elven_sword.png", "lottarmor_trans.png"},
    {"lottmobs_lorien_elf_2.png", "lottarmor_chestplate_gold.png^lottarmor_shield_gold.png", "lottweapons_gold_spear.png", "lottarmor_trans.png"},
    {"lottmobs_lorien_elf_3.png", "lottarmor_shield_steel.png", "lottweapons_steel_warhammer.png", "lottarmor_trans.png"},
}

local drops3 = {
	{name = "lottplants:mallornsapling",
	chance = 5,
	min = 1,
	max = 3,},
	{name = "lottplants:mallornwood",
	chance = 5,
	min = 1,
	max = 6,},
	{name = "lottores:silveringot",
	chance = 20,
	min = 1,
	max = 7},
	{name = "lottores:silversword",
	chance = 20,
	min = 1,
	max = 1},
	{name = "lottarmor:helmet_silver",
	chance = 30,
	min = 1,
	max = 1},
	{name = "lottarmor:chestplate_silver",
	chance = 30,
	min = 1,
	max = 1},
	{name = "lottweapons:silver_spear",
	chance = 25,
	min = 1,
	max = 1,},
	{name = "lottores:blue_gem",
	chance = 200,
	min = 1,
	max = 1,},
	{name = "lottplants:yavannamiresapling",
	chance = 100,
	min = 1,
	max = 1,},
}

lottmobs.register_elf(2, 20, 35, textures3, 2.25, 4.75, 8, 150, drops3, 50)
