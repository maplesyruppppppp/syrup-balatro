local mod_path = "" .. SMODS.current_mod.path

-- Mod Icon
SMODS.Atlas({
	key = "modicon",
	path = "modicon.png",
	px = 32,
	py = 32
})

-- Joker Pool for custom jokers
SMODS.ObjectType({
	key = "SyrupModAddition",
	default = "j_reserved_parking",
	cards = {},
	inject = function(self)
		SMODS.ObjectType.inject(self)
	end,
})

-- Settings Tab
--SMODS.current_mod.extra_tabs = function()
--	return {
--		label = "Settings",
--		tab_definition_function = function()
--			settings = { n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {} }
--			
--		end
--	}
--end

-- Credits Tab
SMODS.current_mod.extra_tabs = function()
    local scale = 0.5
    return {
        label = "Credits",
        tab_definition_function = function()
            return {
                n = G.UIT.ROOT,
                config = {
                    align = "cm",
                    padding = 0.05,
                    colour = G.C.CLEAR,
                },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0,
                            align = "cm"
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "By Syrup",
                                    shadow = true,
                                    scale = scale * 2,
                                    colour = G.C.PURPLE
                                }
                            }
                        }
                    }
                }
            }
        end
    }
end

SMODS.current_mod.description_loc_vars = function(self)
	return {
		scale = 1.2,
		background_colour = G.C.CLEAR
	}
end

-- Load source files
local files = NFS.getDirectoryItems(mod_path .. "source")
for _, file in ipairs(files) do
	print("[SyrupMod] Loading lua file " .. file)
	
	local f, err = SMODS.load_file("source/" .. file)
	if err then
		error(err) 
	end
	f()
end