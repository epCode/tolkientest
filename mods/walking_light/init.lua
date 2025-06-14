-- Totally tweaked for forked version (like many mods in here), do not use out of this subgame!

local wielding_only = false

local players = {}

minetest.register_on_joinplayer(function(mt_player)
	local name = mt_player:get_player_name()
	players[name] = {name=name,pos={x=0,y=32000,z=0},wielding=0,mt_player=mt_player}
end)

minetest.register_on_leaveplayer(function(mt_player)
	local name = mt_player:get_player_name()
	local pinfo=players[name]
	if pinfo.wielding > 0 then
		pinfo.wielding = 0
		update_light_player(pinfo)
	end
	players[name] = nil
end)

--wielding_light returns 0 for no light; 1 for regular light.  Outside of this function we don't care what's being wielded, carried or worn, just what needs to be done.
function wielding_light(pinfo)
	
	local name = pinfo.mt_player:get_player_name()
	
	if (wielding_only) then
		local wielded_item = pinfo.mt_player:get_wielded_item():get_name()
		if wielded_item == "default:torch" then
			return 1
		end
	else
        --[[
		local inv = pinfo.mt_player:get_inventory()
		if inv ~= nil then
			local hotbar=inv:get_list("main")
			for i=1,8 do
				local item = hotbar[i]:get_name()
				if item == "default:torch" then
					return 1
				end
			end
		end
		]]
		
		
		-- Check if wearing Narya and NOT invisible and NOT a rat or wraith
		
		local inv = pinfo.mt_player:get_inventory()
		
		
		--local armor = inv:get_list("armor")
		--local chest = armor[2]:get_name()
		--if chest == "lottother:narya"
		
		-- CHANGED, Narya no longer provides light
		
		if inv:contains_item("main", ItemStack("lottother:phial"))
		
		and not playereffects.has_effect_type(name, "invisible")
		and not playereffects.has_effect_type(name, "rat_polymorph")
		and not playereffects.has_effect_type(name, "troll_polymorph")
		then
			return 1
		end
		
		
		

	end
	return 0
end

function update_light_player(pinfo)
	local removes = {}
	local adds = {}
	if pinfo.wielded > 0 then
		local pos=pinfo.old_pos
		local hash = (pos.x%64)*4096 + (pos.y%64)*64 + pos.z%64
		removes[hash] = pos
	end
	
	if pinfo.wielding > 0 then
		local pos=pinfo.pos
		local hash = (pos.x%64)*4096 + (pos.y%64)*64 + pos.z%64
		removes[hash] = nil
		adds[hash] = pos
	end
	
	for h,p in pairs(adds) do
		local node = minetest.get_node_or_nil(p)
		if node == nil or (node ~= nil and node.name == "air") then
			minetest.env:set_node(p, {type="node",name="walking_light:light"})
		end
	end

	for h,p in pairs(removes) do
		local node = minetest.get_node_or_nil(p)
		if node ~= nil and node.name == "walking_light:light" then
			minetest.env:set_node(p, {type="node",name="air"})
		end
	end
end

function update_light_all(dtime)
	for name,pinfo in pairs(players) do
		local pos = pinfo.mt_player:get_pos()
		pinfo.wielded = pinfo.wielding
		pinfo.wielding = wielding_light(pinfo)
		if pos ~= nil then
			pinfo.old_pos = pinfo.pos
			pinfo.pos = {
				x=math.floor(pos.x + 0.5),
				y=math.floor(pos.y + 2.5),
				z=math.floor(pos.z + 0.5)}
			pinfo.pos_changed=(
				pinfo.old_pos.x ~= pinfo.pos.x or
				pinfo.old_pos.y ~= pinfo.pos.y or
				pinfo.old_pos.z ~= pinfo.pos.z)
		end
		players[pinfo.name] = pinfo

		if pinfo.pos_changed or (pinfo.wielded ~= pinfo.wielding) then
			update_light_player(pinfo)
		end
	end
end

minetest.register_globalstep(update_light_all)

minetest.register_node("walking_light:light", {
	drawtype = "airlike",
	tile_images = {"walking_light.png"},
	inventory_image = minetest.inventorycube("walking_light.png"),
	paramtype = "light",
	walkable = false,
	is_ground_content = true,
	--light_propagates = true,
	--sunlight_propagates = true,
	light_source = 14,
	selection_box = {
		type = "fixed",
		fixed = {0, 0, 0, 0, 0, 0},
	},
	node_box = {
		type = "fixed",
		fixed = {0, 0, 0, 0, 0, 0},
	},
})



-- I used animated textures from Hyrule, but I think it's too much graphics load?

--[[
minetest.register_abm({
	label = "Nenya Particles",
	nodenames = {"walking_light:light"},
	neighbors = {"air"},
	interval = 12,
	chance = 1,
	action = function(pos)
		--if minetest.get_node({x = pos.x, y = pos.y - 1, z = pos.z}).name == "air" then
			minetest.add_particlespawner({
				amount = 2,
				time = 12,
				minpos = {x = pos.x - 1, y = pos.y - 1, z = pos.z - 1},
				maxpos = {x = pos.x + 1, y = pos.y, z = pos.z + 1},
				minvel = {x = -0.2, y = -0.2, z = -0.2},
				maxvel = {x = 0.2, y = 0, z = 0.2},
				minacc = {x = -0.2, y = -0.2, z = -0.2},
				maxacc = {x = 0.2, y = 0, z = 0.2},
				minexptime = 1,
				maxexptime = 4,
				minsize = .5,
				maxsize = 1,
				glow = 2,
				collisiondetection = false,
				collisionremoval = false,
				vertical = false,
				texture = "hyruletools_beacon_centerb.png",
				animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 0.30},
			})
		--end
	end,
})

]]--
