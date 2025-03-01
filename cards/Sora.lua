SMODS.Joker {
	key = 'Sora',
	
	loc_txt = {
		name = 'Sora',
		text = {
			"My Friend are my power!",
			"here's {X:mult,C:white}X#1# {} Mult"
		}
	},

	config = { extra = { Xmult = 3 } },
	
	loc_vars = function(self, info_queue, card)
		return {vars = { card.ability.extra.Xmult } }
	end,
	blueprint_compat = true,	
	rarity = 2,
	atlas = 'KHJokers',
	pos = { x = 1, y = 0},
	cost = 4,
	
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				Xmult_mod = card.ability.extra.Xmult,
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } }
				}
		end
	end
}

