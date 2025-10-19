-- Lean
SMODS.Atlas{
    key = "lean",
    path = "lean.png",
    px =  71,
    py = 95
}

SMODS.Consumable{
    key = "lean",
    set = "Tarot",
    object_type = "Consumable",
    name = "lean",
    config = {
        max_highlighted = 1
    },
    loc_txt = {
        name = "Lean",
        text = {
            "Select {C:attention}1{} card to",
            "turn {C:purple}Purple{}"
        }
    },
    
    pos = {x = 0, y = 0},
    order = 99,
    atlas = "lean",
    cost = 5,

    can_use = function(self, card)
        if #G.hand.highlighted == 1 then
            return true
        end
	end,

    use = function(self, card, area, copier)
        for i = 1, math.min(#G.hand.highlighted, card.ability.max_highlighted) do
            G.E_MANAGER:add_event(Event({func = function()
                --play_sound('syrupmod_sip')
                card:juice_up(0.3, 0.5)
                return true end}))
            
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.1, func = function()
                G.hand.highlighted[1]:set_edition({ syrupmod_purple = true })
                return true end}))
            
            delay(0.5)
        end
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function() G.hand:unhighlight_all(); return true end}))
    end,

    check_for_unlock = function(self, args)
		unlock_card(self)
	end
}

-- Za Warudo
SMODS.Atlas{
    key = "zawarudo",
    path = "lean.png", -- placeholder
    px =  71,
    py = 95
}

SMODS.Consumable{
    key = "zawarudo",
    set = "Tarot",
    object_type = "Consumable",
    name = "zawarudo",
    config = {
        no_pool = true,
    },
    loc_txt = {
        name = "Za Warudo",
        text = {
            "Stops time for {C:yellow}8 seconds{}",
            "{C:blue}Hands{}, {C:red}Discards{}, and {C:attention}Money{} are {C:dark_edition}not consumed{} during this period"
        }
    },

    pos = {x = 0, y = 0},
    order = 99,
    atlas = "zawarudo",
    cost = 10,

    can_use = function(self, card)
        return true
    end,

    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({func = function()
            local start_time = os.clock()
            local za_text = G.HUD:add_text({
                text = "Za Warudo: 8",
                scale = 1,
                colour = G.C.YELLOW,
                lifespan = 8,
                float = false,
                hold = true
            })

            G.GAME.za_warudo_text = za_text

            G.E_MANAGER:add_event(Event({
                blockable = false,
                blocking = false,
                func = function()
                    local function update()
                        local elapsed = os.clock() - start_time
                        if elapsed < 8 then
                            za_text:set_text("Time Stop Timer: " .. tostring(math.ceil(8 - elapsed)))
                            return false -- keep going
                        else
                            G.HUD:remove_text(za_text)
                            return true
                        end
                    end
                    return update()
                end,
                update = true,
                persistent = true
            }))

            local saved_hands = G.GAME.round_resets.hands
            local saved_discards = G.GAME.round_resets.discards
            local saved_money = G.GAME.dollars

            G.GAME.za_warudo_active = true

            local old_play_hand = G.FUNCS.play_hand
            G.FUNCS.play_hand = function(...)
                G.GAME.round_resets.hands = saved_hands
                return old_play_hand(...)
            end

            local old_discard = G.FUNCS.discard_cards
            G.FUNCS.discard_cards = function(...)
                G.GAME.round_resets.discards = saved_discards
                return old_discard(...)
            end

            local old_spend_money = G.FUNCS.spend_money
            G.FUNCS.spend_money = function(amount, ...)
                G.GAME.dollars = G.GAME.dollars + amount
                return old_spend_money(amount, ...)
            end

            G.E_MANAGER:add_event(Event({
                trigger = 'timer',
                delay = 8,
                func = function()
                    G.FUNCS.play_hand = old_play_hand
                    G.FUNCS.discard_cards = old_discard
                    G.FUNCS.spend_money = old_spend_money
                    G.GAME.za_warudo_active = false
                    return true
                end
            }))

            return true
        end}))
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end
}