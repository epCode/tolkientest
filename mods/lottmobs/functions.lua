local invisibility = invisibility or {}
local damage_enabled = minetest.settings:get_bool("enable_damage")

local get_distance = function(a, b)

	local x, y, z = a.x - b.x, a.y - b.y, a.z - b.z

	return math.sqrt(x * x + y * y + z * z)
end

local split = function(str, sep)
        local fields = {}
        local str = str or ""
        local sep = sep or ";"
        for word in string.gmatch(str, '([^'..sep..']+)') do
                fields[#fields + 1] = word
        end
        return fields
end

local value_in_table = function(tab, val)
        for index, value in ipairs(tab) do
                if value == val then
                        return true
                end
        end
        return false
end

local npc_guard_attack = function(self)

	if not self.object:get_pos() or not damage_enabled or self.state == "attack" then
		return
	end
		
	local s = self.object:get_pos()
	local p, sp, dist
	local player, type, obj, min_player, npc_race = nil, nil, nil, nil, nil
	local min_dist = self.view_range + 1
	local objs = minetest.get_objects_inside_radius(s, self.view_range)

	for n = 1, #objs do

		if objs[n]:is_player() then

			if invisibility[ objs[n]:get_player_name() ] then

				type = ""
			else
				player = objs[n]
				type = "player"
			end
		else
			obj = objs[n]:get_luaentity()

			if obj then
				player = obj.object
				type = obj.type
				npc_race = obj.race
			end
		end

		if type == "player" then
			
			local player_privs = minetest.get_player_privs(player:get_player_name())
			
			if (self.attack_player_GAMEelf and player_privs.GAMEelf and not player_privs.GAMEwizard and not player:get_player_name() == self.owner)
			or (self.attack_player_GAMEman and player_privs.GAMEman and not player_privs.GAMEwizard and not player:get_player_name() == self.owner)
			or (self.attack_player_GAMEorc and player_privs.GAMEorc and not player_privs.GAMEwizard and not player:get_player_name() == self.owner)
			or (self.attack_player_GAMEhobbit and player_privs.GAMEhobbit and not player_privs.GAMEwizard and not player:get_player_name() == self.owner)
			or (self.attack_player_GAMEdwarf and player_privs.GAMEdwarf and not player_privs.GAMEwizard and not player:get_player_name() == self.owner)
			or (self.blacklist and value_in_table(self.blacklist, player:get_player_name()) )
			--or (self.whitelist and not value_in_table(self.whitelist, player:get_player_name()) )
			then
			
				p = player:get_pos()

				dist = get_distance(p, s)

				if dist < min_dist then
					min_dist = dist
					min_player = player
				end
			end
		end
		
		
		if ( type == "npc" and self["attack_npc_"..npc_race] )
		or ( type == "monster" ) then
			
			p = obj.object:get_pos()

			dist = get_distance(p, s)

			if dist < min_dist then
				min_dist = dist
				min_player = obj.object
			end
		end
	end


	-- attack player
	if min_player then
		self:do_attack(min_player)
	end
end





local npc_attack = function(self)
	
	if not self.object:get_pos() or not self.view_range then
		return
	end

	--if self.type ~= "npc"
        --or not damage_enabled
	if self.state == "attack" then
		return
	end
	
	
        local player, entity_type, obj, min_player, npc_race = nil, nil, nil, nil, nil
        local min_dist = self.view_range + 1
        local objs = minetest.get_objects_inside_radius(self.object:get_pos(), self.view_range)
        for n = 1, #objs do
			if invisibility[ objs[n]:get_player_name() ] then
				entity_type = ""
			elseif objs[n]:is_player() then
				player = objs[n]
				entity_type = "player"
		else
			obj = objs[n]:get_luaentity()

			if obj then
				player = obj.object
				entity_type = obj.type
				npc_race = obj.race
			end
                end

                if entity_type == "player" or entity_type == "npc" or entity_type == "monster" then

                        local s = self.object:get_pos()
                        local p = player:get_pos()
                        local sp = s

                        -- aim higher to make looking up hills more realistic
                        p.y = p.y + 1
                        sp.y = sp.y + 1

                        local dist = get_distance(p, s)

                        if dist < self.view_range then

                                -- choose closest player to attack
                                --if self:line_of_sight_water(sp, p, 2) == true
                                if dist < min_dist then
                                        if entity_type == "player" then
                                                if not lottclasses.player_same_race_or_ally(player, self.race) then
                                                        min_dist = dist
                                                        min_player = player
                                                end
                                        elseif entity_type == "npc" then
                                                if npc_race ~= "ents" and npc_race ~= self.race and not lottclasses.allies[self.race][npc_race] then
                                                        min_dist = dist
                                                        min_player = player
                                                end
                                        elseif entity_type == "monster" then
                                                min_dist = dist
                                                min_player = player
                                        end
                                end
                        end
                end
        end
         if min_player then
                self:do_attack(min_player)
        end
end

local guard_foods = {
        ["lottfarming:corn"] = 5,
        ["farming:bread"] = 10
}

lottmobs.save_guard_hunger = function()
        minetest.mkdir(minetest.get_worldpath().."/"..SAVEDIR)
	local file = io.open(minetest.get_worldpath().."/"..SAVEDIR.."/guard_hunger.txt", "w")
	if file then
		file:write(minetest.serialize(lottmobs.player_guards))
		file:close()
	end
end

lottmobs.do_guard_hunger = function(dtime)
        for player, bool in pairs(lottmobs.connected_player_names) do
                if lottmobs.player_guards[player] then
                        for name, hunger_def in pairs(lottmobs.player_guards[player]) do
                                lottmobs.guard_eat(hunger_def, player, name, dtime)
                        end
                end
        end
end

lottmobs.guard_eat_active = function(self)
        if lottmobs.player_guards[self.owner] then
                local hunger_def = lottmobs.player_guards[self.owner][self.game_name]
                if hunger_def then
                        self.health = self.health + (hunger_def.health - hunger_def.last_active_health)
                        hunger_def.last_active_health = self.health
                        hunger_def.health = self.health
                        self.object:set_hp(self.health)
                        return
                end
        end
        self.health = 0
        self.object:set_hp(self.health)
end

lottmobs.guard_eat = function(self, owner, name, dtime)
        if self.health <= 0 then
                lottmobs.player_guards[owner][name] = nil
                lottmobs.save_guard_hunger()
        end
        self.eat_timer = self.eat_timer + dtime
        self.timer = self.timer + dtime
        if self.eat_timer >= 60 then
                self.food_level = self.food_level - 1
                self.eat_timer = 0
        end
        if self.food_level <= 0 and self.timer >= 1 then
                self.timer = 0
                local food_inv = minetest.get_inventory({type="player", name=owner})
                if food_inv then
                        for food, eat_value in pairs(guard_foods) do
                                local taken = food_inv:remove_item("bag4contents", ItemStack(food.." 1"))
                                self.food_level = self.food_level + taken:get_count() * eat_value
                                if self.food_level > 1 then
                                        break
                                end
                        end
                end
                if self.food_level <= 0 then
                        self.health = self.health - 1
                end
        end
end

lottmobs.guard_die = function(self, pos)
	if self.owner and self.owner ~= "" then
		--lottmobs.player_guards[self.owner][self.game_name] = nil
		
		lottmobs.player_guards[self.owner] = nil
		lottmobs.save_guard_hunger()
	end
	if self.attack and self.attack:is_player() then
		lottachievements.kill(self.name, self.attack)
	end
end

lottmobs.do_custom_guard = function(self, dtime)
	-- attack timer
	self.timer = self.timer + dtime

	if self.state ~= "attack" then

		if self.timer < 1 then
			return false
		end

		self.timer = 0
	end

	-- never go over 100
	if self.timer > 100 then
		self.timer = 1
	end

	-- node replace check (cow eats grass etc.)
    if not (self.object and self.object:get_pos()) then
    	return
    end
    local pos = self.object:get_pos()
	self:replace(pos)

-- mob plays random sound at times
	if self.sounds.random
	and math.random(1, 100) == 1 then

		minetest.sound_play(self.sounds.random, {
			object = self.object,
			max_hear_distance = self.sounds.distance
		})
	end

	-- environmental damage timer (every 1 second)
	self.env_damage_timer = self.env_damage_timer + dtime

	if (self.state == "attack" and self.env_damage_timer > 1)
	or self.state ~= "attack" then

		self.env_damage_timer = 0

		self:do_env_damage()
	end
	if self.owner and self.owner ~= "" then
                lottmobs.guard_eat_active(self)
                npc_guard_attack(self)
        else
                npc_attack(self)
	end

	self:follow_flop()
	self:do_states(dtime)
        return false
end

local checkbox_pos = {
        "4,3",
        "7,3",
        "1,4",
        "4,4",
        "7,4",
        "1,5",
        "4,5",
        "7,5",
        "1,6",
        "4,6"
}

local get_guard_formspec = function(self)
        local selected_idx = 1
	if self.whitelist == nil then
		self.whitelist = {}
	end
	if self.blacklist == nil then
		self.blacklist = {}
	end

        if self.order == "stand" then selected_idx = 2 end
        local formspec = "size[10,11]"..
                "label[1,1;Name:\t"..self.game_name.."]"..
                "dropdown[7,1;2;order;follow,stand;"..selected_idx.."]"..
                "label[1,3;Attack:]"
                
        local j = 1
        local attack_race = nil
        
        for i = 1, 5, 1 do
                attack_race = self["attack_npc_"..lottclasses.races[i]]
                
                if attack_race == nil then
					if lottclasses.races[i] == self.race then
						attack_race = lottclasses.allies[self.race][lottclasses.races[i]]
					else
						attack_race = not lottclasses.allies[self.race][lottclasses.races[i]]
					end
					
					self["attack_npc_"..lottclasses.races[i]] = attack_race
                end
                
                formspec = formspec..
                      "checkbox["..checkbox_pos[j]..";attack_npc_"..lottclasses.races[i]..";"..
                      lottclasses.races_prefix[i].." NPCs;"..tostring(attack_race).."]"
                j = j + 1
        end
        
        attack_race = nil
        
        for i = 1, 5, 1 do
        	
        	attack_race = self["attack_player_"..lottclasses.races[i]]
            
            if attack_race == nil then
				if lottclasses.races[i] == self.race then
					attack_race = lottclasses.allies[self.race][lottclasses.races[i]]
				else
					attack_race = not lottclasses.allies[self.race][lottclasses.races[i]]
				end
				
				self["attack_player_"..lottclasses.races[i]] = attack_race
			end
			
			formspec = formspec..
				"checkbox["..checkbox_pos[j]..";attack_player_"..lottclasses.races[i]..";"..
				lottclasses.races_prefix[i].." Players;"..tostring(attack_race).."]"
			j = j + 1
        end
        
        formspec = formspec..
                --"field[1,8;9,1;whitelist;Whitelist;"..
                --minetest.formspec_escape(table.concat(self.whitelist, ";")).."]"..
                "field[1,9;9,1;blacklist;Blacklist;"..
                minetest.formspec_escape(table.concat(self.blacklist, ";")).."]"..
                "button_exit[1,10;2,1;exit_button; Proceed]"
		
		

        return formspec
end



lottmobs.get_hiring_formspec = function(price)
        local formspec = "size[6,3]" ..
                "label[0,0;Select the amount of gold you want to offer:]"..
                "dropdown[2,1;2;offer;1"
        for i = 5, price, 5 do
                formspec = formspec..","..i
        end
        formspec = formspec..";1]button_exit[2.25,2;1.5,1;done;Done]"
        return formspec
end




lottmobs.guard = function(self, clicker, payment, mob_name, race, price)
	
	lottmobs.change_settings = function(fields)
		if fields.order then
			self.order = fields.order
		end
		
		for i, v in pairs(lottclasses.races) do
		
			local attack_npc = "attack_npc_"..v
			local attack_player = "attack_player_"..v
			
			if fields[attack_npc] == "true" then
				self[attack_npc] = true
			elseif fields[attack_npc] == "false" then
				self[attack_npc] = false
			end
			
			if fields[attack_player] == "true" then
				self[attack_player] = true
			elseif fields[attack_player] == "false" then
				self[attack_player] = false
			end
		end
		
		if fields.whitelist then
			self.whitelist = split(fields.whitelist, ";")
		end
		if fields.blacklist then
			self.blacklist = split(fields.blacklist, ";")
		end
		
	end
	
	
	local owner = self.owner
	local name = clicker:get_player_name()
	
	local this_mob = self.game_name
	
	local item = clicker:get_wielded_item()
	
	
	
	
	if self.owner == name then
		minetest.show_formspec(name, "mob_settings", get_guard_formspec(self))
	end
	
	
	
	
	
	
	
	if item:get_name() == "lottfarming:corn"
	or item:get_name() == "farming:bread" then
		local hp = self.object:get_hp()
		if hp >= self.hp_max then
			minetest.chat_send_player(name, "NPC at full health.")
			return
		end
		hp = hp + 4
		if hp > self.hp_max then hp = self.hp_max end
		self.object:set_hp(hp)
		if not minetest.settings:get_bool("creative_mode") then
			item:take_item()
			clicker:set_wielded_item(item)
		end
		
	elseif item:get_name() == payment and self.tamed == false and lottclasses.player_same_race_or_ally(clicker, self.race) then
		lottmobs.face_pos(self, clicker:get_pos())
		self.state = "stand"
                if not price then price = 50 end
		minetest.show_formspec(name, "mob_hiring", lottmobs.get_hiring_formspec(price))
		lottmobs.hire = function(cost)
			if math.random(1, (price/cost)) == 1 then
				minetest.chat_send_player(name, "[NPC] <" .. mob_name .. "> Okay, I'll work for you.")
				local count = item:get_count()
				if count > cost or minetest.settings:get_bool("creative_mode") then
					if not minetest.settings:get_bool("creative_mode") then
						item:take_item(cost)
						clicker:set_wielded_item(item)
					end
                                        clicker:get_inventory():add_item("main", self.name)
                                        self.object:remove()
				else
					minetest.chat_send_player(name, "[NPC] <" .. mob_name .. "> What, you don't have that much money?! Stop wasting my time!")
				end
			else
				local rand = math.random(1, 5)
				if rand == 1 then
					minetest.chat_send_player(name, "[NPC] <" .. mob_name .. "> Stop bothering me!")
					self.object:remove()
				elseif rand == 2 then
					minetest.chat_send_player(name, "[NPC] <" .. mob_name .. "> Are you mocking me? I don't take kindly to mockers!")
					do_attack(clicker)
				elseif rand == 3 then
					minetest.chat_send_player(name, "[NPC] <" .. mob_name .. "> You're joking, right? Oh, you're serious? Well, to let you know, I won't be working for you for that pitiful amount.")
				else
					minetest.chat_send_player(name, "[NPC] <" .. mob_name .. "> Do you really think I'll work for you for that much?!")
				end
			end
		end
	
	--else
	elseif not self.owner then
                if lottclasses.player_same_race_or_ally(clicker, self.race) then
                        if self.game_name == "mob" then
                                self.game_name = lottmobs[race]["names"][math.random(1, #lottmobs[race]["names"])]
                        end
                        minetest.chat_send_player(name, "[NPC] <" .. self.game_name .. "> " ..
                                                          lottmobs[race]["messages"][math.random(1, #lottmobs[race]["messages"])])
                end
	end
end

minetest.register_on_player_receive_fields(function(player, formname, fields)
	if formname == "mob_hiring" then
		if fields.done then
			if tonumber(fields.offer) then
				local n = tonumber(fields.offer)
				if n > 50 then
					n = 50
				end
				lottmobs.hire(n)
			else
				minetest.chat_send_player(player:get_player_name(), "Offer must be a number!")
			end
		end
	elseif formname == "mob_naming" then
		lottmobs.name(fields.naming)
	elseif formname == "mob_settings" then
		lottmobs.change_settings(fields)
	end
end)

lottmobs.register_guard_craftitem = function(name, description, inventory_image)
        minetest.register_craftitem(name, {
                                            description = description,
                                            inventory_image = inventory_image,
                                            on_place = function(itemstack, placer, pointed_thing)
                                                    if pointed_thing.above then
                                                            local owner = placer:get_player_name()
                                                            if not lottmobs.player_guards[owner] then
                                                                    lottmobs.player_guards[owner] = {}
                                                            end
                                                            local add_guard = function(game_name)
                                                                    local pos = pointed_thing.above
                                                                    pos.y = pos.y + 1
                                                                    if not minetest.settings:get_bool("creative_mode") then
                                                                            itemstack:take_item()
                                                                    end
                                                                    local obj = minetest.add_entity(pos, name):get_luaentity()
                                                                    obj.game_name = game_name
                                                                    obj.nametag = game_name
                                                                    update_tag(obj)
                                                                    obj.tamed = true
                                                                    obj.owner = owner
                                                                    obj.order = "follow"
                                                                    obj.eat_timer = 0
                                                                    obj.food_level = 20
                                                                    return obj
                                                            end
                                                            lottmobs.name = function(name)
                                                                    if name and name ~= "" and not lottmobs.player_guards[owner][name] then
                                                                            local obj = add_guard(name)
                                                                            lottmobs.player_guards[owner][name] = {food_level = 20, health = obj.health, eat_timer = 0, timer = 0, last_active_health = obj.health}
                                                                            lottmobs.save_guard_hunger()
                                                                    else
                                                                            minetest.show_formspec(owner, "mob_naming", "field[naming;Name your guard:;")
                                                                    end
                                                            end
                                                            minetest.show_formspec(owner, "mob_naming", "field[naming;Name your guard:;")
                                                    end
                                                    return itemstack
                                            end
        })
end










-- Rod of Defense summoning and teleporting

-- Guardians are described in the Book of Minions (craftable)


lottmobs.new_minion = function(player, display_name, entity, position, self)
	
	local random_name = math.random(1000000)
	
	if lottmobs.player_guards[player] == nil then
		
		-- There's no guard, so make a new one
		
		lottmobs.player_guards[player] = {}
	
		local obj = minetest.add_entity(position, entity):get_luaentity()
		
		obj.game_name = random_name
		obj.nametag = display_name
		obj.update_tag(obj)
		
		obj.eat_timer = 0
		obj.food_level = 20
		--obj.lifetimer = 10
		
		obj.owner = player
		obj.guard = 1
		obj.tamed = true
		
		lottmobs.player_guards[player][random_name] = {
			food_level = 10,
			health = obj.health,
			eat_timer = 0,
			timer = 0,
			last_active_health = obj.health
		}
		
		lottmobs.save_guard_hunger()
		
		minetest.sound_play("rod_of_defense_summon", {gain = .5, position, to_player = player})
	
	else
		
		-- There is already a summoned minion, teleport it to you or remove
		-- Works best with "remove far mobs" set to DISABLED
		
		local nearby = false
		local count = 0

		for id, entity in pairs(minetest.luaentities) do
			
			if entity.owner == player then
				
				count = count + 1
				
				-- Found an entity, make sure it's in the player_guards database too
				
				local lua_name = entity.game_name
				
				if lottmobs.player_guards[player][lua_name] then
			
					entity.object:setpos(position)
					nearby = true
					minetest.sound_play("rod_of_defense_teleport", {gain = .5, position, to_player = player})
						
				else
					
					entity.object:remove()
					
					--lottmobs.player_guards[player] = nil
					--lottmobs.save_guard_hunger()
					
				end
			end
		end
		
		if nearby == false then
			
			lottmobs.player_guards[player] = nil
			lottmobs.save_guard_hunger()
			
			minetest.sound_play("rod_of_defense_unsummon", {gain = .5, position, to_player = player})
		end
		
	end
end


--[[

default.explode = function(pos, time, radius, damage, node)
	minetest.after(time, function(pos)
		if node then
			if minetest.get_node(pos).name ~= node then
				return
			end
		end
		minetest.sound_play("default_explode", {pos=pos, gain=1.5, max_hear_distance=2*64})
		--minetest.set_node(pos, {name="default:lava_source"})

		local objects = minetest.get_objects_inside_radius(pos, radius * 2)
		for _,obj in ipairs(objects) do
			if obj:is_player() or (obj:get_luaentity() and obj:get_luaentity().name ~= "__builtin:item") then
				local obj_p = obj:get_pos()
				local vec = {x=obj_p.x-pos.x, y=obj_p.y-pos.y, z=obj_p.z-pos.z}
				local dist = (vec.x^2+vec.y^2+vec.z^2)^0.5
				local damage = damage or (80*0.5^dist)*2
				obj:punch(obj, 1.0, {
					full_punch_interval=1.0,
					damage_groups={fleshy=damage},
				}, vec)
			end
		end

		local pr = PseudoRandom(os.time())
		for dx = -radius, radius do
		for dy = radius, -radius, -1 do
		for dz = -radius, radius do

			pos.x = pos.x+dx
			pos.y = pos.y+dy
			pos.z = pos.z+dz

			local r = vector.length(vector.new(dx, dy, dz))
			local node =  minetest.get_node(pos)
			if (radius * radius) / (r * r) >= (pr:next(80, 125) / 100) then
			--and not minetest.is_protected(pos) then
				destroy(pos, radius)
			end

			pos.x = pos.x-dx
			pos.y = pos.y-dy
			pos.z = pos.z-dz
		end
		end
		end

		minetest.add_particlespawner(
			100,
			0.1,
			{x=pos.x-3, y=pos.y-3, z=pos.z-3},
			{x=pos.x+3, y=pos.y+3, z=pos.z+3},
			{x=-0, y=-0, z=-0},
			{x=0, y=0, z=0},
			{x=-0.5,y=5,z=-0.5},
			{x=0.5,y=5,z=0.5},
			0.1,
			1,
			8,
			15,
			false,
			"tnt_smoke.png"
		)
	end, pos)
end

]]
















-- Grond explosion, requires some skill because you have to time/aim it!  What fun :D

default.explode_weapon = function(pos, time, radius, damage, node)
	minetest.after(time, function(pos)
		if node then
			if minetest.get_node(pos).name ~= node then
				return
			end
		end
		
		minetest.sound_play("default_explode", {pos=pos, gain=.5, max_hear_distance=30})
		--minetest.set_node(pos, {name="default:lava_source"})

		local objects = minetest.get_objects_inside_radius(pos, radius * 2)
		
		for _,obj in ipairs(objects) do
			if obj:is_player() then
				local obj_p = obj:get_pos()
				local vec = {x=obj_p.x-pos.x, y=obj_p.y-pos.y, z=obj_p.z-pos.z}
				local damage = damage
				
				
				
				if playereffects.has_effect_type(obj:get_player_name(), "damage_shield") then
					damage = 0
					playereffects.cancel_effect_type("damage_shield", cancel_all, obj:get_player_name())
					minetest.sound_play("shieldbreak", { object = obj, max_hear_distance = 25, gain = .4 }, true)
				else
				
				
					obj:punch(obj, 1.0, {
						full_punch_interval=1.0,
						damage_groups={fleshy=damage},
					}, vec)
					
					
				end
				
				
				
			elseif obj:get_luaentity() and obj:get_luaentity().name ~= "__builtin:item" then
				local obj_p = obj:get_pos()
				local vec = {x=obj_p.x-pos.x, y=obj_p.y-pos.y, z=obj_p.z-pos.z}
				local damage = damage * 3 --Triple damage for mobs!
				obj:punch(obj, 1.0, {
					full_punch_interval=1.0,
					damage_groups={fleshy=damage},
				}, vec)
			end
		end
		
		minetest.add_particlespawner{
					amount = 100,
					time = 0.1,
					minpos = {x=pos.x-3, y=pos.y-3, z=pos.z-3},
					maxpos = {x=pos.x+3, y=pos.y+3, z=pos.z+3},
					minvel = {x=-0, y=-0, z=-0},
					maxvel = {x=0, y=0, z=0},
					minacc = {x=-0.5,y=5,z=-0.5},
					maxacc = {x=0.5,y=5,z=0.5},
					minexptime = 0.1,
					maxexptime = 1,
					minsize = 8,
					maxsize = 15,
					collisiondetection = false,
					texture = "tnt_smoke.png"
				}
	end, pos)
end





default.saruman_explode = function(pos, time, radius, damage, node)
	minetest.after(time, function(pos)
		if node then
			if minetest.get_node(pos).name ~= node then
				return
			end
		end
		
		minetest.sound_play("saruman_explosion", {pos=pos, gain=.4, max_hear_distance = 30})
		--minetest.set_node(pos, {name="default:lava_source"})

		local objects = minetest.get_objects_inside_radius(pos, radius * 2)
		
		for _,obj in ipairs(objects) do
			if obj:is_player() then
				local obj_p = obj:get_pos()
				local vec = {x=obj_p.x-pos.x, y=obj_p.y-pos.y, z=obj_p.z-pos.z}
				local damage = damage
				
				
				
				
				if playereffects.has_effect_type(obj:get_player_name(), "damage_shield") then
					damage = 0
					playereffects.cancel_effect_type("damage_shield", cancel_all, obj:get_player_name())
					minetest.sound_play("shieldbreak", { object = obj, max_hear_distance = 25, gain = .4 }, true)
				else
					obj:punch(obj, 1.0, {
						full_punch_interval=1.0,
						damage_groups={fleshy=damage},
					}, vec)
				end
				
				
				
				
			elseif obj:get_luaentity() 
			and obj:get_luaentity().name ~= "__builtin:item"
			and obj:get_luaentity().name ~= "lottmobs:saruman" then
				local obj_p = obj:get_pos()
				local vec = {x=obj_p.x-pos.x, y=obj_p.y-pos.y, z=obj_p.z-pos.z}
				local damage = damage * 3 --Triple damage for mobs!
				obj:punch(obj, 1.0, {
					full_punch_interval=1.0,
					damage_groups={fleshy=damage},
				}, vec)
			end
		end
		
		minetest.add_particlespawner{
					amount = 100,
					time = 0.1,
					minpos = {x=pos.x-3, y=pos.y-3, z=pos.z-3},
					maxpos = {x=pos.x+3, y=pos.y+3, z=pos.z+3},
					minvel = {x=-0, y=-0, z=-0},
					maxvel = {x=0, y=0, z=0},
					minacc = {x=-0.5,y=5,z=-0.5},
					maxacc = {x=0.5,y=5,z=0.5},
					minexptime = 0.1,
					maxexptime = 1,
					minsize = 6,
					maxsize = 10,
					collisiondetection = false,
					texture = "lottother_whitegem_ore.png"
				}
	end, pos)
end









-- Sting explosion
-- Changed to make sure angled beams not hitting *players* twice

default.explode_sting = function(pos, time, radius, damage, node)
	minetest.after(time, function(pos)
		if node then
			if minetest.get_node(pos).name ~= node then
				return
			end
		end

		local objects = minetest.get_objects_inside_radius(pos, radius)
		local damaged_players = {}
		
		for _,obj in ipairs(objects) do
		
			if obj:is_player() then
				
				local name = obj:get_player_name()
				local already_damaged = 0
				
				for _,v in ipairs(damaged_players) do
								
					if v == name then
						already_damaged = 1
					end
				end
				
				
				if already_damaged == 0 then
					
					table.insert(damaged_players, name)
					
					local obj_p = obj:get_pos()
					local vec = {x=obj_p.x-pos.x, y=obj_p.y-pos.y, z=obj_p.z-pos.z}
					local damage = damage
					
					
					
					
					if playereffects.has_effect_type(name, "damage_shield") then
						damage = 0
						playereffects.cancel_effect_type("damage_shield", cancel_all, name)
						minetest.sound_play("shieldbreak", { object = obj, max_hear_distance = 25, gain = .4 }, true)
					else
					
						obj:punch(obj, 1.0, {
							full_punch_interval=1.0,
							damage_groups={fleshy=damage},
						}, vec)
					end
					
					
					
					
					
				end
			
				
			elseif obj:get_luaentity() and obj:get_luaentity().name ~= "__builtin:item" then
				
				local obj_p = obj:get_pos()
				local vec = {x=obj_p.x-pos.x, y=obj_p.y-pos.y, z=obj_p.z-pos.z}
				local damage = damage * 3 --Triple damage for mobs!
				
				obj:punch(obj, 1.0, {
					full_punch_interval=1.0,
					damage_groups={fleshy=damage},
				}, vec)
			end
		end
		
		minetest.add_particlespawner{
					amount = 4,
					time = 0.1,
					minpos = {x=pos.x, y=pos.y, z=pos.z},
					maxpos = {x=pos.x, y=pos.y, z=pos.z},
					minvel = {x=-0, y=-0, z=-0},
					maxvel = {x=0, y=0, z=0},
					minacc = {x=-0.5,y=5,z=-0.5},
					maxacc = {x=0.5,y=5,z=0.5},
					minexptime = 0.1,
					maxexptime = 1,
					minsize = 1,
					maxsize = 2,
					collisiondetection = false,
					texture = "hyruletools_yellowstar.png"
				}
	end, pos)
end


default.doom_beam = function(pos, time, radius, duration, damage)
	minetest.after(time, function(pos)

		local objects = minetest.get_objects_inside_radius(pos, radius)
		
		for _,obj in ipairs(objects) do
			if obj:is_player() then
				
				playereffects.apply_effect_type("blind", duration, obj)
				playereffects.apply_effect_type("paralyze", duration, obj)
				
				
			elseif obj:get_luaentity() and obj:get_luaentity().name ~= "__builtin:item" then
				local obj_p = obj:get_pos()
				local vec = {x=obj_p.x-pos.x, y=obj_p.y-pos.y, z=obj_p.z-pos.z}
				
				obj:punch(obj, 1.0, {
					full_punch_interval=1.0,
					damage_groups={fleshy=damage},
				}, vec)
			end
		end
		
		minetest.add_particlespawner{
					amount = 5,
					time = 2,
					minpos = {x=pos.x-1, y=pos.y-1, z=pos.z-1},
					maxpos = {x=pos.x+1, y=pos.y+1, z=pos.z+1},
					minvel = {x=-0, y=-0, z=-0},
					maxvel = {x=0, y=0, z=0},
					minacc = {x=0,y=0,z=0},
					maxacc = {x=1,y=1,z=1},
					minexptime = 1,
					maxexptime = 2,
					minsize = 2,
					maxsize = 4,
					collisiondetection = false,
					texture = "web_black.png"
				}
	end, pos)
end





