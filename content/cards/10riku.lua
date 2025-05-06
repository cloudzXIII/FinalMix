SMODS.Joker {
    key = 'riku',
    
    loc_txt = {
        name = 'Riku',
        text = {
			"Gains {C:chips}+1{} Chips and {C:mult}+1{} Mult",
			"for each scored {C:spades}Spade{} or {C:clubs}Clubs{}",
			"Loses {C:chips}-1{} Chips and {C:mult}-1{} Mult",
			"for each scored {C:diamonds}Diamond{} or {C:hearts}Heart{}",
            "{C:inactive}(Currently {C:chips}+#1#{}{C:inactive} Chips, {C:mult}+#2#{}{C:inactive} Mult){}",
            "{C:inactive,s:0.8} Come to the darkness!"
        }
    },
    
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips,
                card.ability.extra.mult
            }
        }
    end,

    rarity = 2,
    atlas = 'KHJokers',
    pos = { x = 4, y = 1 },
    cost = 6,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    
    config = {
        extra = { 
			chips = 0,
			mult = 0 
			}
    },
    
    calculate = function(self, card, context)
	
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card:is_suit('Clubs') or context.other_card:is_suit('Spades') then
				--if card.ability.extra.mult < 35 and card.ability.extra.chips < 35 then
					-- Gain Chips and Mult
				card.ability.extra.chips = card.ability.extra.chips + 1
				card.ability.extra.mult = card.ability.extra.mult + 1
				return {
					message = 'Upgraded!',
					colour = G.C.GREEN,
					card = card
				}
				--end
				

            elseif context.other_card:is_suit('Hearts') or context.other_card:is_suit('Diamonds') then
                --Reset Chips/Mult
				--if card.ability.extra.mult > 0 or card.ability.extra.mult > 0 then
				card.ability.extra.chips = card.ability.extra.chips - 1
				card.ability.extra.mult = card.ability.extra.mult - 1
			
				return {
					message = 'Nope!',
					colour = G.C.MONEY,
					card = card,
				}
				--end			
			end
        end

        -- Show Chips/Mult underneath Joker
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                card = card
            }
        end
    end
}