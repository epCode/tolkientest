----- EXAMPLE EFFECT TYPES -----

-- And Ben's added ones, not sure why they are here :)


-- For polymorph effects, the periodic updating of the "multiskin" mod is
-- reverting the textures back to the original.  To fix this, I'm adding
-- stuff to the multiskin update function itself, found in
-- lottarmor/multiskin.lua




--[[ This is just a helper function to inform the user of the chat command
of the result and, if successful, shows the effect ID. ]]
local function notify(name, retcode)
	if(retcode == false) then
		minetest.chat_send_player(name, "Effect application failed. Effect was NOT applied.")
	else
		minetest.chat_send_player(name, "Effect applied. Effect ID: "..tostring(retcode))
	end
end




-- Normal character models for polymorph effects

--MULTISKIN_DEFAULT_SKIN = "character.png"
--MULTISKIN_TRANS = "lottarmor_trans.png"



-- Reset player attributes to default after polymorph effect

function normal_form(player)
	
	local name = player:get_player_name()
    local player_privs = minetest.get_player_privs(name)
    
	player:set_nametag_attributes({color = {a = 255, r = 255, g = 255, b = 255}})
	player:set_properties({ mesh = "character.b3d", makes_footstep_sound = true })
	
	--player:set_texture_mod("")
	
	if player_privs.GAMEelf and not player_privs.GAMEwizard then
		player:set_physics_override({
    		speed = 1.1,
    		jump = 1,
			gravity = 1
		})
	else
		player:set_physics_override({
			speed = 1,
			jump = 1,
			gravity = 1
		})
	end
	
    if player_privs.GAMEelf and not player_privs.GAMEwizard then
    	player:set_properties({ collisionbox = {-0.20, 0.0, -0.20, 0.20, 1.6, 0.20}, visual_size = {x=.7, y=0.9} })
    	player:set_eye_offset({x=0,y=-2,z=0}, {x=0,y=-2,z=0})
		
    elseif player_privs.GAMEdwarf and not player_privs.GAMEwizard then
    	player:set_properties({ collisionbox = {-0.3,0,-0.3, 0.3,1.4,0.3}, visual_size = {x=1.2, y=0.8} })
    	player:set_eye_offset({x=0,y=-5,z=0}, {x=0,y=-5,z=0})
		
    elseif player_privs.GAMEman and not player_privs.GAMEwizard then
    	player:set_properties({ collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.75, 0.3}, visual_size = {x=1, y=1} })
    	player:set_eye_offset({x=0,y=0,z=0}, {x=0,y=0,z=0})
    elseif player_privs.GAMEorc and not player_privs.GAMEwizard then
    	player:set_properties({ collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.75, 0.3}, visual_size = {x=1, y=1} })
    	player:set_eye_offset({x=0,y=0,z=0}, {x=0,y=0,z=0})
    elseif player_privs.GAMEhobbit and not player_privs.GAMEwizard then
    	player:set_properties({ collisionbox = {-0.15,0,-0.15, 0.15,1.1,0.15}, visual_size = {x=.6, y=0.6} })
    	player:set_eye_offset({x=0,y=-6,z=0}, {x=0,y=-6,z=0})
    end
    
    --[[
    if player_privs.GAMEwizard then
    	player:set_properties({ collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.75, 0.3}, visual_size = {x=1, y=1} })
    	player:set_eye_offset({x=0,y=0,z=0}, {x=0,y=0,z=0})
    end
    ]]--
    
    minetest.after(2, function()
		default.player_set_textures(player, {
			multiskin[name].clothing,
			multiskin[name].armor,
			multiskin[name].wielditem,
		})
		multiskin:update_player_visuals(player)
		--armor:set_player_armor(player)
		--armor:update_inventory(player)
	end )
	
	
	
end






-- Damage shield tag indicator
-- Rod of healing (blaze form) and silmaril overheal effect
-- Prevents next source of damage

playereffects.register_effect_type("damage_shield", "Shield", "shields_inv_shield_classic.png", {"shield"}, 
	function(player)
		
		player:set_nametag_attributes({color = "cyan"})
		
	end,
	
	function(effect, player)
		
		player:set_nametag_attributes({color = {a = 255, r = 255, g = 255, b = 255}})
		
	end,
	false,
	true
)

minetest.register_chatcommand("damage_shield", {
	params = "",
	description = "You acquire a shield against damage!",
	privs = {},
	func = function(name, param)
		local ret = playereffects.apply_effect_type("damage_shield", 300, minetest.get_player_by_name(name))
		notify(name, ret)
	end,
})

-- Invisibility
-- Counts as a polymorph because of textures changes

invisibility = {}

playereffects.register_effect_type("invisible", "Invisible", "tnt_smoke.png", {"polymorph"}, 
	function(player)
		
		local name = player:get_player_name()
		invisibility[name] = {}
		
		player:set_nametag_attributes({color = {a = 0, r = 255, g = 255, b = 255}})
		
		player:set_properties ({
			textures = { "invisible_skin.png" },
			visual_size = { x = 0, y = 0 },
			--collisionbox = { 0,0,0,0,0,0 },
			--makes_footstep_sound = false,
			--physical = false,
		})
		
		invisibility[name] = true
				
	end,
	
	function(effect, player)
		
		normal_form(player)
		
		local name = player:get_player_name()
		invisibility[name] = false

	end,
	false,
	true
)

minetest.register_chatcommand("invisible", {
	params = "",
	description = "You become invisible!",
	privs = {},
	func = function(name, param)
		local ret = playereffects.apply_effect_type("invisible",43200, minetest.get_player_by_name(name))
		notify(name, ret)
	end,
})







-- Dragon polymorph

playereffects.register_effect_type("dragon_polymorph", "Dragon!", "rod_of_healing.png", {"polymorph"}, 
	function(player)
		
		local name = player:get_player_name()
		
		player:set_physics_override({
			speed = 4,
			jump = 2,
			gravity = 1
		})
		
		
		player:set_properties({
		
			visual = "mesh",
			mesh = "mobs_mc_dragon.b3d",
			textures = {"mobs_mc_dragon.png"},
			visual_size = {x=.4, y=.4},
	
	animation = {
		fly_speed = 8, stand_speed = 8,
		stand_start = 0,		stand_end = 20,
		walk_start = 0,		walk_end = 20,
		run_start = 0,		run_end = 20,
	},
	
		})
			
	end,
	
	function(effect, player)
		
		normal_form(player)
		
	end,
	false,
	true
)

minetest.register_chatcommand("dragon_polymorph", {
	params = "",
	description = "You polymorph into a sprite!",
	privs = {},
	func = function(name, param)
		local ret = playereffects.apply_effect_type("dragon_polymorph", 10, minetest.get_player_by_name(name))
		notify(name, ret)
	end,
})







-- Wraith form
-- Yeah I know it's called troll, didn't feel like changing it :)
-- Monsters will NOT ATTACK YOU but it slows you down to ~ half speed
-- This is achieved by making you "invisible" but does not change your textures, meaning you are visible to players

playereffects.register_effect_type("troll_polymorph", "Wraith!", "lottmobs_uruk_hai_guard_inv.png", {"polymorph"}, 
	function(player)
		
		local name = player:get_player_name()
		local pos = player:get_pos()
		
		player:set_nametag_attributes({color = {a = 50, r = 255, g = 255, b = 255}})
		
		player:set_physics_override({
			speed = 0.6,
			jump = 1,
			gravity = 1
		})
		
		player:set_properties({
		
			mesh = "ringwraith_model.x",
			textures = {"lottmobs_nazgul.png"},
			visual_size = {x=2, y=2},
			collisionbox = {-0.3,-1,-0.3, 0.3,1,0.3},
			
			makes_footstep_sound = false,
		})
		
		invisibility[name] = {}
		invisibility[name] = true
		
		player:setpos({x = pos.x, y = pos.y + 1, z = pos.z})
			
	end,
	
	function(effect, player)
		
		normal_form(player)
		
		local name = player:get_player_name()
		invisibility[name] = false

	end,
	false,
	true
)

minetest.register_chatcommand("troll_polymorph", {
	params = "",
	description = "You polymorph into a wraith!",
	privs = {},
	func = function(name, param)
		local ret = playereffects.apply_effect_type("troll_polymorph", 10, minetest.get_player_by_name(name))
		notify(name, ret)
	end,
})














-- Rat polymorph, makes you slightly faster and hides name tag!
-- Sneak function of Sting

playereffects.register_effect_type("rat_polymorph", "Rat!", "lottweapons_sting.png", {"polymorph"}, 
	function(player)
		
		local name = player:get_player_name()
		local pos = player:get_pos()
		
		player:set_nametag_attributes({color = {a = 50, r = 255, g = 255, b = 255}})
		
		player:set_physics_override({
			speed = 1.2,
			jump = 1,
			gravity = 1
		})
		
		player:set_properties{makes_footstep_sound = false}
		
		player:set_eye_offset({x=0,y=-20,z=0}, {x=0,y=-20,z=0})
		
		local rand = math.random(2)
		local color = ""
		
		if rand == 1 then
			color = "mobs_rat.png"
		elseif rand == 2 then
			color = "mobs_rat2.png"
		end
			
		player:set_properties({
			
			visual = "mesh",
			mesh = "mobs_rat.b3d",
			textures = {color},
			collisionbox = {-0.2, -1, -0.2, 0.2, -.4, 0.2},
			visual_size = {x=1, y=1}
		})
		
		player:setpos({x = pos.x, y = pos.y + 1, z = pos.z})
			
	end,
	
	function(effect, player)
		
		normal_form(player)
		
		local playername = player:get_player_name()
		local privs = minetest.get_player_privs(effect.playername)
		privs.fly = nil
		minetest.set_player_privs(effect.playername, privs)
		
	end,
	false,
	true
)

minetest.register_chatcommand("rat_polymorph", {
	params = "",
	description = "You polymorph into a rat!",
	privs = {},
	func = function(name, param)
		local ret = playereffects.apply_effect_type("rat_polymorph", 10, minetest.get_player_by_name(name))
		notify(name, ret)
	end,
})








-- Ghost polymorph

playereffects.register_effect_type("ghost_polymorph", "Ghost!", "rod_of_doom.png", {"polymorph"}, 
	function(player)
		
		local name = player:get_player_name()
		local pos = player:get_pos()
		
		player:set_physics_override({
			speed = 1.2,
			jump = 1,
			gravity = 1
		})
		
		collisionbox = {-0.3,0,-0.3, 0.3,1,0.3},
		
		player:set_properties({
		
			visual = "mesh",
			mesh = "creatures_mob.x",
			textures = {"creatures_ghost.png"},
				animation = {
				speed_normal = 30,		speed_run = 30,
				walk_start = 168,		walk_end = 187,

			},
	
		})
		
		player:setpos({x = pos.x, y = pos.y + 1, z = pos.z})
			
	end,
	
	function(effect, player)
		
		normal_form(player)
		
	end,
	false,
	true
)

minetest.register_chatcommand("ghost_polymorph", {
	params = "",
	description = "You polymorph into a ghost!",
	privs = {},
	func = function(name, param)
		local ret = playereffects.apply_effect_type("ghost_polymorph", 10, minetest.get_player_by_name(name))
		notify(name, ret)
	end,
})





-- Healer polymorph

playereffects.register_effect_type("priest_polymorph", "Healer", "silmaril_heal.png", {"polymorph"}, 
	function(player)
		
		local name = player:get_player_name()
		local pos = player:get_pos()
		
		--local colors = {"light_blue", "sapphire", "slate", "white", "silver"}
		
		player:set_physics_override({
			speed = 1.6,
			jump = 1,
			gravity = 1
		})
		
		player:set_properties({
			makes_footstep_sound = true,
			visual = "mesh",
			mesh = "lottarmor_character.b3d",
			textures = {"wizard_skin.png",
		"lottclothes_hood_wizard_white.png^lottclothes_robe_wizard_white.png^lottclothes_trousers_wizard_white.png^lottclothes_shoes_elven.png^lottarmor_trans.png", "lottarmor_trans.png", "lottarmor_trans.png"},
			
		})
		
		player:set_properties({ collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.75, 0.3}, visual_size = {x=1, y=1} })
		player:set_eye_offset({x=0,y=0,z=0}, {x=0,y=0,z=0})
		
		local privs = minetest.get_player_privs(name)
		privs.fly = true
		minetest.set_player_privs(name, privs)
		
		player:setpos({x = pos.x, y = pos.y + 1, z = pos.z})
		
	end,
	
	function(effect, player)
		
		local name = player:get_player_name()
		
		normal_form(player)
		
		local privs = minetest.get_player_privs(name)
		privs.fly = nil
		minetest.set_player_privs(name, privs)
		
	end,
	false,
	true
)

minetest.register_chatcommand("priest_polymorph", {
	params = "",
	description = "You polymorph into a powerful healer!",
	privs = {},
	func = function(name, param)
		local ret = playereffects.apply_effect_type("priest_polymorph", 30, minetest.get_player_by_name(name))
		notify(name, ret)
	end,
})







-- Blaze polymorph

playereffects.register_effect_type("blaze_polymorph", "Healer", "rod_of_healing.png", {"polymorph"}, 
	function(player)
		
		local name = player:get_player_name()
		local pos = player:get_pos()
		
		player:set_physics_override({
			speed = 1.2,
			jump = 1,
			gravity = 1
		})
		
		
		player:set_properties({
			makes_footstep_sound = false,
			visual = "mesh",
			mesh = "mobs_mc_blaze.b3d",
			textures = {"mobs_mc_blaze.png"},
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
			collisionbox = {-0.2, -1, -0.2, 0.2, .6, 0.2},
	
		})
		
		player:set_eye_offset({x=0,y=-6,z=0}, {x=0,y=0,z=0})
		
		player:setpos({x = pos.x, y = pos.y + 1, z = pos.z})
			
	end,
	
	function(effect, player)
		
		normal_form(player)
		
	end,
	false,
	true
)

minetest.register_chatcommand("blaze_polymorph", {
	params = "",
	description = "You polymorph into a sprite!",
	privs = {},
	func = function(name, param)
		local ret = playereffects.apply_effect_type("blaze_polymorph", 10, minetest.get_player_by_name(name))
		notify(name, ret)
	end,
})











-- Bunny polymorph, adds speed and high jump

playereffects.register_effect_type("bunny_polymorph", "Rabbit!", "rod_of_polymorph.png", {"polymorph"}, 
	function(player)
		
		local name = player:get_player_name()
		local pos = player:get_pos()
		local player_privs = minetest.get_player_privs(name)
		
		player:set_physics_override({
			speed = 2.2,
			jump = 1.5,
			gravity = 1
		})
		
		player:set_eye_offset({x=0,y=-14,z=0}, {x=0,y=-14,z=0})
		
		local rand = math.random(3)
		local color = ""
		
		if rand == 1 then
			color = "mobs_bunny_white.png"
		elseif rand == 2 then
			color = "mobs_bunny_brown.png"
		elseif rand == 3 then
			color = "mobs_bunny_grey.png"
		end
		
		player:set_bone_position("Head", {x=0, y=0, z=0}, {x=60, y=0, z=0})
		
		player:set_properties({
			collisionbox = {-0.268, -0.3, -0.268,  0.268, 0.167, 0.268},
			visual = "mesh",
			mesh = "mobs_bunny.b3d",
			drawtype = "front",
			textures = {color},
			
		})
		
		if player_privs.GAMEelf and not player_privs.GAMEwizard then
			player:set_properties({ visual_size = {x=.7, y=0.9} })
			
		elseif player_privs.GAMEdwarf and not player_privs.GAMEwizard then
			player:set_properties({ visual_size = {x=1.2, y=0.8} })
			
		elseif player_privs.GAMEman and not player_privs.GAMEwizard then
			player:set_properties({ visual_size = {x=1, y=1} })
		elseif player_privs.GAMEorc and not player_privs.GAMEwizard then
			player:set_properties({ visual_size = {x=1, y=1} })
		elseif player_privs.GAMEhobbit and not player_privs.GAMEwizard then
			player:set_properties({ visual_size = {x=.6, y=0.6} })
		end
		
		player:setpos({x = pos.x, y = pos.y + 3, z = pos.z})
	end,
	
	function(effect, player)
		
		normal_form(player)
		
	end,
	false,
	true
)

minetest.register_chatcommand("bun", {
	params = "",
	description = "You polymorph into a wascally wabbit!",
	privs = {},
	func = function(name, param)
		local ret = playereffects.apply_effect_type("bunny_polymorph", 10, minetest.get_player_by_name(name))
		notify(name, ret)
	end,
})



-- Butterfly polymorph, adds flight

playereffects.register_effect_type("butterfly_polymorph", "Butterfly", "rod_of_polymorph.png", {"polymorph"}, 
	function(player)
		
		local name = player:get_player_name()
		local pos = player:get_pos()
		
		local rand = math.random(4)
		local color = ""
		
		if rand == 1 then
			color = "butterfly1.png"
		elseif rand == 2 then
			color = "butterfly2.png"
		elseif rand == 3 then
			color = "butterfly3.png"
		elseif rand == 4 then
			color = "butterfly4.png"
		end
		
		player:set_properties({
			visual = "mesh",
			mesh = "butterfly.b3d",
			textures = {color},
			visual_size = {x=0.6, y=0.6},
			collisionbox = {-0.2, -1, -0.2, 0.2, -.4, 0.2},
			
		})
		
		local playername = player:get_player_name()
		local privs = minetest.get_player_privs(playername)
		privs.fly = true
		minetest.set_player_privs(playername, privs)
		
		player:setpos({x = pos.x, y = pos.y + 2, z = pos.z})
				
	end,
	
	
	function(effect, player)
		
		local name = player:get_player_name()
		
		normal_form(player)
		
		local playername = player:get_player_name()
		local privs = minetest.get_player_privs(playername)
		privs.fly = nil
		minetest.set_player_privs(playername, privs)
		
	end,
	false,
	true
)

minetest.register_chatcommand("butterfly_polymorph", {
	params = "",
	description = "You transform into a butterfly!",
	privs = {},
	func = function(name, param)
		local ret = playereffects.apply_effect_type("butterfly_polymorph", 10, minetest.get_player_by_name(name))
		notify(name, ret)
	end,
})








-- Batguy polymorph, adds flight and speed

playereffects.register_effect_type("bat_polymorph", "Bat!", "animal_bat_inv.png", {"polymorph"}, 
	function(player)
		
		local name = player:get_player_name()
    	local privs = minetest.get_player_privs(name)
		
		player:set_physics_override({
			speed = 3.6,
			jump = 2,
			gravity = 1
		})
		
		player:set_properties{makes_footstep_sound = false}
		
		player:set_properties({
			visual = "mesh",
			mesh = "keese.b3d",
			textures = {"mobs_keese.png"},
			visual_size = {x=1.5, y=1.5},
			--collisionbox = {-0.2, 0, -0.2, 0.2, 0.5, 0.2},
		})
		
		privs.fly = true
		minetest.set_player_privs(name, privs)
				
	end,
	
	
	function(effect, player)
		
		local name = player:get_player_name()
		
		normal_form(player)
		
		local playername = player:get_player_name()
		local privs = minetest.get_player_privs(playername)
		privs.fly = nil
		minetest.set_player_privs(playername, privs)
		
	end,
	false,
	true
)

minetest.register_chatcommand("bat_polymorph", {
	params = "",
	description = "You transform into a big bat!",
	privs = {},
	func = function(name, param)
		local ret = playereffects.apply_effect_type("bat_polymorph", 10, minetest.get_player_by_name(name))
		notify(name, ret)
	end,
})













-- Spider poison
-- Slows and poisons health!


playereffects.register_effect_type("spider_poison_health", "Poison", "stamina_hud_poison.png", {"poison"}, 
	
	function(player)
		player:set_hp(player:get_hp() - 1)
        --stamina.change(player, 1)
	end,
	nil, nil, nil, 1
)

playereffects.register_effect_type("spider_poison_slow", "Slowed", "stamina_hud_poison.png", {"speed"}, 
	function(player)
		player:set_physics_override({
			speed = 0.15,
			jump = 0,
			gravity = 1
		})
	end,
	
	function(effect, player)
		player:set_physics_override({
			speed = 1,
			jump = 1,
			gravity = 1
		})
	end,
	false,
	true
)

minetest.register_chatcommand("spider_poison", {
	params = "",
	description = "You are poisoned by a massive spider!",
	privs = {},
	
	func = function(name, param)
		
		local ret = playereffects.apply_effect_type("spider_poison_health", 10, minetest.get_player_by_name(name))
		local ret2 = playereffects.apply_effect_type("spider_poison_slow", 5, minetest.get_player_by_name(name))
		
		notify(name, ret)
		notify(name, ret2)
	end,
})



-- Fairy slow, turn blue :)

playereffects.register_effect_type("fairy_slow", "Frozen!", "mobs_fairy_spark.png", {"speed"}, 
	function(player)
		
		player:set_physics_override({
			speed = 0.5,
			jump = 0,
			gravity = 1
		})
		
		-- Removes flight!
		local playername = player:get_player_name()
		local privs = minetest.get_player_privs(playername)
		privs.fly = nil
		minetest.set_player_privs(playername, privs)
		
		
		
		
		
	end,
	
	function(effect, player)
		player:set_physics_override({
			speed = 1,
			jump = 1,
			gravity = 1
		})
	end,
	false,
	true
)






-- Saruman fireball
-- Works through Dwarven armor fire immunity...


playereffects.register_effect_type("on_fire", "Fire!", "hyruletools_flame.png", {"fire"}, 
	
	function(player)
		player:set_hp(player:get_hp() - 2)
        --stamina.change(player, 1)
	end,
	nil, nil, nil, 1
)

minetest.register_chatcommand("on_fire", {
	params = "",
	description = "You are on fire!",
	privs = {},
	
	func = function(name, param)
		
		local ret = playereffects.apply_effect_type("on_fire", 10, minetest.get_player_by_name(name))
		
		notify(name, ret)
		notify(name, ret2)
	end,
})







-- Deadmen armor reduction

playereffects.register_effect_type("armor_reduction", "Afraid!", "lottarmor_inv_shield_copper.png", {"armor"}, 
	function(player)
		
		local pn = player:get_player_name()
		
		if armor.def[pn] then
			local arm = armor.def[pn].level * .5
			armor.def[pn].level = arm
			
			local armor_groups = {fleshy=100}
			armor_groups.level = math.floor(arm / 20)
			armor_groups.fleshy = 120 - arm
			
			player:set_armor_groups(armor_groups)
		end
		
	end,
	
	function(effect, player)
		
		local pn = player:get_player_name()
		
		if armor.def[pn] then
			local arm = armor.def[pn].level * 2
			
			if arm > 100 then
				arm = 100
			end
			
			
			armor.def[pn].level = arm
			
			local armor_groups = {fleshy=100}
			armor_groups.level = math.floor(arm / 20)
			armor_groups.fleshy = 120 - arm
			
			player:set_armor_groups(armor_groups)
		end
	end,
	false,
	true
)

minetest.register_chatcommand("armor_reduction", {
	params = "",
	description = "Your armor loses its effectiveness!",
	privs = {},
	
	func = function(name, param)
		
		local ret = playereffects.apply_effect_type("armor_reduction", 10, minetest.get_player_by_name(name))
		
		notify(name, ret)
	end,
})













-- Paralyze, from Redead mob (Legend of Minetest)

-- Only stops movement and jump, does not stop using weapon or turning!

playereffects.register_effect_type("paralyze", "Paralyzed", nil, {"speed"}, 
	function(player)
		player:set_physics_override({
			speed = .15,
			jump = 0,
			gravity = 1
		})
	end,
	
	function(effect, player)
		player:set_physics_override({
			speed = 1,
			jump = 1,
			gravity = 1
		})
	end,
	false,
	true
)

minetest.register_chatcommand("paralyze", {
	params = "",
	description = "Paralyze",
	privs = {},
	func = function(name, param)
		local ret = playereffects.apply_effect_type("paralyze", 5, minetest.get_player_by_name(name))
		notify(name, ret)
	end,
})





-- Blind
-- Messes with HUD, experimental

playereffects.register_effect_type("blind", "Blind", nil, {"vision"},
	function(player)
		local hudid = player:hud_add({
			hud_elem_type = "image",
			position = { x=0.5, y=0.5 },
			scale = { x=-100, y=-100 },
			text = "playereffects_example_black.png",
		})
		
		if(hudid ~= nil) then
			return { hudid = hudid }
		else
			minetest.log("error", "[playereffects] [examples] The effect \"Blind\" could not be applied. The call to hud_add(...) failed.")
			return false
		end
	end,
	
	function(effect, player)
		player:hud_remove(effect.metadata.hudid)
	end,
	false,
	true
)








-- Flight

playereffects.register_effect_type("fly", "Fly", "playereffects_example_fly.png", {"fly"},
	function(player)
		local playername = player:get_player_name()
		local privs = minetest.get_player_privs(playername)
		privs.fly = true
		minetest.set_player_privs(playername, privs)
	end,
	function(effect, player)
		local privs = minetest.get_player_privs(effect.playername)
		privs.fly = nil
		minetest.set_player_privs(effect.playername, privs)
	end,
	false,
	true
)

-- Speed

playereffects.register_effect_type("high_speed", "Fast", "fast.png", {"speed"}, 
	function(player)
		player:set_physics_override({
			speed = 2,
			jump = 1,
			gravity = 1
		})
	end,
	
	function(effect, player)
		player:set_physics_override({
			speed = 1,
			jump = 1,
			gravity = 1
		})
	end,
	false,
	true
)


-- High jump

playereffects.register_effect_type("highjump", "Jump", "playereffects_example_highjump.png", {"jump"},
	function(player)
		player:set_physics_override({
			speed = 1,
			jump = 2,
			gravity = 1
		})
	end,
	function(effect, player)
		player:set_physics_override({
			speed = 1,
			jump = 1,
			gravity = 1
		})
	end,
	false,
	true
)





-- VILYA transform
-- Speed, jump, flight in one
-- Polymorph effect so that player can't use it with other forms
-- For instance wraith form with speed/flight


playereffects.register_effect_type("vilya", "Vilya", "lottother_vilya.png", {"polymorph"},
	function(player)
		player:set_physics_override({
			speed = 2,
			jump = 2,
			gravity = 1
		})
		local playername = player:get_player_name()
		local privs = minetest.get_player_privs(playername)
		privs.fly = true
		minetest.set_player_privs(playername, privs)
	end,
	function(effect, player)
		player:set_physics_override({
			speed = 1,
			jump = 1,
			gravity = 1
		})
		local playername = player:get_player_name()
		local privs = minetest.get_player_privs(effect.playername)
		privs.fly = nil
		minetest.set_player_privs(effect.playername, privs)
		
	end,
	false,
	true
)













-- Slow

playereffects.register_effect_type("low_speed", "Low speed", nil, {"speed"}, 
	function(player)
		player:set_physics_override({
			speed = 0.25,
			jump = 1,
			gravity = 1
		})
	end,
	
	function(effect, player)
		player:set_physics_override({
			speed = 1,
			jump = 1,
			gravity = 1
		})
	end,
	false,
	true
)





-- Regeneration
-- Ticks add both stamina and health

playereffects.register_effect_type("regen", "Heal", "heart.png", {"health"},
	function(player)
		player:set_hp(player:get_hp() + 1)
        stamina.change(player, 1)
	end,
	nil, nil, nil, 1
)



-- Repeating effect type: Adds 1 HP per 3 seconds
playereffects.register_effect_type("slowregen", "Slow Regeneration", "heart.png", {"health"},
	function(player)
		player:set_hp(player:get_hp()+1)
	end,
	nil, nil, nil, 15
)











-- Dummy effect for the stress test
playereffects.register_effect_type("stress", "Stress Test Effect", nil, {},
	function(player)
	end,
	function(effect, player)
	end
)













--[[ Null effect. The apply function always returns false, which means applying the
effect will never succeed ]]
playereffects.register_effect_type("null", "No effect", nil, {},
	function()
		return false
	end
)

------ Chat commands for the example effects ------

-- Null effect (never succeeds)
minetest.register_chatcommand("null", {
	params = "",
	description = "Does nothing.",
	privs = {},
	func = function(name, param)
		local ret = playereffects.apply_effect_type("null", 5, minetest.get_player_by_name(name))
		notify(name, ret)
	end,
})

minetest.register_chatcommand("blind", {
	params = "",
	description = "Makes your screen black for a short time.",
	privs = {},
	func = function(name, param)
		local ret = playereffects.apply_effect_type("blind", 5, minetest.get_player_by_name(name))
		notify(name, ret)
	end,
})
minetest.register_chatcommand("fast", {
	params = "",
	description = "Makes you fast for a short time.",
	privs = {},
	func = function(name, param)
		local ret = playereffects.apply_effect_type("high_speed", 10, minetest.get_player_by_name(name))
		notify(name, ret)
	end,
})
minetest.register_chatcommand("hfast", {
	params = "",
	description = "Makes you fast for a short time (hidden effect).",
	privs = {},
	func = function(name, param)
		local ret = playereffects.apply_effect_type("high_speed_hidden", 10, minetest.get_player_by_name(name))
		notify(name, ret)
	end,
})
minetest.register_chatcommand("slow", {
	params = "",
	description = "Makes you slow for a long time.",
	privs = {},
	func = function(name, param)
		local ret = playereffects.apply_effect_type("low_speed", 120, minetest.get_player_by_name(name))
		notify(name, ret)
	end,
})
minetest.register_chatcommand("highjump", {
	params = "",
	description = "Makes you jump higher for a short time.",
	privs = {},
	func = function(name, param)
		local ret = playereffects.apply_effect_type("highjump", 20, minetest.get_player_by_name(name))
		notify(name, ret)
	end,
})

minetest.register_chatcommand("fly", {
	params = "",
	description = "Grants you the fly privilege for a minute. You keep the effect when you die.",
	privs = {},
	func = function(name, param)
		local ret = playereffects.apply_effect_type("fly", 60, minetest.get_player_by_name(name))
		notify(name, ret)
	end,
})

minetest.register_chatcommand("regen", {
	params = "",
	description = "Gives you 1 half heart per second 10 times, healing you by 5 hearts in total.",
	privs = {},
	func = function(name, param)
		local ret = playereffects.apply_effect_type("regen", 10, minetest.get_player_by_name(name))
		notify(name, ret)
	end,
})

minetest.register_chatcommand("slowregen", {
	params = "",
	description = "Gives you 1 half heart every 3 seconds 10 times, healing you by 5 hearts in total.",
	privs = {},
	func = function(name, param)
		local ret = playereffects.apply_effect_type("slowregen", 10, minetest.get_player_by_name(name))
		notify(name, ret)
	end,
})











-- Cancel all active effects

minetest.register_chatcommand("cancelall", {
	params = "",
	description = "Cancels all your effects.",
	privs = {},
	func = function(name, param)
		local effects = playereffects.get_player_effects(name)
		for e=1, #effects do
			playereffects.cancel_effect(effects[e].effect_id)
		end
		minetest.chat_send_player(name, "All effects cancelled.")
	end,
})








--[[ The stress test applies a lot of effects at once.
This is used to test the performance of this mod at very large effect numbers. ]]
minetest.register_chatcommand("stresstest", {
	params = "[<effects>]",
	descriptions = "Start the stress test for Player Effects with <effects> effects.",
	privs = {server=true},
	func = function(name, param)
		local player = minetest.get_player_by_name(name)
		local max = 100
		if(type(param)=="string") then
			if(type(tonumber(param)) == "number") then
				max = tonumber(param)
			end
		end
		minetest.debug("[playereffects] Stress test started for "..name.." with "..max.." effects.")
		for i=1,max do
			playereffects.apply_effect_type("stress", math.random(6,60), player)
			if(i%100==0) then
				minetest.debug("[playereffects] Effect "..i.." of "..max.." applied.")
				minetest.chat_send_player(name, "[playereffects] Effect "..i.." of "..max.." applied.")

			end
		end
	end
})
