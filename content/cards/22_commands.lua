SMODS.Joker {
	key = "commandmenu",

	loc_vars = function(self, info_queue, card)
		local cae = card.ability.extra
		local _vars = { cae.x_mult, cae.attack_gain, cae.magic_gain, cae.items_gain, cae.drive_gain }

		info_queue[#info_queue + 1] = { key = "kh_attack", set = "Other", vars = _vars }
		info_queue[#info_queue + 1] = { key = "kh_magic", set = "Other", vars = _vars }
		info_queue[#info_queue + 1] = { key = "kh_items", set = "Other", vars = _vars }
		info_queue[#info_queue + 1] = { key = "kh_drive", set = "Other", vars = _vars }

		return {
			key = self.key .. '_kh' .. tostring(cae.pos),
			vars = _vars
		}
	end,

	rarity = 3,
	atlas = 'command',
	pos = { x = 0, y = 0 },
	cost = 9,

	discovered = true,
	blueprint_compat = true,

	config = {
		extra = {
			pos = 0,
			pos_override = { x = 0, y = 0 },
			x_mult = 1,
			attack_gain = 0.05,
			items_gain = 0.1,
			drive_gain = 0.05,
			magic_gain = 0.25
		},
	},

	load = function(self, card, card_table, other_card)
		G.E_MANAGER:add_event(Event({
			func = function()
				card.children.center:set_sprite_pos(card.ability.extra.pos_override)
				return true
			end
		}))
	end,

	add_to_deck = function(self, card, context)
		card.ability.extra.pos = 0
		card.config.center.pos.x = 0
	end,

	calculate = function(self, card, context)
		local pos = card.ability.extra.pos

		if context.discard then
			local total_cycles = 12
			local current_pos = card.ability.extra.pos or 0
			local final_pos = (current_pos + 1) % 4 -- goes in order

			local delays = {}
			local base_delay = 0.2
			local increment = 0.1
			for i = 1, total_cycles do
				delays[i] = base_delay + (i - 1) * increment
			end

			for i = 1, total_cycles do
				G.E_MANAGER:add_event(Event({
					delay = delays[i],
					func = function()
						card:juice_up(0.3, 0.2)
						card.ability.extra.pos = (card.ability.extra.pos + 1) % 4
						card.ability.extra.pos_override.x = card.ability.extra.pos
						card.children.center:set_sprite_pos(card.ability.extra.pos_override)
						return true
					end
				}))
			end

			G.E_MANAGER:add_event(Event({
				delay = delays[#delays] + 0.05,
				func = function()
					card.ability.extra.pos = final_pos
					card.ability.extra.pos_override.x = final_pos
					card.children.center:set_sprite_pos(card.ability.extra.pos_override)
					return true
				end
			}))

			SMODS.calculate_effect({ message = localize('k_kh_switched_ex'), colour = G.C.FILTER }, card)
		end

		if pos == 0 then -- Attack, Gain 0.05X mult per card scored
			if context.before and not context.blueprint then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "x_mult",
					scalar_value = "attack_gain",
					operation = function(ref_table, ref_value, initial, change)
						ref_table[ref_value] = initial + #context.scoring_hand * change
					end,
					message_key = 'a_xmult'
				})
			end
		elseif pos == 1 then -- Magic, gain 0.25X Mult when a card is enhanced?
			if context.setting_ability and not context.unchanged and not context.check_enhancement and G.P_CENTERS[context.new].set == 'Enhanced' then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "x_mult",
					scalar_value = "magic_gain",
					operation = '+',
					message_key = 'a_xmult'
				})
			end
		elseif pos == 2 then -- Items, gain 0.1X mult when a consumable is used
			if context.using_consumeable and not context.blueprint then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "x_mult",
					scalar_value = "items_gain",
					operation = '+',
					message_key = 'a_xmult'
				})
			end
		elseif pos == 3 then -- Drive, cards permanently gain 0.1x mult when scored
			if context.individual and context.cardarea == G.play then
				local _card = context.other_card
				_card.ability.perma_x_mult = (_card.ability.perma_x_mult or 0) + card.ability.extra.drive_gain
				SMODS.calculate_effect({ message_key = "a_xmult", colour = G.C.FILTER }, _card)
			end
		end

		if context.joker_main and card.ability.extra.x_mult > 1 then
			return {
				x_mult = card.ability.extra.x_mult
			}
		end
	end
}
