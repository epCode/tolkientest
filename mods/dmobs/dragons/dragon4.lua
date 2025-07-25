local dragondef = {
   type = "animal",
   passive = true,
   attacks_monsters = false,
   damage = 10,
   reach = 6,
   attack_type = "dogshoot",
   shoot_interval = 2.5,
	dogshoot_switch = 2,
	dogshoot_count = 0,
	dogshoot_count_max =5,
   arrow = "dmobs:ice_plyr",
   shoot_offset = 1,
   hp_min = 1000,
   hp_max = 1000,
   armor = 80,
	collisionbox = {-0.6, -1.2, -0.6, 0.6, 0.6, 0.6},
   visual = "mesh",
   mesh = "dragon.b3d",
   textures = {
	  {"dmobs_dragon4.png"},
   },
   blood_texture = "mobs_blood.png",
   visual_size = {x=.8, y=.8},
   makes_footstep_sound = true,
	runaway = false,
	jump_chance = 30,
	walk_chance = 80,
	fall_speed = 0,
	follow = {"dmobs:dragon_gem"},
	pathfinding = true,
	fall_damage = 0,
   sounds = {
      shoot_attack = "mobs_fireball",
   },
   walk_velocity = 3,
   run_velocity = 5,
   jump = true,
   fly = true,
   drops = {
      --{name = "dmobs:egg", chance = 1, min = 1, max = 1},
      --{name = "dmobs:dragon_gem", chance = 1, min = 1, max = 1},
   },
   fall_speed = 0,
   stepheight = 10,
   water_damage = 2,
   lava_damage = 0,
   light_damage = 0,
   view_range = 20,
   animation = {
      speed_normal = 10,
      speed_run = 20,
      walk_start = 1,
      walk_end = 22,
      stand_start = 1,
      stand_end = 22,
      run_start = 1,
      run_end = 22,
      punch_start = 22,
      punch_end = 47,
   },
	knock_back = 2,
	do_custom = dmobs.dragon.step_custom_blue,
	on_rightclick = dmobs.dragon.on_rc
}


mobs:register_mob("dmobs:dragon4", dmobs.deepclone(dragondef) )

dragondef.type = "animal"
dragondef.attacks_monsters = true

dragondef.on_rightclick = dmobs.dragon.ride_blue
dragondef.do_custom = dmobs.dragon.do_custom_blue

mobs:register_mob("dmobs:dragon_blue", dmobs.deepclone(dragondef) )
