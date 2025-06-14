-- eggs from mobs_dragon --------------------------------------------------------------------------
	
local dragonpairs = {
	fire = {colour="red",nest="darkage:adobe"},
	lightning = {colour="black",nest="darkage:basalt"},
	poison = {colour="green",nest="lottblocks:tree_mossy"},
	ice = {colour="blue",nest="darkage:gneiss"},
	--great = {colour="great",nest=""},
}



-- I (Ben) stole this function from ring crafting, simple check for things beneath

local function checknodes(pos, nodetype)
	for x = -1, 1 do
		for z = -1, 1 do
			local npos = {x = pos.x + x, y = pos.y - 1, z = pos.z + z}
			if minetest.get_node(npos).name == nodetype then
				
				return true
			else
				return false
			end
		end
	end
end





local function egg_transform(pos, node, clicker, item, _)
	local wield_item = clicker:get_wielded_item():get_name()
	
	if wield_item == "dmobs:dragon_gem" then
	
		local p = {x = pos.x, y = pos.y - 1, z = pos.z}
		local corner_name
		for x1 = -1,1 do
			for z1 = -1,1 do
				p.x = pos.x + x1
				p.z = pos.z + z1
				local nestfloor_name = minetest.get_node(p).name

				if x1 == -1 and z1 == -1 then
					corner_name = minetest.get_node(p).name

				elseif x1 == 0 and z1 == 0 then -- special case in centre
					
					-- must be obsidian
					if nestfloor_name ~= "default:obsidian" then return end

				else
					-- else ring must all be of the same type
					if nestfloor_name ~= corner_name then return end
				end
			end
		end
		
		local dragon_type
		for element,details in pairs(dragonpairs) do
			if corner_name == details.nest then
				dragon_type = element
				break
			end
		end
		
		minetest.chat_send_player(clicker:get_player_name(),"Something seems to be happening... come back later?")
		
		minetest.after(dmobs.eggtimer,
			function(pos, dragon, pname)
				minetest.set_node(pos, {name="dmobs:dragon_egg_"..dragon_type})
			end,
			pos
		)
		
		item:take_item()
	end
end








local function egghatch(pos, node, clicker, item, _)
	local wield_item = clicker:get_wielded_item():get_name()
	local eggnode = minetest.get_node(pos).name
	
	for nature,details in pairs(dragonpairs) do
		
		if ( wield_item == "dmobs:dragon_gem_prepared_"..nature and eggnode:find(nature) ) then
			
			if checknodes(pos, details.nest) == false then
				--minetest.chat_send_player(clicker:get_player_name(), details.nest)
				break
			else
		   
			   	minetest.chat_send_player(clicker:get_player_name(), "The dragon egg absorbs the gem!")
			   	
				minetest.after(dmobs.eggtimer,
					function(pos, dragon, pname)
						local neweggnode = minetest.get_node(pos).name
						if eggnode ~= neweggnode then return end -- prevent infinite hatchings

						minetest.remove_node(pos)

						local thedragon = "dmobs:dragon_"..details.colour
						
						--[[
						if eggnode == "dmobs:dragon_egg_great" then
							thedragon = "dmobs:dragon_great"
						end
						]]--

						local ent = minetest.add_entity(pos, thedragon)
						minetest.sound_play("dmobs_chirrup",{pos=pos,max_hear_distance=20})
						
						local obj = ent:get_luaentity()
						
						ent:set_properties({
							textures = {"dmobs_dragon_young.png"},
							visual_size = {x=.5, y=.5},
						})
						
						
						--[[
						if eggnode ~= "dmobs:dragon_egg_great" then
							ent:set_properties({
								textures = {"dmobs_dragon_young.png"},
								visual_size = {x=.5, y=.5},
							})
						end
						--]]
						
						
						obj.tamed = true
						obj.owner = clicker:get_player_name()
					end,
					pos, clicker:get_player_name()
				)
				
				
				
				item:take_item()
				break
			end
		end
	end
end

-- Egg form definitions -----------------------------------------




-- Added by Ben to "prepare" eggs using spider poison


minetest.register_craft({
	output = "dmobs:dragon_gem_prepared_fire",
	recipe = {
		{"lottmobs:spiderpoison", "lottmobs:spiderpoison", "lottmobs:spiderpoison"},
		{"lottmobs:spiderpoison", "dmobs:dragon_gem_fire", "lottmobs:spiderpoison"},
		{"lottmobs:spiderpoison", "lottmobs:spiderpoison", "lottmobs:spiderpoison"}
	}
})

minetest.register_craftitem("dmobs:dragon_gem_prepared_fire", {
	description = "Prepared Red Dragon Gem",
	inventory_image = "dmobs_gem_fire_prepared.png",
    groups = {forbidden=1},
})



minetest.register_craft({
	output = "dmobs:dragon_gem_prepared_poison",
	recipe = {
		{"lottmobs:spiderpoison", "lottmobs:spiderpoison", "lottmobs:spiderpoison"},
		{"lottmobs:spiderpoison", "dmobs:dragon_gem_poison", "lottmobs:spiderpoison"},
		{"lottmobs:spiderpoison", "lottmobs:spiderpoison", "lottmobs:spiderpoison"}
	}
})

minetest.register_craftitem("dmobs:dragon_gem_prepared_poison", {
	description = "Prepared Green Dragon Gem",
	inventory_image = "dmobs_gem_poison_prepared.png",
    groups = {forbidden=1},
})



minetest.register_craft({
	output = "dmobs:dragon_gem_prepared_ice",
	recipe = {
		{"lottmobs:spiderpoison", "lottmobs:spiderpoison", "lottmobs:spiderpoison"},
		{"lottmobs:spiderpoison", "dmobs:dragon_gem_ice", "lottmobs:spiderpoison"},
		{"lottmobs:spiderpoison", "lottmobs:spiderpoison", "lottmobs:spiderpoison"}
	}
})

minetest.register_craftitem("dmobs:dragon_gem_prepared_ice", {
	description = "Prepared Blue Dragon Gem",
	inventory_image = "dmobs_gem_ice_prepared.png",
    groups = {forbidden=1},
})


minetest.register_craft({
	output = "dmobs:dragon_gem_prepared_lightning",
	recipe = {
		{"lottmobs:spiderpoison", "lottmobs:spiderpoison", "lottmobs:spiderpoison"},
		{"lottmobs:spiderpoison", "dmobs:dragon_gem_lightning", "lottmobs:spiderpoison"},
		{"lottmobs:spiderpoison", "lottmobs:spiderpoison", "lottmobs:spiderpoison"}
	}
})

minetest.register_craftitem("dmobs:dragon_gem_prepared_lightning", {
	description = "Prepared Black Dragon Gem",
	inventory_image = "dmobs_gem_lightning_prepared.png",
    groups = {forbidden=1},
})
















local base_egg = { -- base template for all dragon eggs
	description = "Dragon Egg",
	--drawtype = "mesh",
	--mesh = "egg.b3d",
	
	drawtype = "mesh",
	mesh = "lottblocks_palantir.obj",
	
	visual_size = {x=.4, y=.4},
	
	tiles = {"dmobs_egg.png"},
	paramtype = "light",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {fleshy=3, dig_immediate=2},
	sounds = default.node_sound_leaves_defaults(),	
	on_rightclick = egg_transform,
}


--minetest.register_node("dmobs:egg", dmobs.deepclone(base_egg) ) -- clone, to not affect the base template

base_egg.groups.not_in_creative_inventory=1
base_egg.on_rightclick = egghatch

base_egg.tiles = {"dmobs_egg1.png"}
minetest.register_node("dmobs:dragon_egg_fire", dmobs.deepclone(base_egg) )

base_egg.tiles = {"dmobs_egg2.png"}
minetest.register_node("dmobs:dragon_egg_lightning", dmobs.deepclone(base_egg) )

base_egg.tiles = {"dmobs_egg3.png"}
minetest.register_node("dmobs:dragon_egg_poison", dmobs.deepclone(base_egg) )

base_egg.tiles = {"dmobs_egg4.png"}
minetest.register_node("dmobs:dragon_egg_ice", dmobs.deepclone(base_egg) )

--base_egg.groups.not_in_creative_inventory=nil
--base_egg.tiles = {"default_sandstone.png"}
--base_egg.description = "Great Dragon Egg"
--minetest.register_node("dmobs:dragon_egg_great", dmobs.deepclone(base_egg) )
