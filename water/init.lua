minetest.register_on_mapgen_init(function(mgparams)
	minetest.set_mapgen_params({mgname="singlenode"})
end)

local c_water = minetest.get_content_id("default:water_source")

minetest.register_on_generated(function(minp, maxp, seed)
--	local t1 = os.clock()
	if minp.y > 1 then
		return
	end
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local a = VoxelArea:new{
		MinEdge={x=emin.x, y=emin.y, z=emin.z},
		MaxEdge={x=emax.x, y=emax.y, z=emax.z},
	}

	local data = vm:get_data()

	for z = minp.z, maxp.z do
	for y = minp.y, maxp.y do
	for x = minp.x, maxp.x do
		if y < 1 then
			local vi = a:index(x, y, z)
			data[vi] = c_water
		end
	end
	end
	end

	vm:set_data(data)

	vm:calc_lighting(
		{x=minp.x-16, y=minp.y, z=minp.z-16},
		{x=maxp.x+16, y=maxp.y, z=maxp.z+16}
	)

	vm:write_to_map(data)
--	print(string.format("[unternull] building water: elapsed time: %.2fms", (os.clock() - t1) * 1000))
end)
