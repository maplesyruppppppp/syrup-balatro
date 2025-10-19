SMODS.Atlas{
    key = "syrupboosters",
    path = "boosters.png",
    px = 71,
    py = 95
}

-- Booster Pack 1
SMODS.Booster{
    key = "syrupbooster1",
    group_key = "k_syrupmod_booster_group",
    atlas = "syrupboosters",
    pos = {x = 0, y = 0},
    discovered = true,
    loc_txt = {
        name = "SyrupMod Booster Pack",
        text = {
            "Pick {C:attention}1{} out of",
            "{C:attention}2{} {C:dark_edition}SyrupMod{} Jokers",
        },
        group_name = {"Pick somethin', will ya?"},
    },

    draw_hand = false,
    config = {
        extra = 3,
        choose = 1,
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.choose,
                card.ability.extra,
            }
        }
    end,

    weight = 1,
    cost = 5,
    kind = "SyrupModPack",

    create_card = function(self, card, i)
        ease_background_colour(HEX("7b00ff"))
        return SMODS.create_card({
            set = "SyrupModAddition",
            area = G.pack_cards,
            skip_materialize = true,
            soulable = true,
        })
    end,

    select_card = "jokers",
    in_pool = function() return true end
}