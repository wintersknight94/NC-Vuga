-- LUALOCALS < ---------------------------------------------------------
local minetest, nodecore
	= minetest, nodecore
-- LUALOCALS > ---------------------------------------------------------
local modname = minetest.get_current_modname()
------------------------------------------------------------------------
geodes = {}
local geode_types = {}
------------------------------------------------------------------------
minetest.register_node(modname.. ":geode_core", {
	groups = {not_in_creative_inventory = 1},
})
------------------------------------------------------------------------
minetest.register_ore({
	ore_type		= "scatter",
	ore				= modname.. ":geode_core",
	wherein			= {"air", "group:stone", "group:sand", "group:gravel", "group:water", "group:lava"},
	clust_scarcity	= 80 * 64 * 80,
	clust_num_ores	= 1,
	clust_size		= 1,
	y_max			= -128,
	y_min			= -31000,
})
------------------------------------------------------------------------
minetest.register_abm({
        label = "make_geode",
        nodenames = {modname.. ":geode_core"},
        interval = 1,
        chance = 1,
        action = function(pos, node)
		
		local outer, middle, inner, crystal, fill, size_min, size_max = unpack(geode_types[math.random(1, #geode_types)])
		local size = math.random(size_min, size_max)

		for x = -size, size do
		for y = -size, size do
		for z = -size, size do
		if minetest.get_node(pos + vector.new(x, y, z)).name ~= "air" then
		if vector.distance(vector.new(x, y, z), vector.new()) < size then
			minetest.set_node(pos + vector.new(x, y, z), {name = outer})
		if vector.distance(vector.new(x, y, z), vector.new()) < size - 1 then
			minetest.set_node(pos + vector.new(x, y, z), {name = middle})
		if vector.distance(vector.new(x, y, z), vector.new()) < size - 2 then
			minetest.set_node(pos + vector.new(x, y, z), {name = inner})
		if vector.distance(vector.new(x, y, z), vector.new()) < size - 3 then
			minetest.set_node(pos + vector.new(x, y, z), {name = fill})
		end
		end
		end
		end
		end
		end
		end
		end

		if crystal ~= fill then
		for x = -size +4, size -4 do
		for y = -size +4, size -4 do
		for z = -size +4, size -4 do
		if math.random(0, 10) == 0 and vector.distance(vector.new(x, y, z), vector.new()) >= size - 4 and vector.distance(vector.new(x, y, z), vector.new()) < size - 3 then

			if minetest.get_node(pos + vector.new(x, y + 1, z)).name == inner then
			minetest.set_node(pos + vector.new(x, y, z), {name = crystal, param2 = 0})
			elseif minetest.get_node(pos + vector.new(x, y - 1, z)).name == inner then
			minetest.set_node(pos + vector.new(x, y, z), {name = crystal, param2 = 1})
			elseif minetest.get_node(pos + vector.new(x + 1, y, z)).name == inner then
			minetest.set_node(pos + vector.new(x, y, z), {name = crystal, param2 = 2})
			elseif minetest.get_node(pos + vector.new(x - 1, y, z)).name == inner then
			minetest.set_node(pos + vector.new(x, y, z), {name = crystal, param2 = 3})
			elseif minetest.get_node(pos + vector.new(x, y, z + 1)).name == inner then
			minetest.set_node(pos + vector.new(x, y, z), {name = crystal, param2 = 4})
			elseif minetest.get_node(pos + vector.new(x, y, z - 1)).name == inner then
			minetest.set_node(pos + vector.new(x, y, z), {name = crystal, param2 = 5})
			
			end
		end
		end
		end
		end
		end

	end,
    })
------------------------------------------------------------------------
------------------------------------------------------------------------
function geodes.register_geode(outer, middle, inner, crystal, fill, size_min, size_max)
	table.insert(geode_types, {outer, middle, inner, crystal or "air", fill or "air", size_min or 6, size_max or 11})
end
------------------------------------------------------------------------
geodes.register_geode("nc_lode:stone_5", "nc_lode:stone", "nc_lode:ore", "nc_lode:cobble", "air", 3, 7)
geodes.register_geode("nc_lux:stone_7", "nc_lux:stone_6", "nc_lux:stone", "nc_lux:cobble1", "air", 2, 5)
------------------------------------------------------------------------
if minetest.get_modpath("wc_crystals") then
	geodes.register_geode("nc_lux:stone_7", "nc_lux:stone_6", "wc_crystals:luxite", "wc_crystals:luxite_crystal", "air", 5, 9)
	geodes.register_geode("nc_lode:stone_5", "nc_lode:ore_7", "wc_crystals:lodite", "wc_crystals:lodite_crystal", "air", 5, 9)
end
------------------------------------------------------------------------
if minetest.get_modpath("wc_adamant") then
	geodes.register_geode("nc_lux:stone_7", "nc_lode:ore_6", "wc_adamant:stone", "wc_crystals:adamant_crystal", "air", 5, 9)
end
------------------------------------------------------------------------
if minetest.get_modpath("wc_crystals") and minetest.settings:get_bool("wc_crystals.real_crystals", true) then
	geodes.register_geode("nc_terrain:hard_stone_4", "nc_concrete:cloudstone", "wc_crystals:amethyst", "wc_crystals:amethyst_crystal")
	geodes.register_geode("nc_terrain:hard_stone_4", "nc_concrete:cloudstone", "wc_crystals:quartz", "wc_crystals:quartz_crystal")
	geodes.register_geode("nc_terrain:hard_stone_4", "nc_concrete:cloudstone", "wc_crystals:pyrite", "wc_crystals:pyrite_crystal")
	geodes.register_geode("nc_terrain:hard_stone_4", "nc_concrete:cloudstone", "wc_crystals:aragonite", "wc_crystals:aragonite_crystal")
	geodes.register_geode("nc_terrain:hard_stone_4", "nc_concrete:cloudstone", "wc_crystals:onyx", "wc_crystals:onyx_crystal")
	geodes.register_geode("nc_terrain:hard_stone_4", "nc_concrete:cloudstone", "wc_crystals:citrine", "wc_crystals:citrine_crystal")
	geodes.register_geode("nc_terrain:hard_stone_4", "nc_concrete:cloudstone", "wc_crystals:celestine", "wc_crystals:celestine_crystal")
	geodes.register_geode("nc_terrain:hard_stone_4", "nc_concrete:cloudstone", "wc_crystals:selenite", "wc_crystals:selenite_crystal")
	geodes.register_geode("nc_terrain:hard_stone_4", "nc_concrete:cloudstone", "wc_crystals:jasper", "wc_crystals:jasper_crystal")
	geodes.register_geode("nc_terrain:hard_stone_4", "nc_concrete:cloudstone", "wc_crystals:chrysoprase", "wc_crystals:chrysoprase_crystal")
	geodes.register_geode("nc_terrain:hard_stone_4", "nc_concrete:cloudstone", "wc_crystals:rhodochrosite", "wc_crystals:rhodochrosite_crystal")
end
------------------------------------------------------------------------
if minetest.get_modpath("wc_crystals") and minetest.settings:get_bool("wc_crystals.birthstones", true) then
	geodes.register_geode("nc_terrain:hard_stone_4", "nc_concrete:cloudstone", "wc_crystals:ruby", "wc_crystals:ruby_crystal")
	geodes.register_geode("nc_terrain:hard_stone_4", "nc_concrete:cloudstone", "wc_crystals:sapphire", "wc_crystals:sapphire_crystal")
	geodes.register_geode("nc_terrain:hard_stone_4", "nc_concrete:cloudstone", "wc_crystals:emerald", "wc_crystals:emerald_crystal")
	geodes.register_geode("nc_terrain:hard_stone_4", "nc_concrete:cloudstone", "wc_crystals:topaz", "wc_crystals:topaz_crystal")
	geodes.register_geode("nc_terrain:hard_stone_4", "nc_concrete:cloudstone", "wc_crystals:garnet", "wc_crystals:garnet_crystal")
	geodes.register_geode("nc_terrain:hard_stone_4", "nc_concrete:cloudstone", "wc_crystals:aquamarine", "wc_crystals:aquamarine_crystal")
	geodes.register_geode("nc_terrain:hard_stone_4", "nc_concrete:cloudstone", "wc_crystals:peridot", "wc_crystals:peridot_crystal")
	geodes.register_geode("nc_terrain:hard_stone_4", "nc_concrete:cloudstone", "wc_crystals:tourmaline", "wc_crystals:tourmaline_crystal")
	geodes.register_geode("nc_terrain:hard_stone_4", "nc_concrete:cloudstone", "wc_crystals:alexandrite", "wc_crystals:alexandrite_crystal")
	geodes.register_geode("nc_terrain:hard_stone_4", "nc_concrete:cloudstone", "wc_crystals:diamond", "wc_crystals:diamond_crystal")
end
