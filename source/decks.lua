-- Developer Deck
local testSyrupMod = true

if testSyrupMod then
    -- change these to the jokers you want
    local firstJoker = "picojoker"
    local secondJoker = nil

    SMODS.Atlas{
        key = 'Decks',
        path = 'syrupdeck.png',
        px = 71,
        py = 95,
    }

    SMODS.Back({
        key = "syrupdeck",
        loc_txt = {
            name = "Syrup Deck [DEV]",
            text = {
                "Start with {C:purple}SyrupMod{} Jokers"
            }
        },

        config = { hands = 0, discards = 0, consumeables = 'c_opentolan'},
	    pos = { x = 0, y = 0 },
	    order = 1,
	    atlas = "Decks",
        unlocked = true,

        apply = function(self)
            G.E_MANAGER:add_event(Event({
	    		func = function()
                    if firstJoker ~= nil then
                        local joker1 = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_syrupmod_"..firstJoker, "syrupmod_deck")
                        joker1:add_to_deck()
                        --card:start_materialize()
                        G.jokers:emplace(joker1)
                    end

                    if secondJoker ~= nil then
                        local joker2 = create_card("Joker", G.jokers, nil, nil, nil, nil, "j_syrupmod_"..secondJoker, "syrupmod_deck")
                        joker2:add_to_deck()
                        --card:start_materialize()
                        G.jokers:emplace(joker2)
                    end

                    return true
	    		end,
	    	}))
	    end,

	    check_for_unlock = function(self, args)
	    	if args.type == "win_deck" then
                unlock_card(self)
            else
	    		unlock_card(self)
	    	end
	    end,
    })
end