-- Syrup
-- TODO: Rework this joker's ability later (this shit is too busted)
SMODS.Atlas{
    key = "syrupjoker",
    path = "jokers/syrup.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = 'syrupjoker',
    loc_txt = {
        name = 'Syrup',
        text = {
            "{C:red}+10 Mult{} & {C:blue}+35 Chips{} for every blind",
            "Additionally multiplies {X:mult,C:white}XMult{} by {C:attention}2{} on every boss blind",
            "{C:inactive}(Currently {C:red}+#1#Mult, {C:blue}+#2#Chips{} {C:inactive}& {X:mult,C:white}X#3# Mult{C:inactive})",
        }
    },
    atlas = 'syrupjoker',
    rarity = 4,
    cost = 30,

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = {extra = {
        multamt = 10,
        multtotal = 0,
        chipamt = 35,
        chiptotal = 0,
        Xmult = 1,
        Xmultmultiplier = 2,
        msgs = {
            "oh my syrup!",
            "mmmmmm syrup",
            "yummy syrup",
            "so maple-y",
            "canadian liquids......", -- i'm so sorry LOL
        }
    }},
    pools = {["SyrupModAddition"] = true},

    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                center.ability.extra.multtotal,
                center.ability.extra.chiptotal,
                center.ability.extra.Xmult,
                center.ability.extra.msgs,
            }
        }
    end,

    calculate = function(self, card, context)
        if context.setting_blind then
            if G.GAME.blind:get_type() == 'Boss' then
                upgradeSyrupJoker(card, true)
                return {
                    color = G.C.RED,
                    message = "Upgrade XMult!"
                }
            else
                upgradeSyrupJoker(card, false)
                return {
                    message = "Upgrade!"
                }
            end
        end

        if context.joker_main then
            if card.ability.extra.Xmult == 1 then
                return {
                    mult_mod = card.ability.extra.multtotal,
                    chip_mod = card.ability.extra.chiptotal,
                
                    message = "+".. card.ability.extra.multtotal .. " Mult" .. "& " .. card.ability.extra.chiptotal .. " Chips",
                }
            else
                return {
                    mult_mod = card.ability.extra.multtotal,
                    chip_mod = card.ability.extra.chiptotal,
                    Xmult_mod = card.ability.extra.Xmult,

                    message = "+".. card.ability.extra.multtotal .. " Mult" .. ", " .. card.ability.extra.chiptotal .. " Chips" .. " & " .. card.ability.extra.Xmult .. " XMult",
                }
            end
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end
}

-- syrup joker function
function upgradeSyrupJoker(card, upgradeXMult)
    card.ability.extra.multtotal = card.ability.extra.multtotal + card.ability.extra.multamt
    card.ability.extra.chiptotal = card.ability.extra.chiptotal + card.ability.extra.chipamt

    if upgradeXMult then
        card.ability.extra.Xmult = card.ability.extra.Xmult * card.ability.extra.Xmultmultiplier
    end
end


-- Uni
SMODS.Atlas{
    key = "unijoker",
    path = "jokers/uni.png",
    px = 71,
    py = 95
}

SMODS.Sound({key = "meow", path = "meow.ogg"})

SMODS.Joker{
    key = "unijoker",
    loc_txt = {
        name = 'Uni',
        text = {
            "{C:inactive}''I'm always the strongest...''",
            "Adds {C:red}Mult{} for each card in",
            "your current hand based on their rank",
            "{C:inactive}(Currently {C:red}+#1# Mult{}{C:inactive})",
        }
    },
    atlas = 'unijoker',
    rarity = 3,
    cost = 12,

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
            multtotal = 0,
            msgs = {
                "meow",
                "mrrp",
                "maow",
                "prr",
            },
        },
    },
    pools = {
        ["Cat"] = true,
        ["SyrupModAddition"] = true
    },

    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                center.ability.extra.multtotal,
                center.ability.extra.msgs,
            }
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        play_sound("syrupmod_meow")
    end,

    calculate = function(self, card, context)
        local temp_mult = 0
        local temp_ID = 15

        for i = 1, #G.hand.cards do
            if temp_ID >= G.hand.cards[i].base.id and G.hand.cards[i].ability.effect ~= 'Stone Card' then 
                temp_mult = temp_mult + G.hand.cards[i].base.nominal
                temp_ID = G.hand.cards[i].base.id
            end
        end

        card.ability.extra.multtotal = temp_mult

        if context.joker_main then
            return {
                message = card.ability.extra.msgs[math.random(1, #card.ability.extra.msgs)],
                mult_mod = card.ability.extra.multtotal,
            }
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end
}

-- BF FNF
SMODS.Atlas{
    key = "bfjoker",
    path = "jokers/bf.png",
    px = 71,
    py = 95
}

SMODS.Sound({key = "yeah", path = "yeah.ogg"})

SMODS.Joker{
    key = "bfjoker",
    loc_txt = {
        name = 'Boyfriend FNF',
        text = {
            "{C:inactive}''beep bop bo skdoo bep''",
            "{X:mult,C:white}+ 0.25 XMult{} for each {C:attention}repetitive hand type{} played",
            "{C:inactive}(Currently {X:mult,C:white}#1# XMult{})",
            "{C:inactive}(Current Hand Type: #2#)",

        }
    },
    atlas = 'bfjoker',
    rarity = 3,
    cost = 12,

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
            x_mult = 0.25,
            x_mult_total = 1,
            last_hand_played = "None",
        },
    },

    pools = {
        ["SyrupModAddition"] = true,
        ["FNF"] = true,
    },

    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                center.ability.extra.x_mult_total,
                center.ability.extra.last_hand_played,
            }
        }
    end,

    add_to_deck = function(self, card, from_debuff)
        play_sound("syrupmod_yeah")
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and context.scoring_hand and not context.blueprint then
            local current_hand = context.scoring_name
            local last_hand = card.ability.extra.last_hand_played

            if last_hand ~= current_hand then
                if last_hand == 'None' then
                    upgradeBFJoker(card)
                else
                    --print("BF Joker: Resetting")

                    card.ability.extra.x_mult_total = 1
                    card.ability.extra.last_hand_played = current_hand
                    return {
                        message = "Combo lost!",
                    }
                end
            else
                upgradeBFJoker(card)
            end

            card.ability.extra.last_hand_played = current_hand
        end

        if context.joker_main and card.ability.extra.x_mult_total > 1 then
            return {
                Xmult_mod = card.ability.extra.x_mult_total,
                message = "+" .. card.ability.extra.x_mult_total .. " XMult"
            }
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end
}

-- bf upgrade function
function upgradeBFJoker(card)
    --print("BF Joker: Not Resetting")
    card.ability.extra.x_mult_total = card.ability.extra.x_mult_total + card.ability.extra.x_mult
end


-- GF FNF
SMODS.Atlas{
    key = "gfjoker",
    path = "jokers/gf.png",
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "gfjoker",
    loc_txt = {
        name = 'Girlfriend FNF',
        text = {
            "{C:red}+15 Mult{} for each",
            "{C:dark_edition}Friday Night Funkin' Joker{} in your joker slots",
            "{C:inactive}(Currently {C:red}+#1# Mult{})",
        }
    },
    atlas = 'gfjoker',
    rarity = 2,
    cost = 5,

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
            mult = 15,
            mult_total = 0,
        },
    },

    pools = {
        ["SyrupModAddition"] = true,
        ["FNF"] = true,
    },

    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                center.ability.extra.mult_total,
            }
        }
    end,

    calculate = function(self, card, context)
        local fnfcount = 0

        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.FNF then
                fnfcount = fnfcount + 1
            end
        end

        card.ability.extra.mult_total = fnfcount * card.ability.extra.mult

        if context.joker_main then
            return {
                mult_mod = card.ability.extra.mult_total,
                message = "+" .. card.ability.extra.mult_total .. " Mult"
            }
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end
}

-- Pico FNF
SMODS.Atlas{
    key = "picojoker",
    path = "jokers/syrup.png", -- placeholder
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "picojoker",
    loc_txt = {
        name = "Pico FNF",
        text = {
            "Stores {C:red}+15 Mult{} for each",
            "{C:attention}face card{} played in your scoring hand",
            "Unleashes all of the stored {C:red}Mult{} on the {C:attention}final hand{}",
            "{C:inactive}(Currently +#1# {C:red}Mult{})",
        }
    },
    atlas = "picojoker",
    rarity = 3,
    cost = 10,

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
            mult_total = 0
        }
    },

    pools = {
        ["SyrupModAddition"] = true,
        ["FNF"] = true,
    },

    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                center.ability.extra.mult_total,
            }
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual and context.other_card and not context.blueprint then
            if context.other_card:is_face() then
                card.ability.extra.mult_total = card.ability.extra.mult_total + 15
            end
        end

        if (G.GAME.current_round.hands_left == 0 and context.final_scoring_step) or context.forcetrigger then
            return {
                message = '+' .. card.ability.extra.mult_total,
                mult_mod = card.ability.extra.mult_total,
            }
        end

        if context.end_of_round or context.setting_blind then
            card.ability.extra.mult_total = 0
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end
}

-- Chicken Jockey
SMODS.Atlas{
    key = "cj_joker",
    path = "jokers/syrup.png", -- placeholder
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "cj_joker",
    loc_txt = {
        name = 'Chicken Jockey',
        text = {
            "{X:mult,C:white}+1 XMult{} if the",
            "played hand contains a {C:attention}Pair{}",
            "If you play a different hand type, lose {X:mult,C:white}1 XMult{}",
            "{X:mult,C:white}XMult{} resets back to {C:attention}1{} at the end of the round",
            "{C:inactive}(Currently {X:mult,C:white}#1# XMult{})",
        }
    },
    atlas = 'cj_joker',
    rarity = 3,
    cost = 8,

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
            x_mult_total = 1,
        }
    },

    pools = {
        ["SyrupModAddition"] = true
    },

    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                center.ability.extra.x_mult_total,
            }
        }
    end,

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            local hand_type = context.scoring_hand

            if next(context.poker_hands['Pair']) then
                card.ability.extra.x_mult_total = card.ability.extra.x_mult_total + 1
                
                return {
                    colour = G.C.RED,
                    message = "+1 XMult",
                }
            else
                return {
                    colour = G.C.RED,
                    message = "-1 XMult",
                }
            end
        end

        if context.joker_main and card.ability.extra.x_mult_total > 1 then
            return {
                Xmult_mod = card.ability.extra.x_mult_total,
                message = "+" .. card.ability.extra.x_mult_total .. " XMult",
            }
        end

        if context.end_of_round or context.setting_blind then
            card.ability.extra.x_mult_total = 1
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end
}

-- Green Cane's Meal
SMODS.Atlas{
    key = "canesjoker",
    path = "jokers/greencanes.png", -- placeholder
    px = 71,
    py = 95
}

SMODS.Joker{
    key = "canesjoker",
    loc_txt = {
        name = "Green Cane's Meal",
        text = {
            "{C:blue}+12.90 Chips{}" -- average calories is 1290
        }
    },
    atlas = "canesjoker",
    rarity = 1,
    cost = 12, -- this is the average cost of a cane's box combo

    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = {
            chips_total = 12.90,
        }
    },

    pools = {
        ["SyrupModAddition"] = true
    },

    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                center.ability.extra.chips_total,
            }
        }
    end,

    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chip_mod = card.ability.extra.chips_total,
                message = "+" .. card.ability.extra.chips_total .. " Chips",
            }
        end
    end,

    check_for_unlock = function(self, args)
        unlock_card(self)
    end
}