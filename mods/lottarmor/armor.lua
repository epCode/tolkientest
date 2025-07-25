-- Global Defaults - use armor.conf to override these

lottarmor = {}

ARMOR_INIT_DELAY = 1
ARMOR_INIT_TIMES = 1
ARMOR_BONES_DELAY = 1
ARMOR_UPDATE_TIME = 2
ARMOR_DROP = minetest.get_modpath("bones") ~= nil
ARMOR_DESTROY = false
ARMOR_LEVEL_MULTIPLIER = 1
ARMOR_HEAL_MULTIPLIER = 1
ARMOR_MATERIALS = {
	wood = "group:wood",
	cactus = "default:cactus",
	steel = "default:steel_ingot",
	bronze = "default:bronze_ingot",
	diamond = "default:diamond",
	gold = "default:gold_ingot",
}


ARMOR_FIRE_NODES = {
	{"default:lava_source",     1, 4},
	{"default:lava_flowing",    1, 4},
	{"fire:basic_flame",        1, 4},
	
	{"lottother:blue_flame",        1, 4},
	{"lottother:purple_flame",        1, 4},
	{"lottother:green_flame",        1, 4},
	{"lottother:red_flame",        1, 4},
	{"lottother:orange_flame",        1, 4},
	
	{"default:torch",           1, 1},
}







function lottarmor.get_upgrades(player)
	local upgrades = {light = 0, damage = 0, aff = 0, affs = {}, eff = {}}
	return upgrades
end




-- Load Armor Configs

local modpath = minetest.get_modpath("lottarmor")
local worldpath = minetest.get_worldpath()
local input = io.open(modpath.."/armor.conf", "r")
if input then
	dofile(modpath.."/armor.conf")
	input:close()
	input = nil
end
input = io.open(worldpath.."/armor.conf", "r")
if input then
	dofile(worldpath.."/armor.conf")
	input:close()
	input = nil
end



-- Armor API

local inv_mod = nil
local time = 0

gui_bg_img = "background[5,5;1,1;gui_formbg.png;true]"
gui_slots = "listcolors[#606060AA;#606060;#141318;#30434C;#FFF]"

armor = {
	timer = 0,
	player_hp = {},
	elements = {"head", "torso", "legs", "feet"},
	physics = {"jump","speed","gravity"},
	formspec = "size[8,8.5]"
		..gui_bg_img
		..gui_slots
		.."image[0,0;1,1;lottarmor_helmet.png]"
		.."image[0,1;1,1;lottarmor_chestplate.png]"
		.."image[0,2;1,1;lottarmor_leggings.png]"
		.."image[0,3;1,1;lottarmor_boots.png]"
		.."image[3,0;1,1;lottarmor_helmet.png]"
		.."image[3,1;1,1;lottarmor_shirt.png]"
		.."image[3,2;1,1;lottarmor_trousers.png]"
		.."image[3,3;1,1;lottarmor_shoes.png]"
		.."image[4,0;1,1;lottarmor_cloak.png]"
		.."list[detached:player_name_armor;armor;0,0;1,4;]"
		--.."list[detached:player_name_armor;armor;2,2;1,1;4]"
		.."list[detached:player_name_clothing;clothing;3,0;1,4;]"
		.."list[detached:player_name_clothing;clothing;4,0;1,1;4]"
		.."image[1,7.5;1,1;ad_a_sword.png]"
		.."image[2,7.5;1,1;ad_a_shield.png]"
		.."image[3,7.5;1,1;ad_ring.png]"
		.."image[4,7.5;1,1;ad_ring.png]"
		.."image[5,7.5;1,1;ad_a_light.png]"
		.."image[6,7.5;1,1;ad_a_food.png]"
		.."list[detached:player_name_armor;armor;1,7.5;5,1;5]"
		.."list[current_player;main;6,7.5;1,1;5]"
		.."image_button[7,7.5;1,1;ad_sound.png;toggle_sound;]"
		.."image[1.16,0.25;2,4;armor_preview]"
		--.."image[2,2;1,1;lottarmor_shield.png]"
		.."list[current_player;main;0,4.25;8,1;6]"
		.."list[current_player;main;0,5.5;8,3;14]"
		.."image[5.05,0;3.5,1;lottarmor_crafting.png]"
		.."list[current_player;craft;4,1;3,3;]"
		.."list[current_player;craftpreview;7,2;1,1;]"
		.."listring[current_player;main]"
		.."listring[current_player;craft]"
		.."image[7,3;1,1;lottarmor_trash.png]"
		.."list[detached:armor_trash;main;7,3;1,1;]"
		.."image_button[7,1;1,1;bags.png;bags;]",
	textures = {},
	def = {state=0, count = 0},
	version = "0.4.4",
}

if minetest.settings:get_bool("creative_mode") then
	armor.formspec = armor.formspec .. "tabheader[-0.12,-0.12;creative_tabs;Main,Creative;1;true;false"
end

local get_formspec = function(player,page)
	if page=="bags" then
		return "size[8,7.5]"
			.."list[current_player;main;0,3.5;8,4;]"
			.."button[0,0;2,0.5;main;Back]"
			.."button[0,2;2,0.5;bag1;Bag 1]"
			.."button[2,2;2,0.5;bag2;Bag 2]"
			.."button[4,2;2,0.5;bag3;Bag 3]"
			.."button[6,2;2,0.5;bag4;Bag 4]"
			.."list[detached:"..player:get_player_name().."_bags;bag1;0.5,1;1,1;]"
			.."list[detached:"..player:get_player_name().."_bags;bag2;2.5,1;1,1;]"
			.."list[detached:"..player:get_player_name().."_bags;bag3;4.5,1;1,1;]"
			.."list[detached:"..player:get_player_name().."_bags;bag4;6.5,1;1,1;]"
               .."background[5,5;1,1;gui_formbg.png;true]"
	end
	for i=1,4 do
		if page=="bag"..i then
			local image = player:get_inventory():get_stack("bag"..i, 1):get_definition().inventory_image
			return "size[8,10.5]"
				.."list[current_player;main;0,6.5;8,4;]"
				.."button[0,0;2,0.5;main;Main]"
				.."button[2,0;2,0.5;bags;Bags]"
				.."image[7,0;1,1;"..image.."]"
				.."list[current_player;bag"..i.."contents;0,1;8,5;]"
				.."listring[]"
                .."background[5,5;1,1;gui_formbg.png;true]"
		end
	end
end



--- Bags
minetest.register_on_player_receive_fields(function(player, formname, fields)
	if fields.bags then
		inventory_plus.set_inventory_formspec(player, get_formspec(player,"bags"))
		return
	end
	for i=1,4 do
		local page = "bag"..i
		if fields[page] then
			if player:get_inventory():get_stack(page, 1):get_definition().groups.bagslots==nil then
				page = "bags"
			end
			inventory_plus.set_inventory_formspec(player, get_formspec(player,page))
			return
		end
	end
end)



--Trash
local trash = minetest.create_detached_inventory("armor_trash", {
	allow_put = function(inv, listname, index, stack, player)
		return stack:get_count()
	end,
	on_put = function(inv, listname, index, stack, player)
		inv:set_stack(listname, index, "")
	end,
})
trash:set_size("main", 1)



armor.update_player_visuals = function(self, player)
	multiskin:update_player_visuals(player)
end





armor.set_player_armor = function(self, player)
	
	local name, player_inv = armor:get_valid_player(player, "[set_player_armor]")
	if not name then
		return
	end
	
	local armor_texture = "lottarmor_trans.png"
	local armor_level = 0
	local armor_heal = 0
	local armor_fire = 0
	
	local state = 0
	local items = 0
	local elements = {}
	local textures = {}
	local physics_o = {speed=1,gravity=1,jump=1}
	local preview = multiskin:get_preview(name) or "character_preview.png"
	
	
	
	
	
    local narya = false
    local nenya = false
    --local nenya_num = math.random(2)
    local dwarf_set_items = 0
    
    
    
    
    local player_race = ""
    local player_privs = minetest.get_player_privs(name)
    
    if player_privs.GAMEelf then
    	player_race = "elf"
    elseif player_privs.GAMEdwarf then
    	player_race = "dwarf"
    elseif player_privs.GAMEman then
    	player_race = "man"
    elseif player_privs.GAMEorc then
    	player_race = "orc"
    elseif player_privs.GAMEhobbit then
    	player_race = "hobbit"
    end
    
    if player_privs.GAMEwizard then
    	player_race = "wizard"
    end
	
	
	for _,v in ipairs(self.elements) do
		elements[v] = false
	end
	
	
	
	
	for i = 1, 10 do
		
		local stack = player_inv:get_stack("armor", i)
		local item = stack:get_name()
		
		
		if stack:get_count() == 1 then
			
			local def = stack:get_definition()
			
			for k, v in pairs(elements) do
				if v == false then
					local level = def.groups["armor_"..k]

					if level and not def.groups["clothes"] then
						
						
						-- Different textures for special items
						
						local texture = ""
						
						
						if item == "lottother:nenya" then
							
							--texture = "lottother_nenya_shield.png"
							texture = "lottother_nenya.png"
							table.insert(textures, texture)
							
							preview = preview .. "^lottother_nenya_preview.png"
							
						elseif item == "lottother:narya" then
							
							if player_race == "elf" then
								texture = "lottarmor_chestplate_elf.png^lottother_narya.png"
							elseif player_race == "dwarf" then
								texture = "lottarmor_chestplate_dwarf.png^lottother_narya.png"
							elseif player_race == "wizard" then
								texture = "lottarmor_chestplate_dwarf.png^lottother_narya.png"
							else
								texture = "lottarmor_chestplate_gondor.png^lottother_narya.png"
							end
							
							table.insert(textures, texture)
							preview = preview .. "^lottother_narya_preview.png"
							
						elseif item == "lottarmor:boots_dwarf" then
							
							dwarf_set_items = dwarf_set_items + 1
							
							if player_race == "elf" then
								texture = "lottarmor_boots_elf.png"
							elseif player_race == "dwarf" then
								texture = "lottarmor_boots_dwarf.png"
							elseif player_race == "wizard" then
								texture = "lottarmor_boots_dwarf.png"
							else
								texture = "lottarmor_boots_gondor.png"
							end
							
							table.insert(textures, texture)
							preview = preview .. "^lottarmor_boots_copper_preview.png"
							
						elseif item == "lottarmor:leggings_dwarf" then
							
							dwarf_set_items = dwarf_set_items + 1
							
							if player_race == "elf" then
								texture = "lottarmor_leggings_elf.png"
							elseif player_race == "dwarf" then
								texture = "lottarmor_leggings_dwarf.png"
							elseif player_race == "wizard" then
								texture = "lottarmor_leggings_dwarf.png"
							else
								texture = "lottarmor_leggings_gondor.png"
							end
							
							table.insert(textures, texture)
							preview = preview .. "^lottarmor_leggings_copper_preview.png"
							
							
						elseif item == "lottarmor:helmet_dwarf" then
							
							dwarf_set_items = dwarf_set_items + 1
							
							if player_race == "elf" then
								texture = "lottarmor_helmet_galvorn.png"
							elseif player_race == "dwarf" then
								texture = "lottarmor_helmet_dwarf.png"
							elseif player_race == "wizard" then
								texture = "lottarmor_helmet_dwarf.png"
							else
								texture = "lottarmor_helmet_gondor.png"
							end
							
							table.insert(textures, texture)
							preview = preview .. "^lottarmor_helmet_copper_preview.png"
							
						elseif item == "lottarmor:boots_ranger" then
							
							texture = "lottarmor_boots_ranger.png"
							table.insert(textures, texture)
							preview = preview .. "^lottarmor_boots_ranger_preview.png"
							
							physics_o = {speed=1.4,gravity=.5,jump=1}
							
						else
							
							texture = item:gsub("%:", "_")
							table.insert(textures, texture..".png")
							preview = preview.."^"..texture.."_preview.png"
						end
						
						
						
						
						armor_level = armor_level + level
						items = items + 1
						
						state = state + stack:get_wear()
						
						
						
						local heal = def.groups["armor_heal"] or 0
						armor_heal = armor_heal + heal
						
						--local fire = def.groups["armor_fire"] or 0
						--armor_fire = armor_fire + fire
						
						for kk,vv in ipairs(self.physics) do
							local o_value = def.groups["physics_"..vv]
							if o_value then
								physics_o[vv] = physics_o[vv] + o_value
							end
						end
						
					end
				end
			end
		end
		
		
		-- Check for rings and special armor
		
		if item == "lottother:narya" then
			narya = true
			dwarf_set_items = dwarf_set_items + 1
		end
		if item == "lottother:nenya" then
			nenya = true
		end
		


	end
	
	
	--armor_level = armor_level * ARMOR_LEVEL_MULTIPLIER
	--armor_heal = armor_heal * ARMOR_HEAL_MULTIPLIER
	

	local regen = 1
	armor_fire = dwarf_set_items
	
	
	if narya == true then
		
		minetest.chat_send_player(name, minetest.colorize("Ivory", "*** Narya magically protects you from harm!"))
		
	end
	
	if nenya == true then
		minetest.chat_send_player(name, minetest.colorize("Green", "*** Nenya gives you the power to regenerate health!"))
	end
	
	
	if narya == true and nenya == true then
		
		-- Nenya & Narya is 100 armor, nothing else can add to it.
	
		armor_level = 100
		armor_heal = 10
		
		regen = 3
		
		
	elseif narya == false and nenya == true then
		
		-- This is currently the ONLY thing "armor_heal" does
		-- It must be 10 to work, because legacy code I never changed :D
		
		armor_heal = 10
		
		regen = 2
			
	elseif narya == true and nenya == false then
		
		-- Narya acts as a full set of mithril armor
		-- Adding Nenya (normally 20 shield value) increases to 100
		
		armor_level = 95
		
		regen = 2
		
	end
	
	
	local current_health = player:get_hp()
	local max_health = player:get_properties().hp_max
	
	-- Dwarf innate ability, +6 max hp
    local player_privs = minetest.get_player_privs(name)
    if player_privs.GAMEdwarf and not player_privs.GAMEwizard then
    	max_health = 26
    	minetest.chat_send_player(name, minetest.colorize("Grey", "*** You are a hardy Dwarf and have +6 hp"))
    end
    
    -- Elf innate ability, bit faster
    local player_privs = minetest.get_player_privs(name)
    if player_privs.GAMEelf and not player_privs.GAMEwizard then
    	player:set_physics_override({
    		speed = 1.1,
    		jump = 1,
			gravity = 1
		})
    	minetest.chat_send_player(name, minetest.colorize("Green", "*** You are a quick-footed Elf and travel quickly"))
    end
	
	-- Rings change MAXIMUM mana, +50 each.  Lothlorien clothing increases regen, rarely dropped by
	-- mobs throughout the world.  Code in lottclothing/clothing and lottclothing/elven
	
	-- NEW! The two armor rings also add 5 MAX HEALTH each!
	
	if regen == 3 then
		
		--mana.setregen(name, 2)
		--minetest.chat_send_player(name, "*** Your mana regeneration is doubled!")
		
		mana.setmax(name, 300)
		minetest.chat_send_player(name, minetest.colorize("Aqua", "*** Your maximum mana is increased to 300"))
		
		
		max_health = max_health + 10
		minetest.chat_send_player(name, minetest.colorize("Pink", "*** Your maximum health is increased by 10"))
		
		player:set_properties({hp_max = max_health})
    	--player:set_hp(10)
    	--player:set_attribute("hp_max", max_health)
    	hb.change_hudbar(player, "health", current_health, max_health)
		
	elseif regen == 2 then
		
		--mana.setregen(name, 1.5)
		--minetest.chat_send_player(name, "*** Your mana regeneration is increased!")
		
		mana.setmax(name, 250)
		minetest.chat_send_player(name, minetest.colorize("Aqua", "*** Your maximum mana is increased to 250"))
		minetest.chat_send_player(name, minetest.colorize("Pink", "*** Your maximum health is increased by 5"))
		
		max_health = max_health + 5
		
		player:set_properties({hp_max = max_health})
    	--player:set_hp(10)
    	--player:set_attribute("hp_max", max_health)
    	hb.change_hudbar(player, "health", current_health, max_health)
	
	else
		
		--mana.setregen(name, 1)
		mana.setmax(name, 200)
		
		player:set_properties({hp_max = max_health})
    	--player:set_hp(10)
    	--player:set_attribute("hp_max", max_health)
    	hb.change_hudbar(player, "health", current_health, max_health)
	
	end
	
	
	
	if armor_fire > 0 then
		minetest.chat_send_player(name, minetest.colorize("Red", "*** You are resistant to fire!"))
		
	elseif armor_fire == 4 then
			
		minetest.chat_send_player(name, minetest.colorize("Red", "*** You are IMMUNE to fire!"))
	end
	
	
	
	
	
	

	if #textures > 0 then
		armor_texture = table.concat(textures, "^")
	end
	local armor_groups = {fleshy=100}
	
	
	
	--[[
	if armor_level > 0 then
		armor_groups.level = math.floor(armor_level / 20)
		armor_groups.fleshy = 100 - armor_level
	end
	]]
	
	-- The above made you invincible if you were at 100 armor. Changed 100 to 120
	-- 100 armor value (only obtainable using Nenya and Narya) makes you take only 1-2 damage from many attacks
	
	
	if armor_level > 0 then
		armor_groups.level = math.floor(armor_level / 20)
		armor_groups.fleshy = 120 - armor_level
	end
	
	
	player:set_armor_groups(armor_groups)
	--player:set_physics_override(physics_o)
	
	self.textures[name].armor = armor_texture
	self.textures[name].preview = preview
	
	self.def[name].state = state
	self.def[name].count = items
	self.def[name].level = armor_level
	self.def[name].heal = armor_heal
	--self.def[name].jump = physics_o.jump
	--self.def[name].speed = physics_o.speed
	--self.def[name].gravity = physics_o.gravity
	self.def[name].fire = armor_fire
	
	
	multiskin[name].armor = armor_texture
	multiskin:update_player_visuals(player)

end




armor.update_armor = function(self, player)
	local name, player_inv, armor_inv, pos = armor:get_valid_player(player, "[update_armor]")
	if not name then
		return
	end
	
	
	local hp = player:get_hp() or 0
	
	pos.y = pos.y + 1.4 -- head level
	local node_head = minetest.get_node(pos).name
	pos.y = pos.y - 1.2 -- feet level
	local node_feet = minetest.get_node(pos).name
	-- is player inside a hot node?
	for _, row in ipairs(ARMOR_FIRE_NODES) do
		-- check for fire protection, if not enough then get hurt
		
		if row[1] == node_head or row[1] == node_feet then
			
			if hp > 0 and self.def[name].fire < row[3] then
				hp = hp - ( row[3] - self.def[name].fire )
				player:set_hp(hp)
				break
			end			
		end
	end


	
	
	
	if hp <= 0 or hp == self.player_hp[name] then
		return
	end

	if self.player_hp[name] > hp then
		local heal_max = 0
		local state = 0
		local items = 0
		for i = 1, 10 do
			local stack = player_inv:get_stack("armor", i)
			if stack:get_count() > 0 then
				local clothes = stack:get_definition().groups["clothes"] or 0
				local use = stack:get_definition().groups["armor_use"] or 0
				local heal = stack:get_definition().groups["armor_heal"] or 0
				local item = stack:get_name()
				stack:add_wear(use)
				armor_inv:set_stack("armor", i, stack)
				player_inv:set_stack("armor", i, stack)
				state = state + stack:get_wear()
				if clothes ~= 1 then
					items = items + 1
				end
				if stack:get_count() == 0 then
					local desc = minetest.registered_items[item].description
					if desc then
						minetest.chat_send_player(name, "Your "..desc.." got destroyed!")
					end
					self:set_player_armor(player)
					armor:update_inventory(player)
				end
				heal_max = heal_max + heal


				
				-- Check for health regen
				
				local max_health = player:get_properties().hp_max
				
                if hp < max_health and heal == 10 then
                    playereffects.apply_effect_type("regen", 20, player)
                    
                    local pos = player:get_pos()
                    effect({x = pos.x, y = pos.y + 1, z = pos.z}, 10, "heart.png", 1, 6)
                    --minetest.chat_send_player(name, "Nenya heals and nourishes you!")
                end






			end
		end
		self.def[name].state = state
		self.def[name].count = items
		
		
		
		--[[
		heal_max = heal_max * ARMOR_HEAL_MULTIPLIER
		if heal_max > math.random(100) then
			player:set_hp(self.player_hp[name])
			return
		end
		]]--
		
		
	end
	self.player_hp[name] = hp
end

armor.get_armor_formspec = function(self, name)
	if not armor.textures[name] then
		minetest.log("error", "lottarmor: Player texture["..name.."] is nil [get_armor_formspec]")
		return ""
	end
	if not armor.def[name] then
		minetest.log("error", "lottarmor: Armor def["..name.."] is nil [get_armor_formspec]")
		return ""
	end
	local formspec = armor.formspec:gsub("player_name", name)
	formspec = formspec:gsub("armor_preview", armor.textures[name].preview)
	formspec = formspec:gsub("armor_level", armor.def[name].level)
	formspec = formspec:gsub("armor_heal", armor.def[name].heal)
	formspec = formspec:gsub("armor_fire", armor.def[name].fire)
	return formspec
end

armor.update_inventory = function(self, player)
	local name = armor:get_valid_player(player, "[set_player_armor]")
	if not name or inv_mod == "inventory_enhanced" then
		return
	end
	if inv_mod == "unified_inventory" then
		if unified_inventory.current_page[name] == "armor" then
			unified_inventory.set_inventory_formspec(player, "armor")
		end
	else
		local formspec = armor:get_armor_formspec(name)
		if inv_mod == "inventory_plus" then
			local page = player:get_inventory_formspec()
			if page:find("detached:"..name.."_armor") then
				inventory_plus.set_inventory_formspec(player, formspec)
			end
		else
			player:set_inventory_formspec(formspec)
		end
	end
end

armor.get_valid_player = function(self, player, msg)
	msg = msg or ""
	if not player then
		minetest.log("error", "lottarmor: Player reference is nil "..msg)
		return
	end
	local name = player:get_player_name()
	if not name then
		minetest.log("error", "lottarmor: Player name is nil "..msg)
		return
	end
	local pos = player:get_pos()
	local player_inv = player:get_inventory()
	local armor_inv = minetest.get_inventory({type="detached", name=name.."_armor"})
	if not pos then
		minetest.log("error", "lottarmor: Player position is nil "..msg)
		return
	elseif not player_inv then
		minetest.log("error", "lottarmor: Player inventory is nil "..msg)
		return
	elseif not armor_inv then
		minetest.log("error", "lottarmor: Detached armor inventory is nil "..msg)
		return
	end
	return name, player_inv, armor_inv, pos
end

-- Register Callbacks

minetest.register_on_player_receive_fields(function(player, formname, fields)
	local name = armor:get_valid_player(player, "[on_player_receive_fields]")
	if not name or inv_mod == "inventory_enhanced" then
		return
	end
	if inv_mod == "inventory_plus" and fields.armor then
		local formspec = armor:get_armor_formspec(name)
		inventory_plus.set_inventory_formspec(player, formspec)
		return
	end
end)

minetest.register_on_joinplayer(function(player)
	multiskin:init(player)
	local name = player:get_player_name()
	local player_inv = player:get_inventory()
	player_inv:set_size("main", 22)
	player:hud_set_hotbar_itemcount(6)
	--player:hud_set_flags({hotbar = false})
	local armor_inv = minetest.create_detached_inventory(name.."_armor", {
		on_put = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, stack)
			armor:set_player_armor(player)
			armor:update_inventory(player)
			lottachievements.equip(stack, player, 1)
		end,
		on_take = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, nil)
			armor:set_player_armor(player)
			armor:update_inventory(player)
			lottachievements.equip(stack, player, -1)
		end,
		on_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			local plaver_inv = player:get_inventory()
			local stack = inv:get_stack(to_list, to_index)
			player_inv:set_stack(to_list, to_index, stack)
			player_inv:set_stack(from_list, from_index, nil)
			armor:set_player_armor(player)
			armor:update_inventory(player)
		end,
		allow_put = function(inv, listname, index, stack, player)
			local pinv = player:get_inventory()
			local tk = stack:get_tool_capabilities()
			if index == 1 then
				if stack:get_definition().groups.armor_head == nil then
					return 0
				else
					pinv:set_stack("main", index-5, stack)
					return 1
				end
			elseif index == 2 then
				if stack:get_definition().groups.armor_torso == nil then
					return 0
				else
					pinv:set_stack("main", index-5, stack)
					return 1
				end
			elseif index == 3 then
				if stack:get_definition().groups.armor_legs == nil then
					return 0
				else
					pinv:set_stack("main", index-5, stack)
					return 1
				end
			elseif index == 4 then
				if stack:get_definition().groups.armor_feet == nil then
					return 0
				else
					pinv:set_stack("main", index-5, stack)
					return 1
				end
			elseif index == 5 then
				if stack:get_definition().groups.armor_shield == nil then
					return 0
				else
					pinv:set_stack("main", index-5, stack)
					return 1
				end
			elseif index == 6 then
				if stack:get_definition().groups.armor_weapon == nil and tk.damage_groups.fleshy == nil then
					return 0
				else
					pinv:set_stack("main", index-5, stack)
					return 1
				end
			elseif index == 7 then
				if stack:get_definition().groups.armor_shield == nil then
					return 0
				else
					pinv:set_stack("main", index-5, stack)
					return 1
				end
			elseif index == 8 then
				if stack:get_definition().groups.armor_ring == nil then
					return 0
				else
					pinv:set_stack("main", index-5, stack)
					return 1
				end
			elseif index == 9 then
				if stack:get_definition().groups.armor_ring == nil then
					return 0
				else
					pinv:set_stack("main", index-5, stack)
					return 1
				end
			elseif index == 10 then
				if stack:get_definition().groups.light_source == nil then
					return 0
				else
					pinv:set_stack("main", index-5, stack)
					return 1
				end
			end
		end,
		allow_take = function(inv, listname, index, stack, player)
			local pinv = player:get_inventory()
			
			--pinv:set_stack("main", index-5, "lottarmor:placeholder")
			return stack:get_count()
		end,
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			return 0
		end,
	}, name)
	if inv_mod == "inventory_plus" then
		inventory_plus.register_button(player,"armor", "Armor")
	end
	armor_inv:set_size("armor", 10)
	player_inv:set_size("armor", 10)
	for i = 1, 10 do
		local stack = player_inv:get_stack("armor", i)
		armor_inv:set_stack("armor", i, stack)
	end
	for i = 1, 5 do
		local stack = player_inv:get_stack("armor", i+5)
		if stack:get_name() == "" then
			player_inv:set_stack("main", i, ItemStack("lottarmor:placeholder"))
		end
	end

	--Bags
	local name = player:get_player_name()
     local bags_inv = minetest.create_detached_inventory(name.."_bags",{
		on_put = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, stack)
			player:get_inventory():set_size(listname.."contents", stack:get_definition().groups.bagslots)
		end,
		on_take = function(inv, listname, index, stack, player)
			player:get_inventory():set_stack(listname, index, nil)
		end,
		allow_put = function(inv, listname, index, stack, player)
			if stack:get_definition().groups.bagslots then
				return 1
			else
				return 0
			end
		end,
		allow_take = function(inv, listname, index, stack, player)
			if player:get_inventory():is_empty(listname.."contents")==true then
				return stack:get_count()
			else
				return 0
			end
		end,
		allow_move = function(inv, from_list, from_index, to_list, to_index, count, player)
			return 0
		end,
	}, name)
	for i=1,4 do
		local bag = "bag"..i
		player_inv:set_size(bag, 1)
		bags_inv:set_size(bag, 1)
		bags_inv:set_stack(bag,1,player_inv:get_stack(bag,1))
	end





	armor.player_hp[name] = 0
	
	
	armor.def[name] = {
		state = 0,
		count = 0,
		level = 0,
		heal = 0,
		jump = 1,
		speed = 1,
		gravity = 1,
		fire = 0,
	}
	
	armor.textures[name] = {
		armor = "lottarmor_trans.png",
		preview = "character_preview.png"
	}
	
	
	for i=1, ARMOR_INIT_TIMES do
		minetest.after(ARMOR_INIT_DELAY * i, function(player)
			armor:set_player_armor(player)
			if not inv_mod and not minetest.settings:get_bool("creative_mode") then
				armor:update_inventory(player)
			end
		end, player)
	end
end)


minetest.register_globalstep(function(dtime)
	time = time + dtime
	if time > ARMOR_UPDATE_TIME then
		for _,player in ipairs(minetest.get_connected_players()) do
			armor:update_armor(player)
		end
		time = 0
	end
end)






-- Fire Protection, added by TenPlus1.

-- override any hot nodes that do not already deal damage


--for _, row in pairs(ARMOR_FIRE_NODES) do
--	if minetest.registered_nodes[row[1]] then
--		local damage = minetest.registered_nodes[row[1]].damage_per_second
--		if not damage or damage == 0 then
--			minetest.override_item(row[1], {damage_per_second = 0})
--		end
--	end
--end









--[[

local last_punch_time = {}


	minetest.register_globalstep(function(dtime)
		armor.timer = armor.timer + dtime
		if armor.timer < 2 then
			return
		end
		for _,player in pairs(minetest.get_connected_players()) do
			local name = player:get_player_name()
			local pos = player:get_pos()
			local hp = player:get_hp()
			if not name or not pos or not hp then
				return
			end
			-- water breathing
				--if armor.def[name].water > 0 and
						--player:get_breath() < 10 then
					--player:set_breath(10)
				--end
				
				
			--[[
			-- fire protection
			local fire_damage = true
			pos.y = pos.y + 1.4 -- head level
			local node_head = minetest.get_node(pos).name
			pos.y = pos.y - 1.2 -- feet level
			local node_feet = minetest.get_node(pos).name
			-- is player inside a hot node?
			for _, row in pairs(ARMOR_FIRE_NODES) do
				-- check fire protection, if not enough then get hurt
				if row[1] == node_head or row[1] == node_feet then
					--if fire_damage == true then
						--armor:punch(player, "fire")
						last_punch_time[name] = minetest.get_gametime()
						fire_damage = false
					--end
					if hp > 0 then
						local hp_loss = row[3] - armor.def[name].fire
						if hp_loss < 0 then
							hp_loss = 0
						end
						hp = hp - hp_loss
						player:set_hp(hp)
						break
					end
				end
			end

				
				
				
				
				
			end
		armor.timer = 0
	end)

]]--











-- Effects function, taken from mobs/api.lua

function effect(pos, amount, texture, max_size, radius)

	radius = radius or 2

	minetest.add_particlespawner({
		amount = amount,
		--time = 0.25,
		time = 0.75,
		minpos = pos,
		maxpos = pos,
		minvel = {x = -radius, y = -radius, z = -radius},
		maxvel = {x = radius, y = radius, z = radius},
		minacc = {x = -radius, y = -radius, z = -radius},
		maxacc = {x = radius, y = radius, z = radius},
		minexptime = 0.1,
		maxexptime = 1,
		minsize = 0.5,
		--minsize = 1,
		maxsize = (max_size or 1),
		texture = texture,
	})
end
