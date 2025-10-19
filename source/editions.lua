-- Purple Edition
SMODS.Shader({
    key = 'purple',
    path = 'purple.fs'
})

SMODS.Edition{
    key = "purple",
    order = 2,
	config = {x_mult = 3, x_chips = 2},
    loc_txt = {
        label = 'Purple',
        name = 'Purple',
        text = {
            "{C:inactive}''Phew! Good thing I'm {C:purple}purple!{}{C:inactive}''",
            '{X:mult,C:white}X#1#{} Mult & {X:chips,C:white}X#2#{} Chips',
        }
    },
    weight = 13,
    shader = "purple",
    in_shop = true,
    extra_cost = 4,
    unlocked = true,

    get_weight = function(self)
		return G.GAME.edition_rate * self.weight
	end,
    loc_vars = function(self, info_queue)
        return {
            vars = {
                self.config.x_mult,
                self.config.x_chips
            }
        }
    end,

    calculate = function(self, card, context)
        local playing_card = (context.edition and context.cardarea == G.jokers and card.config.trigger) or (context.main_scoring and context.cardarea == G.play)

        if playing_card then
            return {
                message = "purple :)",
                x_mult = self.config.x_mult,
                x_chips = self.config.x_chips
            }
        end

        if context.joker_main then
			card.config.trigger = true
		end
		if context.after then
			card.config.trigger = nil
		end
    end
}