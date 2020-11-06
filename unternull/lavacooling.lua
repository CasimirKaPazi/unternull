-- Lava cooling

-- Exclude bedrock, coal and diamond from being generated
unternull.not_an_ore = {"default:stone_with_coal", "default:stone_with_diamond", "bedrock:deepstone", "bedrock:bedrock"}

local function is_not_an_ore(ore_name)
	for _,no_ore in ipairs(unternull.not_an_ore) do
		if ore_name == no_ore then
			return true
		end
	end
	return false
end

-- Place ore just as often as they occur in mapgen.
local function choose_ore(pos)
	if pos.y > -20 then return "default:stone_crumbled" end
	local cool_flowing = "default:stone"
	for _, ore in pairs(minetest.registered_ores) do
		if is_not_an_ore(ore.ore) then
			-- Do noting, keep cycling.
		elseif ore.wherein == cool_flowing and ore.ore_type == "scatter"
				and pos.y < ore.y_max and pos.y > ore.y_min then
			local rarity = math.floor(ore.clust_scarcity / ore.clust_size)
			if math.random(rarity/10) == 1 then
				cool_flowing = ore.ore
				break
			end
		end
	end
	return cool_flowing
end

default.cool_lava = function(pos, node)
	if node.name == "default:lava_source" then
		local cool_source = "default:stone"
		-- different for subgame used
		if minetest.registered_items["default:molten_rock"] then
			-- Voxelgarden
			cool_source = "default:molten_rock"
		elseif minetest.registered_items["default:obsidian"] then
			-- Minetest Game
			cool_source = "default:obsidian"
		end
		minetest.set_node(pos, {name = cool_source})
	else -- Lava flowing
		local cool_flowing = choose_ore(pos)
		minetest.set_node(pos, {name = cool_flowing})
	end
	minetest.sound_play("default_cool_lava",
		{pos = pos, max_hear_distance = 16, gain = 0.25})
end
