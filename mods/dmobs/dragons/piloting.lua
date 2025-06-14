
if not dmobs.dragon then
	dmobs.dragon = {}
end

dmobs.dragon.step_custom_red = function(self, dtime)
	if self.driver then
		object_fly(self, dtime, 12, true, "dmobs:fire_plyr", "walk", "stand")
		if self.state == "attack" then
			self.state = nil
		end
		return false
	end
	return true
end

dmobs.dragon.step_custom_blue = function(self, dtime)
	if self.driver then
		object_fly(self, dtime, 12, true, "dmobs:ice_plyr", "walk", "stand")
		if self.state == "attack" then
			self.state = nil
		end
		return false
	end
	return true
end

dmobs.dragon.step_custom_green = function(self, dtime)
	if self.driver then
		object_fly(self, dtime, 12, true, "dmobs:poison_plyr", "walk", "stand")
		if self.state == "attack" then
			self.state = nil
		end
		return false
	end
	return true
end

dmobs.dragon.step_custom_black = function(self, dtime)
	if self.driver then
		object_fly(self, dtime, 12, true, "dmobs:lightning_plyr", "walk", "stand")
		if self.state == "attack" then
			self.state = nil
		end
		return false
	end
	return true
end







dmobs.dragon.ride_red = function(self, clicker)
	if self.tamed and self.owner == clicker:get_player_name() then
		local inv = clicker:get_inventory()
		
		if self.driver and clicker == self.driver then
			object_detach(self, clicker, {x=1, y=0, z=1})
			
			self.object:remove()
			
			if inv:room_for_item("main", "dmobs:dragon_red") then
				inv:add_item("main", "dmobs:dragon_red")
			else
				minetest.add_item(clicker:get_pos(), "dmobs:dragon_red")
			end
			
		elseif not self.driver then
			--if clicker:get_wielded_item():get_name() == "mobs:saddle" then
				object_attach(self, clicker)
				inv:remove_item("main", "dmobs:dragon_red")
			--end
		end
	end
end

dmobs.dragon.ride_blue = function(self, clicker)
	if self.tamed and self.owner == clicker:get_player_name() then
		local inv = clicker:get_inventory()
		
		if self.driver and clicker == self.driver then
			object_detach(self, clicker, {x=1, y=0, z=1})
			
			self.object:remove()
			
			if inv:room_for_item("main", "dmobs:dragon_blue") then
				inv:add_item("main", "dmobs:dragon_blue")
			else
				minetest.add_item(clicker:get_pos(), "dmobs:dragon_blue")
			end
			
		elseif not self.driver then
			--if clicker:get_wielded_item():get_name() == "mobs:saddle" then
				object_attach(self, clicker)
				inv:remove_item("main", "dmobs:dragon_blue")
			--end
		end
	end
end

dmobs.dragon.ride_black = function(self, clicker)
	if self.tamed and self.owner == clicker:get_player_name() then
		local inv = clicker:get_inventory()
		
		if self.driver and clicker == self.driver then
			object_detach(self, clicker, {x=1, y=0, z=1})
			
			self.object:remove()
			
			if inv:room_for_item("main", "dmobs:dragon_black") then
				inv:add_item("main", "dmobs:dragon_black")
			else
				minetest.add_item(clicker:get_pos(), "dmobs:dragon_black")
			end
			
		elseif not self.driver then
			--if clicker:get_wielded_item():get_name() == "mobs:saddle" then
				object_attach(self, clicker)
				inv:remove_item("main", "dmobs:dragon_black")
			--end
		end
	end
end

dmobs.dragon.ride_green = function(self, clicker)
	if self.tamed and self.owner == clicker:get_player_name() then
		local inv = clicker:get_inventory()
		
		if self.driver and clicker == self.driver then
			object_detach(self, clicker, {x=1, y=0, z=1})
			
			self.object:remove()
			
			if inv:room_for_item("main", "dmobs:dragon_green") then
				inv:add_item("main", "dmobs:dragon_green")
			else
				minetest.add_item(clicker:get_pos(), "dmobs:dragon_green")
			end
			
		elseif not self.driver then
			--if clicker:get_wielded_item():get_name() == "mobs:saddle" then
				object_attach(self, clicker)
				inv:remove_item("main", "dmobs:dragon_green")
			--end
		end
	end
end










dmobs.dragon.on_rc = function(self, clicker)
	if not clicker or not clicker:is_player() then
		return
	end
	if mobs:feed_tame(self, clicker, 1, false, false) then
		return
	end
	dmobs.dragon.ride(self, clicker)
end





dmobs.dragon.do_custom_red = function(self, dtime)
	if self.driver then
		object_fly(self, dtime, 15, true, "dmobs:fire_plyr", "walk", "stand")
		
		if self.state == "attack" then
			self.state = "idle"
		end
		
		return false
	end
	return true
end

dmobs.dragon.do_custom_blue = function(self, dtime)
	if self.driver then
		object_fly(self, dtime, 15, true, "dmobs:ice_plyr", "walk", "stand")
		
		if self.state == "attack" then
			self.state = "idle"
		end
		
		return false
	end
	return true
end

dmobs.dragon.do_custom_green = function(self, dtime)
	if self.driver then
		object_fly(self, dtime, 15, true, "dmobs:poison_plyr", "walk", "stand")
		
		if self.state == "attack" then
			self.state = "idle"
		end
		
		return false
	end
	return true
end

dmobs.dragon.do_custom_black = function(self, dtime)
	if self.driver then
		object_fly(self, dtime, 15, true, "dmobs:lightning_plyr", "walk", "stand")
		
		if self.state == "attack" then
			self.state = "idle"
		end
		
		return false
	end
	return true
end




