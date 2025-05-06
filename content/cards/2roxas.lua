SMODS.Joker {
	key = 'roxas',
	
	loc_txt = {
		name = 'Roxas',
		text = {
			"Gives {X:mult,C:white}X#1# {} Mult",
			"Mult increases by {X:mult,C:white}X#2#{} every",
			"round {C:inactive}(Max of {X:mult,C:white}X3{}{C:inactive}){}",
			"{C:inactive,s:0.8}looks like my summer vacation is... over",
		
		}
	},
	
	loc_vars = function(self, info_queue, card)
		return {vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain } }
	end,
		
	rarity = 2,
	atlas = 'KHJokers',
	pos = { x = 1, y = 0},
	cost = 5,
	unlocked = true,
    discovered = true,
	blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
	config = {
		extra = { 
			Xmult = 0.5,
			Xmult_gain = 0.5
			}
		},
	
	
	calculate = function(self, card, context)
	
		if context.joker_main then
			return {
				xmult = card.ability.extra.Xmult,
				card = context.other_card
				}
		end
		
		-- xmult upgrade at end of the round
		if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
			if card.ability.extra.Xmult < 3 then
				card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
				local message = 'Upgraded!'
				if card.ability.extra.Xmult >= 3 then
					message = 'Max Power!'
				end
				
				return {
                    message = message,
                    card = card,
                }
			end
			
		end
				
	end
}