SMODS.Joker {
	key = 'Keyblade',
	
	loc_txt = {
		name = 'Keyblade',
		text = {
			"May your heart be your {C:mult}+#1# {}mult"
		}
	},

	config = { extra = { mult = 13 } },
	
	loc_vars = function(self, info_queue, card)
		return {vars = { card.ability.extra.mult } }
	end,
	
	rarity = 3,
	atlas = 'KHJokers',
	pos = { x = 0, y = 0},
	cost = 5,
	
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult_mod = card.ability.extra.mult,
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
				}
		end
	end
}
