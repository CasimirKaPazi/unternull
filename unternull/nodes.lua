minetest.register_craft({
	type = "cooking",
	output = "default:molten_rock",
	recipe = "default:stone",
	cooktime = 20,
})

minetest.register_craft({
	type = "cooking",
	output = "default:lava_source",
	recipe = "default:molten_rock",
	cooktime = 20,
})

minetest.register_craft({
	output = "default:mossycobble",
	type = "shapeless",
	recipe = {"default:cobble", "group:flora"},
})
