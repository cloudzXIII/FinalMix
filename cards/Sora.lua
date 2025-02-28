SMODS.Joker {
	key = 'Sora',
	
	loc_txt = {
		name = 'Sora',
		text = {
			"My Friend are my power! here's{C:mult}+#1# {}Mult"
		}
	},

	config = { extra = { mult = 7 } },
	
	loc_vars = function(self, info_queue, card)
		return {vars = { card.ability.extra.mult } }
	end,
	
	rarity = 2,
	atlas = 'KHJokers',
	pos = { x = 1, y = 0},
	cost = 4,
	
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult_mod = card.ability.extra.mult,
				message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
				}
		end
	end
}

