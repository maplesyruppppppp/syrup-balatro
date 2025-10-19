SMODS.Atlas{
    key = "syrupblinds",
    path = "blinds.png",
    px = 34,
    py = 34,
    frames = 1,
    atlas_table = 'ANIMATION_ATLAS'
}

SMODS.Blind{
    name = "boss_sheldon",
    key = "boss_sheldon",
    atlas = "syrupblinds",
    pos = {y = 0},
    dollars = 10,
    loc_txt = {
        name = "SHELDON",
        text = {
            "Debuffs all",
            "SyrupMod Jokers"
        }
    },
    boss = {min = 1},
    boss_colour = HEX('a500ca'),

    recalc_debuff = function(self, card)
        for i = 1, #G.jokers.cards do
            if not G.GAME.blind.disabled and G.jokers.cards[i].config.center.pools and G.jokers.cards[i].config.center.pools.SyrupModAddition then
                G.jokers.cards[i]:set_debuff(true)
            end
        end
    end,

    disable = function(self, card)
        for i = 1, #G.jokers.cards do
            G.jokers.cards[i]:set_debuff(false)
        end
    end,

    defeat = function(self, card)
        for i = 1, #G.jokers.cards do
            G.jokers.cards[i]:set_debuff(false)
        end
    end,
}