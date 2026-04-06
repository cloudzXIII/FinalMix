SMODS.Joker {
	key = 'lethimcook',
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.x_mult, --1
				card.ability.extra.xmult_gain --2
			}
		}
	end,

	rarity = 3,
	atlas = 'cooking',
	pos = { x = 0, y = 0 },
	cost = 8,

	discovered = true,
	blueprint_compat = false,

	config = {
		extra = {
			x_mult = 1,
			xmult_gain = 0.05,
		}
	},

	calculate = function(self, card, context)
		if context.post_trigger and context.cardarea == G.jokers then
			SMODS.scale_card(card, {
				ref_table = card.ability.extra,
				ref_value = "x_mult",
				scalar_value = "xmult_gain",
				operation = '+',
			})
		end
		if context.joker_main and card.ability.extra.x_mult > 1 then
			return {
				x_mult = card.ability.extra.x_mult
			}
		end
	end,
}
