SMODS.Joker {
	key = 'lethimcook',

	rarity = 3,
	atlas = 'cooking',
	pos = { x = 0, y = 0 },
	cost = 10,

	discovered = true,
	blueprint_compat = false,

	config = {extra = {}},
}

local calc_main_scoring_ref = SMODS.calculate_main_scoring
function SMODS.calculate_main_scoring(context, scoring_hand)
    if context.cardarea == G.play and next(SMODS.find_card('j_kh_lethimcook')) then
		-- call normal scoring
        calc_main_scoring_ref(context, scoring_hand)
        
        local original_cardarea = context.cardarea
        local original_scoring_hand = context.scoring_hand

		-- call scoring again in a random order
		if SMODS.calculate_round_score() > G.GAME.blind.chips and G.GAME.current_round.hands_played == 0 then
			for _, joker in ipairs(SMODS.find_card('j_kh_lethimcook')) do
				local rnd_order = XIII.shuffle_cards(scoring_hand, "randomiser")
				context.cardarea = { cards = rnd_order }
				context.scoring_hand = rnd_order
				SMODS.calculate_effect({message = localize('k_kh_rescore_ex'), colour = G.C.SECONDARY_SET.Enhanced}, joker)
				calc_main_scoring_ref(context, rnd_order)
			end
		end
		
		-- make it back to normal
        context.cardarea = original_cardarea
        context.scoring_hand = original_scoring_hand
        
        return
    end
    
    return calc_main_scoring_ref(context, scoring_hand)
end