mobs:register_mob("lottmobs:elf_trader", {
	type = "npc",
        race = "GAMEelf",
        hp_min = 20,
	hp_max = 50,
	collisionbox = {-0.3,0,-0.3, 0.3,1.91,0.3},
	visual_size = {x=0.95, y=1.15},
	textures = {
		{"lottmobs_elf_trader.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
	},
	visual = "mesh",
	mesh = "lottarmor_character.b3d",
	view_range = 20,
	makes_footstep_sound = true,
	walk_velocity = 1.5,
	run_velocity = 5,
	damage = 6,
	armor = 200,
	drops = { },
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
	peaceful = true,
	group_attack = true,
	step = 1,
	on_rightclick = function(self, clicker)
		lottmobs_trader(self, clicker, entity, lottmobs.elf, "gui_elfbg.png", "GAMEelf")
	end,
})
mobs:register_spawn("lottmobs:elf_trader", {"lottmapgen:lorien_grass"}, 20, 0, 40000, 3, 31000)

mobs:register_mob("lottmobs:human_trader", {
	type = "npc",
        race = "GAMEman",
        hp_min = 15,
	hp_max = 35,
	visual_size = {x=1, y=1},
	collisionbox = {-0.3, 0, -0.3, 0.3, 1.75, 0.3},
	textures = {
		{"lottmobs_human_trader.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
	},
	visual = "mesh",
	mesh = "lottarmor_character.b3d",
	makes_footstep_sound = true,
	view_range = 12,
	walk_velocity = 1,
	run_velocity = 3,
	armor = 100,
	damage = 5,
	drops = { },
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
		war_cry = {"mobs_die_yell"},
		death = "default_death",
		attack = {"default_punch2"},
	},
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
	on_rightclick = function(self, clicker)
		lottmobs_trader(self, clicker, entity, lottmobs.human, "gui_gondorbg.png", "GAMEman")
	end,
})
mobs:register_spawn("lottmobs:human_trader", {"lottmapgen:rohan_grass"}, 20, -1, 40000, 3, 31000)
mobs:register_spawn("lottmobs:human_trader", {"lottmapgen:gondor_grass"}, 20, -1, 40000, 3, 31000)

mobs:register_mob("lottmobs:hobbit_trader", {
	type = "npc",
        race = "GAMEman",
        hp_min = 5,
	hp_max = 15,
	collisionbox = {-0.15,0,-0.15, 0.15,1.1,0.15},
    visual_size = {x=0.6, y=0.6},
	textures = {
		{"lottmobs_hobbit_trader.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
	},
	visual = "mesh",
	mesh = "lottarmor_character.b3d",
	makes_footstep_sound = true,
	walk_velocity = 1,
	armor = 300,
	drops = { },
	light_resistant = true,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 5,
	light_damage = 0,
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
	step=1,
	passive = true,
	sounds = {
	},
	on_rightclick = function(self, clicker)
		lottmobs_trader(self, clicker, entity, lottmobs.hobbit, "gui_hobbitbg.png", "GAMEhobbit")
	end,
})
mobs:register_spawn("lottmobs:hobbit_trader", {"lottmapgen:shire_grass"}, 20, -1, 40000, 3, 31000)

mobs:register_mob("lottmobs:dwarf_trader", {
	type = "npc",
        race = "GAMEdwarf",
        hp_min = 20,
	hp_max = 30,
	collisionbox = {-0.3,-0.1,-0.3, 0.3,1.4,0.3},
    visual_size = {x=1.2, y=0.8},
	textures = {
		{"lottmobs_human_trader.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
	},
	visual = "mesh",
	mesh = "lottarmor_character.b3d",
	
	view_range = 40,
	makes_footstep_sound = true,
	walk_velocity = 1,
	run_velocity = 2,
	armor = 200,
	damage = 4,
	drops = {},
	light_resistant = true,
	drawtype = "front",
	water_damage = 0,
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
		war_cry = {"mobs_die_yell"},
		death = "default_death",
		attack = {"default_punch2"},
	},
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
	on_rightclick = function(self, clicker)
		lottmobs_trader(self, clicker, entity, lottmobs.dwarf, "gui_angmarbg.png", "GAMEdwarf")
	end,
})
mobs:register_spawn("lottmobs:dwarf_trader", {"lottmapgen:ironhill_grass"}, 20, -1, 40000, 3, 31000)




















-- Tom Bombadil!

-- *Rarely* spawns in the Hobbit lands

-- Trade for cheap stuff, he's a vendor!
-- He likes to smoke pipeweed...

-- Don't attack him, he's... eldest :)


mobs:register_mob("lottmobs:bombadil", {
	type = "npc",
	race = "GAMEman",
	hp_min = 500,
	hp_max = 600,
	visual_size = {x=1, y=1},
	collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.75, 0.3},
	textures = {
		{"bombadil.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
	},
	visual = "mesh",
	mesh = "lottarmor_character.b3d",
	makes_footstep_sound = true,
	view_range = 40,
	walk_velocity = 1,
	run_velocity = 6,
	armor = 80,
	damage = 30,
	reach = 6,
	drops = { },
	light_resistant = true,
	drawtype = "front",
	water_damage = 0,
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
		war_cry = {"mobs_die_yell"},
		death = "default_death",
		attack = {"default_punch2"},
	},
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
	
	on_rightclick = function(self, clicker)
		lottmobs_trader(self, clicker, entity, lottmobs.bombadil, "gui_hobbitbg.png", "GAMEman")
	end,
})

mobs:register_spawn("lottmobs:bombadil", {"lottmapgen:shire_grass"}, 20, 1, 80000, 1, 31000)








-- SARUMAN

-- Deadly, has special attacks
-- mobs/api for code

-- Also drops two halves of a special staff
-- Because Gandalf broke it asunder, remember?


mobs:register_mob("lottmobs:saruman", {
	type = "npc",
	race = "GAMEorc",
	hp_min = 500,
	hp_max = 600,
	
	collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.8, 0.3},
	textures = {
		{"saruman.png", "lottarmor_trans.png", "saruman_staff.png", "lottarmor_trans.png"},
	},
	visual = "mesh",
	
	visual_size = {x = 1, y = 1.1},
	
	mesh = "lottarmor_character.b3d",
	makes_footstep_sound = true,
	view_range = 40,
	walk_velocity = 1,
	run_velocity = 4,
	armor = 80,
	damage = 30,
	reach = 6,
	
	drops = { 
		{name = "lottblocks:palantir",
		chance = 20,
		min = 1,
		max = 1,},
		{name = "lottother:saruman_staff_bottom",
		chance = 3,
		min = 1,
		max = 1,},
		{name = "lottother:saruman_staff_top",
		chance = 3,
		min = 1,
		max = 1,},
	},
	
	attack_type = "shoot",
	shoot_interval = 1.5,
	arrow = "lottmobs:saruman_fire",
	shoot_offset = 0,
	
	lifetimer = 10,
	
	light_resistant = true,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 10,
	light_damage = 0,
	
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
		random = "saruman_laugh",
		death = "saruman_death",
		shoot_attack = "firespell",
	},
	
	on_rightclick = function(self, clicker)
		--lottmobs.guard(self, clicker, "default:gold_ingot", "Orc", "orc")
	end,
	
	do_custom = lottmobs.do_custom_guard,
	on_die = lottmobs.guard_die,
	
	
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
	
})

mobs:spawn_specific("lottmobs:saruman", {"lottmapgen:mordor_stone", "lottmapgen:rohan_grass"}, {"air"}, 0, 20, 300, 80000, 1, -10, 1000)




-- UGLUK
-- Scary orc found in Mordor

mobs:register_mob("lottmobs:ugluk", {
	type = "npc",
	race = "GAMEorc",
	hp_min = 400,
	hp_max = 600,
	
	reach = 4,
	
	visual_size = {x = 2, y = 2},
	
	collisionbox = {-0.6, 0, -0.6, 0.6, 3.2, 0.6},
	
	visual = "mesh",
	mesh = "lottarmor_character.b3d",
	textures = {
		
		{"lottmobs_orc_ugluk.png", "lottarmor_trans.png", "lottweapons_orc_sword2.png", "lottarmor_trans.png"},
		
	},
	makes_footstep_sound = true,
	view_range = 40,
	walk_velocity = 1,
	armor = 100,
	run_velocity = 6,
	damage = 16,
	drops = {
		
		{name = "lottweapons:elven_sword",
		chance = 1,
		min = 1,
		max = 1,},
		
		{name = "lottclothes:hood_elven2",
    	chance = 50,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:shoes_elven2",
    	chance = 50,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:trousers_elven2",
    	chance = 50,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:shirt_elven2",
    	chance = 50,
    	min = 1,
    	max = 1,},
    	{name = "lottclothes:cloak_elven2",
    	chance = 50,
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
		--lottmobs.guard(self, clicker, "default:gold_ingot", "Orc", "orc")
	end,
	
	do_custom = lottmobs.do_custom_guard,
	on_die = lottmobs.guard_die,
	
	
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
	
})

mobs:spawn_specific("lottmobs:ugluk", {"lottmapgen:mordor_stone"}, {"air"}, 0, 20, 300, 60000, 1, -10, 1000)


-- The Lady Galadriel
-- Also a trader, but she wants more random elf stuff
-- Taller than other elves

mobs:register_mob("lottmobs:galadriel", {
	type = "npc",
	race = "GAMEelf",
	hp_min = 500,
	hp_max = 600,
	visual_size = {x=.7, y=1.2},
	collisionbox = {-0.2, 0.0, -0.2, 0.2, 2.1, 0.2},
	textures = {
		{"lottmobs_galadriel.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
	},
	visual = "mesh",
	mesh = "lottarmor_character.b3d",
	makes_footstep_sound = true,
	view_range = 40,
	walk_velocity = 1,
	run_velocity = 6,
	armor = 80,
	damage = 30,
	reach = 8,
	drops = { },
	light_resistant = true,
	drawtype = "front",
	water_damage = 0,
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
		--war_cry = {"mobs_die_yell"},
		--death = "default_death",
		attack = {"default_punch2"},
	},
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
	
	on_rightclick = function(self, clicker)
		lottmobs_trader(self, clicker, entity, lottmobs.galadriel, "gui_elfbg.png", "GAMEelf")
	end,
})

mobs:spawn_specific("lottmobs:galadriel", {"lottmapgen:lorien_grass"}, {"air"}, 0, 20, 300, 100000, 1, -10, 1000)



-- Shelob's Brood, adapted from Skulltula of Legend of Minetest (nice piece of work!)
-- DOOMED <heiselong@gmx.com> is author of texture

mobs:register_mob("lottmobs:shelobs_brood", {
	
	--fly = true,
	--fly_in = "air",

	attack_type = "dogshoot",
	shoot_interval = 1,
	dogshoot_switch = 1,
	dogshoot_count = 2,
	--dogshoot_count_max = 5,
	arrow = "lottmobs:web",
	shoot_offset = -1,
	
	type = "monster",
	passive = false,
	
	--attack_type = "dogfight",
	
	reach = 6,
	damage = 10,
	hp_min = 50,
	hp_max = 100,
	armor = 80,
	collisionbox = {-2, -.2, -2, 2, 2, 2},
	visual_size = {x=4, y=4},
	visual = "mesh",
	mesh = "skulltula.b3d",
	textures = {
		{"mobs_skulltula.png"},
	},
	makes_footstep_sound = false,
	view_range = 40,
	walk_velocity = 2,
	run_velocity = 6,
	jump = 1,
	jump_height = 5,
	lifetimer = 500,
	fall_damage = 0,
	
	drops = {
		{name = "lottother:one_ring", chance = 80,	min = 1, max = 1}
	},
	
	on_die = function(self)
		local pos = self.object:get_pos()
		local obj = minetest.add_entity({x=pos.x+2, y=pos.y+2, z=pos.z+2}, "lottmobs:shelobs_brood_small")
		local obj = minetest.add_entity({x=pos.x-2, y=pos.y+2, z=pos.z-2}, "lottmobs:shelobs_brood_small")
		local obj = minetest.add_entity({x=pos.x-2, y=pos.y+2, z=pos.z+2}, "lottmobs:shelobs_brood_small")
		local obj = minetest.add_entity({x=pos.x+2, y=pos.y+2, z=pos.z-2}, "lottmobs:shelobs_brood_small")
	end,
	
	sounds = {
		war_cry = {"shelobs_brood_war"},
		death = "shelobs_brood_death",
		attack = {"shelobs_brood_attack"},
	},
	
	--[[
	do_custom = function(self)
		local pos = self.object:get_pos()
		local objs = minetest.get_objects_inside_radius(pos, 3)	
		for k, obj in pairs(objs) do
			if obj:is_player() then
				playereffects.apply_effect_type("spider_poison_health", 5, obj)
				playereffects.apply_effect_type("spider_poison_slow", 5, obj)
			end
		end
	end,
	]]--
	
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 6,
	animation = {
		speed_normal = 12,
		speed_run = 15,
		stand_start = 45,
		stand_end = 65,
		walk_start = 5,
		walk_end = 25,
		run_start = 5,
		run_end = 25,
		punch_start = 30,
		punch_end = 45,
	},
})


mobs:register_mob("lottmobs:shelobs_brood_small", {
	type = "monster",
	passive = false,
	attack_type = "dogfight",
	reach = 3,
	damage = 6,
	hp_min = 20,
	hp_max = 30,
	armor = 100,
	collisionbox = {-0.3, -.1, -0.3, 0.3, 1, 0.3},
	visual_size = {x=1, y=1},
	visual = "mesh",
	mesh = "skulltula.b3d",
	textures = {
		{"mobs_skulltula.png"},
	},
	makes_footstep_sound = false,
	view_range = 20,
	walk_velocity = 2,
	run_velocity = 4,
	jump = 1,
	jump_height = 5,
	
	drops = {
		{name = "lottores:mithril_lump", chance = 8, min = 1, max = 1},
	},
	
	
	water_damage = 0,
	lava_damage = 5,
	light_damage = 0,
	fear_height = 6,
	animation = {
		speed_normal = 12,
		speed_run = 15,
		stand_start = 45,
		stand_end = 65,
		walk_start = 5,
		walk_end = 25,
		run_start = 5,
		run_end = 25,
		punch_start = 30,
		punch_end = 45,
	},
})

mobs:spawn_specific("lottmobs:shelobs_brood", {"default:stone"}, {"air"}, -1, 10, 60, 60000, 2, -30000, -1500)



mobs:register_mob("lottmobs:ogre", {
	type = "npc",
    race = "GAMEorc",
	
	hp_min = 120,
	hp_max = 130,
	
	collisionbox = {-0.6, -1.3, -0.6, 0.6, 1.5, 0.6},
	visual = "mesh",
	mesh = "ogre.b3d",
	textures = {
		{"ogre.png"},
	},
	visual_size = {x = 3.5, y = 3.5},
	rotate = 180,
	
	makes_footstep_sound = true,
	view_range = 15,
	walk_velocity = 1,
	run_velocity = 3,
	damage = 12,
	reach = 6,
	armor = 100,
	light_resistant = true,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 10,
	light_damage = 0,
	on_rightclick = nil,
        do_custom = lottmobs.do_custom_guard,
	attack_type = "dogfight",
	
	drops = {
      {name = "dmobs:dragon_gem_poison", chance = 100, min = 1, max = 1},
	  {name = "dmobs:dragon_gem_lightning", chance = 100, min = 1, max = 1},
	  {name = "dmobs:dragon_gem_fire", chance = 100, min = 1, max = 1},
	  {name = "dmobs:dragon_gem_ice", chance = 100, min = 1, max = 1},
   },
	
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
		war_cry = {"ogre_war"},
		death = "ogre_death",
		attack = {"ogre_attack"},
	},
	attacks_monsters = true,
	peaceful = true,
	group_attack = true,
	step = 1,
})

mobs:spawn_specific("lottmobs:ogre", {"default:stone"}, {"air"}, -1, 10, 60, 10000, 3, -30000, -200)







-- Badgers!  WE DON'T NEED NO STINKIN BADGERS

-- From dmobs, by DOOMED and others

mobs:register_mob("lottmobs:badger", {
	type = "animal",
	passive = false,
	reach = 2,
	damage = 2,
	attack_type = "dogfight",
	hp_min = 12,
	hp_max = 22,
	armor = 130,
	collisionbox = {-0.3, -0.15, -0.3, 0.3, 0.4, 0.3},
	visual = "mesh",
	mesh = "badger.b3d",
	textures = {
		{"badger.png"},
	},
	blood_texture = "mobs_blood.png",
	visual_size = {x=2, y=2},
	makes_footstep_sound = true,
	walk_velocity = 0.7,
	run_velocity = 1,
	jump = true,
	drops = {
		{name = "lottmobs:meat_raw", chance = 1, min = 1, max = 1},
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	fall_speed = -8,
	fear_height = 4,
	follow = {"lottmobs:meat_raw"},
	view_range = 14,
	animation = {
		speed_normal = 12,
		speed_run = 18,
		walk_start = 34,
		walk_end = 58,
		stand_start = 1,
		stand_end = 30,
		run_start = 34,
		run_end = 58,
		punch_start = 60,
		punch_end = 80,

	},
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end

		mobs:capture_mob(self, clicker, 0, 5, 50, false, nil)
	end,
})

mobs:register_spawn("lottmobs:badger", {"lottmapgen:shire_grass"}, 14, -1, 20000, 2, 31000)



-- KITTENS

mobs:register_mob("lottmobs:kitten", {
	type = "animal",
	passive = true,
	hp_min = 5,
	hp_max = 10,
	armor = 200,
	collisionbox = {-0.3, -0.3, -0.3, 0.3, 0.1, 0.3},
	visual = "mesh",
	visual_size = {x = 0.5, y = 0.5},
	mesh = "mobs_kitten.b3d",
	textures = {
		{"mobs_kitten_striped.png"},
		{"mobs_kitten_splotchy.png"},
		{"mobs_kitten_ginger.png"},
		{"mobs_kitten_sandy.png"},
	},
	makes_footstep_sound = false,
	sounds = {
		random = "mobs_kitten",
	},
	walk_velocity = 0.6,
	run_velocity = 2,
	runaway = true,
	jump = false,
	drops = {
		{name = "farming:cotton", chance = 10, min = 1, max = 1},
	},
	water_damage = 1,
	lava_damage = 5,
	fear_height = 3,
	animation = {
		speed_normal = 42,
		stand_start = 97,
		stand_end = 192,
		walk_start = 0,
		walk_end = 96,
	},
	follow = {"lottmobs:meat_raw"},
	view_range = 8,
	
	on_rightclick = function(self, clicker)

		if mobs:feed_tame(self, clicker, 8, true, true) then
			return
		end

		mobs:capture_mob(self, clicker, 30, 50, 80, false, nil)
	end,
})

mobs:register_spawn("lottmobs:kitten", {"lottmapgen:shire_grass"}, 14, -1, 20000, 2, 31000)
mobs:register_egg("lottmobs:kitten", "Kitten", "default_obsidian.png", 1)


-- Treeman
-- I guess they come from the OLD FOREST, minions of Old Man Willow or something :)

-- From dmobs, by DOOMED and others

mobs:register_mob("lottmobs:treeman", {
	type = "monster",
	passive = false,
	reach = 4,
	damage = 4,
	attack_type = "dogfight",
	hp_min = 62,
	hp_max = 72,
	armor = 130,
	collisionbox = {-0.4, 0, -0.4, 0.4, 3, 0.4},
	visual = "mesh",
	mesh = "treeman.b3d",
	textures = {
		{"treeman.png"},
		{"treeman2.png"},
	},
	blood_texture = "default_tree.png",
	visual_size = {x=1, y=1},
	makes_footstep_sound = true,
	walk_velocity = .2,
	run_velocity = 2.5,
	jump = true,
	drops = {
		{name = "default:stick", chance = 5, min = 3, max = 6},
	},
	water_damage = 0,
	lava_damage = 2,
	light_damage = 0,
	fall_damage = 1,
	fear_height = 10,
	view_range = 14,
	animation = {
		speed_normal = 10,
		speed_run = 13,
		walk_start = 46,
		walk_end = 66,
		stand_start = 1,
		stand_end = 20,
		run_start = 46,
		run_end = 66,
		punch_start = 20,
		punch_end = 45,
	},
})

mobs:register_spawn("lottmobs:treeman", {"default:leaves"}, 8, 0, 200000, 2, 31000)






-- Butterflies

-- From dmobs, by DOOMED and others

minetest.register_abm({
	nodenames = {
		"flowers:flower_rose",
		"flowers:flower_tulip",
		"flowers:flower_dandelion_yellow",
		"flowers:flower_viola",
		"flowers:flower_dandelion_white", 
		"flowers:flower_geranium", 
		"lottplants:athelas", 
		"lottplants:anemones", 
		"lottplants:asphodel", 
		"lottplants:eglantive",
		"lottplants:elanor",
		"lottplants:iris",
		"lottplants:lissuin",
		"lottplants:niphredil",
		"lottplants:mallos",
		"lottplants:seregon"
	},
	interval = 10.0,
	chance = 50,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.add_entity({x=pos.x,y=pos.y+0.3,z=pos.z}, "lottmobs:butterfly")
	end
})

minetest.register_entity("lottmobs:butterfly", {
	visual = "mesh",
	mesh = "butterfly.b3d",
	physical = true,
	textures = {"butterfly.png",},
	visual_size = {x=0.3, y=0.3},
	on_activate = function(self)
		local num = math.random(1,4)
		self.object:set_properties({textures = {"butterfly"..num..".png",},})
		self.object:set_animation({x=1, y=10}, 20, 0)
		self.object:set_yaw(math.pi+num)
		minetest.after(10, function()
		self.object:remove()
		end)
	end,
	on_step = function(self)
		local pos = self.object:get_pos()
		local vec = self.object:get_velocity()
		local num = math.random(-math.pi, math.pi)
		self.object:set_yaw(math.pi+num)
		self.object:set_velocity({x=-math.sin(12*pos.y), y=math.cos(12*pos.x), z=-math.sin(12*pos.y)})
		self.object:set_acceleration({x=-math.sin(6*vec.y), y=math.cos(6*vec.x), z=-math.sin(6*vec.y)})
	end,
	collisionbox = {0,0,0,0,0.1,0},
})




