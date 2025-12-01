SMODS.Joker {
	name = 'Bryce The Nobody',
	key = 'brycethenobody',

	loc_vars = function(self, info_queue, card)
		local suit = (G.GAME.current_round.kh_bryce_card or {}).suit or 'Hearts'
		return {
			vars = {
				card.ability.extra.mult, --1
				localize(suit, 'suits_singular'),
				colours = { G.C.SUITS[suit] } -- 2
			}
		}
	end,

	rarity = 2,
	atlas = 'KHJokers',
	pos = { x = 1, y = 3 },
	cost = 4,
	unlocked = true,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {
		extra = {
			mult = 3,
		}
	},
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			if context.other_card:is_suit(G.GAME.current_round.kh_bryce_card.suit) then
				context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
				context.other_card.ability.perma_mult = context.other_card.ability.perma_mult +
					card.ability.extra.mult
				SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.FILTER }, context.other_card)
			end
		end
	end
}
