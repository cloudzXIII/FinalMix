
SMODS.Joker {
	key = 'mickey',
	
	loc_txt = {
		name = 'Meeska Mooska',
		text = {
			"Copies ability of",
			"{C:attention}Joker{} to the left",
			"{C:inactive,s:0.8} They'll pay for this."
		}
	},
		
	rarity = 3,
	atlas = 'KHJokers',
	pos = { x = 2, y = 0 },
	cost = 10,
	unlocked = true,
    discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	config = {
		extra = {}
		},
	
	generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    -- gen base UI
		SMODS.Center.generate_ui(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    -- add blueprint compat text
		card.ability.blueprint_compat_ui = card.ability.blueprint_compat_ui or ''; card.ability.blueprint_compat_check = nil
		desc_nodes[#desc_nodes + 1] = (card.area and card.area == G.jokers) and {
			{n=G.UIT.C, config={align = "bm", minh = 0.4}, nodes={
				{n=G.UIT.C, config={ref_table = card, align = "m", colour = G.C.JOKER_GREY, r = 0.05, padding = 0.06, func = 'blueprint_compat'}, nodes={
					{n=G.UIT.T, config={ref_table = card.ability, ref_value = 'blueprint_compat_ui',colour = G.C.UI.TEXT_LIGHT, scale = 0.32*0.8}},
				}}
			}}
		} or nil
	end,

  
	update = function(self, card, dt)
		if G.jokers then
			local other_joker = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card and i > 1 then
                other_joker = G.jokers.cards[i-1]
				end
			end
			if other_joker and other_joker.config.center.blueprint_compat then
				card.ability.blueprint_compat = 'compatible'
			else
				card.ability.blueprint_compat = 'incompatible'
			end
		end
	end,

	calculate = function(self, card, context)
		if not card.debuff and G.jokers.cards[1].config.center.key ~= "meeskamooska" then
			local other_joker = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card and i>1 then other_joker = G.jokers.cards[i-1] end
			end
			local ret = SMODS.blueprint_effect(card, other_joker, context)
			if ret then return ret end
		end
	end,
 }
 