-- Friendly summons for Rod of Defense
-- Wolf, Elf, Soldier of Gondor, Dwarf

-- Extra sounds from Lords of the Realm 2

-- All minions described in (craftable) Rod of Defense Guide




mobs:register_mob("lottmobs:rohan_guardian", {
	
	type = "npc",
	race = "GAMEman",
	hp_min = 40,
	hp_max = 40,
	
	order = "stand",
	--tamed = true,
	--lifetimer = 10,
	--recovery_time = .5,
	knock_back = 0,
	passive = false,
	floats = 1,
	
	visual_size = {x=1, y=1},
	
	collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.75, 0.3},
	textures = {	
		{"lottmobs_gondor_guard.png", "lottarmor_trans.png", "lottweapons_gold_spear.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_gondor_guard_1.png", "lottarmor_trans.png", "lottweapons_gold_spear.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_gondor_guard_2.png", "lottarmor_trans.png", "lottweapons_gold_spear.png", "lottarmor_trans.png", "lottarmor_trans.png"},
		{"lottmobs_gondor_guard_3.png", "lottarmor_trans.png", "lottweapons_gold_spear.png", "lottarmor_trans.png", "lottarmor_trans.png"},
	},
	visual = "mesh",
	mesh = "lottarmor_character.b3d",
	makes_footstep_sound = true,
	walk_velocity = 4,
	run_velocity = 6,
	view_range = 30,
	armor = 80,
	light_resistant = true,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	
	damage = 8,
	
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
	
	on_rightclick = function(self, clicker)
		lottmobs.guard(self, clicker, nil, "Soldier of Rohan", nil, nil)
	end,
	
	do_custom = lottmobs.do_custom_guard,
	
	peaceful = false,
	group_attack = false,
	step = 1,
	on_die = lottmobs.guard_die,
	jump = true,
	sounds = {
		war_cry = {"rohan_guard_warcry"},
		death = "rohan_guard_death",
		attack = {"rohan_guard_attack"},
	},
	attacks_monsters = true,
	
	reach = 6,
	
	on_activate = function (self)
		local owner = self.owner
		if lottmobs.player_guards[owner][game_name] == nil then
			self.object:remove()
		end
		
	end,
	
	double_melee_attack = true,
	
})





mobs:register_mob("lottmobs:dwarf_guard", {
	
	type = "npc",
	race = "GAMEdwarf",
	hp_min = 50,
	hp_max = 50,
	
	order = "stand",
	--tamed = true,
	--lifetimer = 10,
	--recovery_time = 0.5,
	--knock_back = 0,
	passive = false,
	floats = 1,
	
	visual_size = {x=1.2, y=0.8},
	
	collisionbox = {-0.3,-0.1,-0.3, 0.3,1.4,0.3},
	textures = {
		{"lottmobs_dwarf_3.png",
		"lottarmor_helmet_mithril.png^lottarmor_chestplate_mithril.png^lottarmor_leggings_mithril.png^lottarmor_boots_mithril.png^lottarmor_shield_mithril.png", "lottweapons_mithril_warhammer.png", "lottarmor_trans.png"},
		{"lottmobs_dwarf_2.png",
		"lottarmor_helmet_mithril.png^lottarmor_chestplate_mithril.png^lottarmor_leggings_mithril.png^lottarmor_boots_mithril.png^lottarmor_shield_mithril.png", "lottweapons_mithril_warhammer.png", "lottarmor_trans.png"},
		{"lottmobs_dwarf_1.png",
		"lottarmor_helmet_mithril.png^lottarmor_chestplate_mithril.png^lottarmor_leggings_mithril.png^lottarmor_boots_mithril.png^lottarmor_shield_mithril.png", "lottweapons_mithril_warhammer.png", "lottarmor_trans.png"},
		{"lottmobs_dwarf.png",
		"lottarmor_helmet_mithril.png^lottarmor_chestplate_mithril.png^lottarmor_leggings_mithril.png^lottarmor_boots_mithril.png^lottarmor_shield_mithril.png", "lottweapons_mithril_warhammer.png", "lottarmor_trans.png"},
	},
	visual = "mesh",
	mesh = "lottarmor_character.b3d",
	makes_footstep_sound = true,
	walk_velocity = 2,
	run_velocity = 3,
	view_range = 30,
	armor = 80,
	light_resistant = true,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	damage = 6,
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
	
	on_rightclick = function(self, clicker)
		lottmobs.guard(self, clicker, nil, "Dwarf Guardian", nil, nil)
	end,
	
	do_custom = lottmobs.do_custom_guard,
	
	peaceful = false,
	group_attack = false,
	step = 1,
	on_die = lottmobs.guard_die,
	jump = true,
	sounds = {
		war_cry = {"dwarf_guard_warcry"},
		death = "dwarf_guard_death",
		attack = {"dwarf_guard_attack"},
	},
	attacks_monsters = true,
	
	reach = 3,
	
	on_activate = function (self)
		local owner = self.owner
		if lottmobs.player_guards[owner][game_name] == nil then
			self.object:remove()
		end
		
	end,
	
})









mobs:register_mob("lottmobs:wolf_guard", {
	
	type = "npc",
	race = "GAMEman",
	hp_min = 50,
	hp_max = 50,
	
	order = "stand",
	--tamed = true,
	--lifetimer = 10,
	--recovery_time = 0.5,
	--knock_back = 0,
	passive = false,
	floats = 1,
	
	visual_size = {x=.8, y=.8},
	
	collisionbox = {-.8, 0, -.8, .8, 1.2, .8},
	textures = {
		{"lottmobs_wolf.png"},
	},
	visual = "mesh",
	mesh = "warg.b3d",
	makes_footstep_sound = true,
	walk_velocity = 4,
	run_velocity = 6,
	view_range = 30,
	armor = 100,
	light_resistant = true,
	drawtype = "front",
	water_damage = 1,
	lava_damage = 4,
	light_damage = 0,
	damage = 10,
	attack_type = "dogfight",
	
	animation = {
		speed_normal = 10,
		speed_run = 10,
		stand_start = 135,
		stand_end = 280,
		walk_start = 40,
		walk_end = 75,
		run_start = 80,
		run_end = 130,
		punch_start = 350,
		punch_end = 420,
	},
	
	on_rightclick = function(self, clicker)
		lottmobs.guard(self, clicker, nil, "Wolf Guardian", nil, nil)
	end,
	
	do_custom = lottmobs.do_custom_guard,
	
	peaceful = false,
	group_attack = false,
	step = 1,
	on_die = lottmobs.guard_die,
	jump = true,
	sounds = {
		war_cry = {"wolf_guardian_warcry"},
		death = "wolf_guardian_death",
		attack = {"wolf_guardian_attack"},
	},
	attacks_monsters = true,
	
	reach = 3,
	
	on_activate = function (self)
		local owner = self.owner
		if lottmobs.player_guards[owner][game_name] == nil then
			self.object:remove()
		end
		
	end,
	
})




mobs:register_mob("lottmobs:elf_guard", {
	
	type = "npc",
	race = "GAMEelf",
	hp_min = 25,
	hp_max = 25,
	collisionbox = {-0.20, 0.0, -0.20, 0.20, 1.6, 0.20},
	
	fly = false,
	--fly_in = "air",
	
	textures = {
		{"lottmobs_lorien_elf_1.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
    	{"lottmobs_lorien_elf_2.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
    	{"lottmobs_lorien_elf_3.png", "lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
	},
	
	visual = "mesh",
	visual_size = {x=.7, y=0.9},
	mesh = "lottarmor_character.b3d",
	view_range = 30,
	makes_footstep_sound = true,
	walk_velocity = 4,
	run_velocity = 6,
	damage = 8,
	armor = 100,
	light_resistant = true,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	double_melee_attack = false,
	
	on_rightclick = function(self, clicker)
		lottmobs.guard(self, clicker, nil, "Elf Guardian", nil, nil)
	end,
	
	fly = false,
	
	reach = 4,
	
	--dogshoot_switch = 1,
	--dogshoot_count = 0,
	--dogshoot_count_max = 6,
	
	attack_type = "shoot",
	
	arrow = "lottmobs:lightball",
	
	shoot_interval = 1.5,
	shoot_offset = 0.5,
	
	order = "stand",
	--tamed = true,
	--lifetimer = 10,
	--recovery_time = 0.5,
	--knock_back = 0,
	passive = false,
	floats = 1,
	
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
		shoot_attack = "elf_guard_magic",
		death = "default_death",
		attack = {"elf_guard_attack"},
	},
	attacks_monsters = true,
	do_custom = lottmobs.do_custom_guard,
	peaceful = false,
	group_attack = false,
	step = 1,
	on_die = lottmobs.guard_die,
	
	on_activate = function (self)
		local owner = self.owner
		if lottmobs.player_guards[owner] == nil then
			self.object:remove()
		end
		
	end,
})









-- Magic attack for Elf Guardian (Rod of Defense)


mobs:register_arrow("lottmobs:lightball", {
	visual = "sprite",
	visual_size = {x=1, y=1},
	textures = {"lottmobs_lightball.png"},
	velocity = 18,
	
	hit_player = function(self, player)
		local s = self.object:getpos()
		local p = player:getpos()
		local vec = {x=s.x-p.x, y=s.y-p.y, z=s.z-p.z}
		
		player:punch(self.object, 1.0,  {
			full_punch_interval=1.0,
			damage_groups = {fleshy=12},
		}, vec)
		
		local pos = self.object:getpos()
	end,
	
	-- Does insane damage to mobs, but elf guy was getting owned a lot.  Now he's a portable turret :D
	
	hit_mob = function(self, player)
		local s = self.object:getpos()
		local p = player:getpos()
		local vec = {x=s.x-p.x, y=s.y-p.y, z=s.z-p.z}
		player:punch(self.object, 1.0,  {
			full_punch_interval=1.0,
			damage_groups = {fleshy=40},
		}, vec)
		local pos = self.object:getpos()
	end,
	
})








-- Spider and Nazgul!

mobs:register_mob("lottmobs:spider_guard", {
	
	
	attack_type = "dogshoot",
	shoot_interval = 1,
	dogshoot_switch = 1,
	dogshoot_count = 2,
	--dogshoot_count_max = 8,
	arrow = "lottmobs:web_pet",
	shoot_offset = .5,
	
	type = "npc",
	race = "GAMEman",
	hp_min = 100,
	hp_max = 100,
	
	order = "stand",
	--tamed = true,
	--lifetimer = 10,
	--recovery_time = 0.5,
	--knock_back = 0,
	passive = false,
	floats = 1,
	
	
	reach = 4,
	damage = 10,
	
	collisionbox = {-0.3, -.1, -0.3, 0.3, 1, 0.3},
	visual_size = {x=1, y=1},
	visual = "mesh",
	mesh = "skulltula.b3d",
	textures = {
		{"mobs_skulltula.png"},
	},
	
	makes_footstep_sound = false,
	view_range = 30,
	walk_velocity = 4,
	run_velocity = 6,
	jump_height = 5,
	fall_damage = 0,


	armor = 80,
	light_resistant = true,
	
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	
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
	
	on_rightclick = function(self, clicker)
		lottmobs.guard(self, clicker, nil, "Spider Guardian", "man", nil)
	end,
	
	do_custom = lottmobs.do_custom_guard,
	
	peaceful = false,
	group_attack = false,
	step = 1,
	on_die = lottmobs.guard_die,
	jump = true,
	
	
	sounds = {
		war_cry = {"shelobs_brood_war"},
		death = "shelobs_brood_death",
		attack = {"shelobs_brood_attack"},
	},
	
	attacks_monsters = true,
	
	on_activate = function (self)
		local owner = self.owner
		if lottmobs.player_guards[owner][game_name] == nil then
			self.object:remove()
		end
		
	end,
	
})


-- Web attack for Spider Guardian

mobs:register_arrow("lottmobs:web_pet", {
	visual = "sprite",
	visual_size = {x = 1, y = 1},
	textures = {"web.png"},
	velocity = 16,
	
   --tail = 0, -- enable tail
   --tail_texture = "mobs_loz_swdbeam.png",
   
	hit_player = function(self, player)
	
		--playereffects.apply_effect_type("spider_poison_health", 5, player)
		playereffects.apply_effect_type("spider_poison_slow", 5, player)
		
		
		local s = self.object:getpos()
		local p = player:getpos()
		local vec = {x=s.x-p.x, y=s.y-p.y, z=s.z-p.z}
		
		player:punch(self.object, 2,  {
			full_punch_interval=1.0,
			damage_groups = {fleshy=10},
		}, vec)
	end,
   
   hit_mob = function(self, player)
      player:punch(self.object, 1.0, {
         full_punch_interval = 1.0,
         damage_groups = {fleshy = 20},
      }, nil)
   end,

   hit_node = function(self, pos, node)
		--minetest.set_node(pos, {name="fire:basic_flame"})
      self.object:remove()
   end,
})





mobs:register_mob("lottmobs:nazgul_guard", {
	
	type = "npc",
	race = "GAMEman",
	hp_min = 100,
	hp_max = 100,
	
	collisionbox = {-0.25,0,-0.25, 0.25,1,0.25},
	fly = true,
	fly_in = "air",
	
	mesh = "ringwraith_model.x",
	textures = {
		{"lottmobs_nazgul.png"},
	},
	visual = "mesh",
	visual_size = {x=2, y=2},
	
	
	view_range = 30,
	makes_footstep_sound = false,
	walk_velocity = 4,
	run_velocity = 6,
	damage = 8,
	armor = 80,
	light_resistant = true,
	drawtype = "front",
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	double_melee_attack = false,
	
	on_rightclick = function(self, clicker)
		lottmobs.guard(self, clicker, nil, "Nazgul Guardian", nil, nil)
	end,
	
	fly = true,
	fly_in = "air",
	
	reach = 4,
	
	--dogshoot_switch = 1,
	--dogshoot_count = 0,
	--dogshoot_count_max = 6,
	
	attack_type = "shoot",
	arrow = "lottmobs:darkball_pet",
	
	shoot_interval = 1.5,
	shoot_offset = 0,
	
	order = "stand",
	--tamed = true,
	--lifetimer = 10,
	--recovery_time = 0.5,
	--knock_back = 2,
	passive = false,
	floats = 0,
	
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
	
	sounds = {
		shoot_attack = "nazgul_shoot",
		war_cry = {"nazgul_attack"},
		death = "nazgul_death",
		attack = {"nazgul_attack"},
	},
	
	attacks_monsters = true,
	do_custom = lottmobs.do_custom_guard,
	peaceful = false,
	group_attack = false,
	step = 1,
	on_die = lottmobs.guard_die,
	
	on_activate = function (self)
		local owner = self.owner
		if lottmobs.player_guards[owner] == nil then
			self.object:remove()
		end
		
	end,
})





mobs:register_arrow("lottmobs:darkball_pet", {
	visual = "sprite",
	visual_size = {x=1, y=1},
	textures = {"lottmobs_darkball.png"},
	velocity = 18,
	
	hit_player = function(self, player)
		local s = self.object:getpos()
		local p = player:getpos()
		local vec = {x=s.x-p.x, y=s.y-p.y, z=s.z-p.z}
		
		player:punch(self.object, 1.0,  {
			full_punch_interval=1.0,
			damage_groups = {fleshy=16},
		}, vec)
		
		local pos = self.object:getpos()

	end,
	
	hit_mob = function(self, player)
		local s = self.object:getpos()
		local p = player:getpos()
		local vec = {x=s.x-p.x, y=s.y-p.y, z=s.z-p.z}
		player:punch(self.object, 1.0,  {
			full_punch_interval=1.0,
			damage_groups = {fleshy=50},
		}, vec)
		local pos = self.object:getpos()
	end,
	
})













-- Fairy pet, only from Silmaril

mobs:register_mob("lottmobs:fairy_guard", {
	
	
	attack_type = "shoot",
	shoot_interval = .75,
	arrow = "lottmobs:fairy_attack",
	shoot_offset = 1,
	
	type = "npc",
	race = "GAMEman",
	hp_min = 40,
	hp_max = 40,
	
	order = "follow",
	--tamed = true,
	--lifetimer = 10,
	--recovery_time = 0.5,
	--knock_back = 0,
	passive = false,
	floats = 1,
	
	fly = true,
	fly_in = "air",
	
	reach = 4,
	damage = 10,
	
	collisionbox = {-0.1, 0, -0.1, 0.1, .2, 0.1},
	visual_size = {x=.4, y=.4},
	visual = "mesh",
	mesh = "mobs_mc_blaze.b3d",
	textures = {
		{"mobs_mc_blaze.png"},
	},
	
	makes_footstep_sound = false,
	view_range = 30,
	walk_velocity = 4,
	run_velocity = 6,
	jump_height = 8,
	fall_damage = 0,


	armor = 80,
	light_resistant = true,
	
	water_damage = 0,
	lava_damage = 4,
	light_damage = 0,
	
	animation = {
		stand_start = 1,
		stand_end = 40,
		walk_start = 1,
		walk_end = 40,
		run_start = 1,
		run_end = 40,
		shoot_start = 1,
		shoot_end = 40,
	},
	
	on_rightclick = function(self, clicker)
		lottmobs.guard(self, clicker, nil, "Sprite Guardian", "man", nil)
	end,
	
	do_custom = lottmobs.do_custom_guard,
	
	peaceful = false,
	group_attack = false,
	step = 1,
	on_die = lottmobs.guard_die,
	jump = true,
	
	
	sounds = {
		war_cry = {"fairy_warcry"},
		death = "fairy_death",
		attack = {"fairy_attack"},
	},
	
	attacks_monsters = true,
	
	on_activate = function (self)
		local owner = self.owner
		if lottmobs.player_guards[owner][game_name] == nil then
			self.object:remove()
		end
		
	end,
	
})


-- Ice attack for Fairy Guardian

mobs:register_arrow("lottmobs:fairy_attack", {
	visual = "sprite",
	visual_size = {x = .4, y = .4},
	textures = {"ice_shard.png"},
	velocity = 10,
	
   tail = 0, -- enable tail
   tail_texture = "ice_shard.png",
   
	hit_player = function(self, player)
	
		--playereffects.apply_effect_type("spider_poison_health", 5, player)
		playereffects.apply_effect_type("fairy_slow", 2, player)
		
		
		local s = self.object:getpos()
		local p = player:getpos()
		local vec = {x=s.x-p.x, y=s.y-p.y, z=s.z-p.z}
		player:punch(self.object, 2,  {
			full_punch_interval=1.0,
			damage_groups = {fleshy=8},
		}, vec)
		
   end,
   
   hit_mob = function(self, player)
      player:punch(self.object, 1.0, {
         full_punch_interval = 1.0,
         damage_groups = {fleshy = 40},
      }, nil)
   end,

   hit_node = function(self, pos, node)
		--minetest.set_node(pos, {name="fire:basic_flame"})
      self.object:remove()
   end,
})









