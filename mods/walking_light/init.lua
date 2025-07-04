-- Totally tweaked for forked version (like many mods in here), do not use out of this subgame!

local wielding_only = true

local players = {}

minetest.register_on_joinplayer(function(mt_player)
	local name = mt_player:get_player_name()
	players[name] = {name=name,pos={x=0,y=32000,z=0},wielding=0,mt_player=mt_player}
end)

minetest.register_on_leaveplayer(function(mt_player)
	local name = mt_player:get_player_name()
	local pinfo=players[name]
	pinfo.wielded = pinfo.wielding
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
		local wielded_item = pinfo.mt_player:get_inventory():get_stack("armor", 10):get_name()
		local def = minetest.registered_items[wielded_item]
		if def and def.light_source and def.light_source > 0 then
			return (def.real_light_source or def.light_source) + 2 --+ lottarmor.get_upgrades(pinfo.mt_player).light
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

-- large light resolution
local LLR = 50

lightaddvectors = {}

--[[
local lightaddvectors = {
	vector.new(1,0,0),
	vector.new(1,1,0),
	vector.new(1,0,1),
	vector.new(1,1,1),
	vector.new(0,1,0),
	vector.new(0,1,1),
	vector.new(0,0,1),
	vector.new(-1,0,0),
	vector.new(-1,-1,0),
	vector.new(-1,0,-1),
	vector.new(-1,-1,-1),
	vector.new(0,-1,0),
	vector.new(0,-1,-1),
	vector.new(0,0,-1),
	vector.new(1,-1,0),
	vector.new(-1,1,0),
	vector.new(1,0,-1),
	vector.new(-1,0,1),
	vector.new(1,1,-1),
	vector.new(1,-1,1),
	vector.new(-1,1,1),
	vector.new(1,-1,-1),
	vector.new(-1,-1,1),
	vector.new(-1,1,-1),
	vector.new(0,-1,1),
	vector.new(0,1,-1),
}]]

local ro = 0
local lastv
for li = 1, LLR do
	ro = ro + math.rad(math.random(100))
	local dir = core.yaw_to_dir(ro)
	dir.y = li/LLR
	lightaddvectors[li] = vector.normalize(dir)
end

local function phash(pos)
	return (pos.x%64)*4096 + (pos.y%64)*64 + pos.z%64
end

function update_light_player(pinfo)
	local removes = {}
	local adds = {}
	local old_used_poss = {}
	if pinfo.wielded > 0 then
		local pos=pinfo.old_pos
		local hash = phash(pos)
		if pinfo.wielded > 16 then
			local w = pinfo.wielded
			for i=1, w do
				for _,vec in pairs(lightaddvectors) do
					local lp = vector.add(pos, vector.multiply(vec, (i-16)))
					removes[phash(lp)] = lp
				end
			end
		end
		removes[hash] = pos
	end
	
	local used_poss = {}
	if pinfo.wielding > 0 then
		local pos=pinfo.pos
		local hash = phash(pos)
		removes[hash] = nil
		if pinfo.wielding > 16 then
			local w = pinfo.wielding
			for i=1, w do
				for _,vec in pairs(lightaddvectors) do
					local lp = vector.add(pos, vector.multiply(vec, (i-16)))

					adds[phash(lp)] = lp
				end
			end
		end
		adds[hash] = pos
	end
	

	for h,p in pairs(removes) do
		local node = minetest.get_node_or_nil(p)
		if node ~= nil and string.find(node.name, "walking_light:light_") then
			minetest.env:set_node(p, {type="node",name="air"})
		end
	end
	for h,p in pairs(adds) do
		local node = minetest.get_node_or_nil(p)
		if node == nil or (node ~= nil and node.name == "air") or (string.find(node.name, "walking_light:light_") and node.name ~= "walking_light:light_"..math.min(pinfo.wielding, 16)) then
			if pinfo.wielding > 16 then
				local dist = (vector.distance(pinfo.pos, p)/pinfo.wielding)+1
				local fadeFactor = 2 -- Adjust this value to control the fade-off rate
				local LL = math.round(math.max(1, pinfo.wielding / (dist ^ fadeFactor) * (16 / pinfo.wielding)))
				minetest.env:set_node(p, {type="node",name="walking_light:light_"..LL})
			else
				minetest.env:set_node(p, {type="node",name="walking_light:light_"..pinfo.wielding})
			end
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
				y=math.floor(pos.y + 1.5),
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

for i=1, 16 do
	minetest.register_node("walking_light:light_"..i, {
		--drawtype = "glasslike", -- for vis
		--tiles = {"ad_walking_light.png"}, -- for fix
		drawtype = "airlike",
		tile_images = {"ad_walking_light.png"},
		inventory_image = minetest.inventorycube("walking_light.png"),
		paramtype = "light",
		sunlight_propagates = true,
		use_texture_alpha = "blend",
		walkable = false,
		is_ground_content = true,
		--light_propagates = true,
		--sunlight_propagates = true,
		light_source = i,
		selection_box = {
			type = "fixed",
			fixed = {0, 0, 0, 0, 0, 0},
		},
		node_box = {
			type = "fixed",
			fixed = {0, 0, 0, 0, 0, 0},
		},
	})
end



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
