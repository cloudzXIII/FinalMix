SMODS.Joker {
  attributes = { "reference", "FinalMix", "reroll", "hand_type", "hands" },
  key = 'riku',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = {
        localize(MIX.most_played_hand(), 'poker_hands'),
        cae.levels,
        cae.counter,
        cae.total
      }
    }
  end,

  rarity = 2,
  atlas = "KHJokers",
  pos = { x = 9, y = 0 },
  cost = 6,

  blueprint_compat = true,

  config = {
    extra = {
      levels = 1,
      counter = 4,
      total = 4
    }
  },

  calculate = function(self, card, context)
    if context.reroll_shop then
      card.ability.extra.counter = card.ability.extra.counter - 1

      if card.ability.extra.counter <= 0 then
        -- resets reroll counter
        card.ability.extra.counter = card.ability.extra.total

        local _card = context.blueprint_card or card
        SMODS.calculate_effect({ message = localize('k_level_up_ex'), colour = G.C.FILTER }, _card)

        SMODS.smart_level_up_hand(card, MIX.most_played_hand(), nil, card.ability.extra.levels)
        return nil, true
      end
    end
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        { ref_table = "card.joker_display_values", ref_value = "most_played", colour = G.C.CHIPS }
      },
      reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "counter" },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "total" },
        { text = ")" },
      },
      calc_function = function(card)
        card.joker_display_values.most_played = localize(MIX.most_played_hand(), 'poker_hands')
      end
    }
  end
}
