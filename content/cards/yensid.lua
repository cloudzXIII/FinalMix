SMODS.Joker {
  attributes = { "reference", "FinalMix", "tarot", "chance" },
  key = 'disney',
  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    local numerator, denominator = SMODS.get_probability_vars(card, cae.base, cae.odds,
      'yensid1')
    return {
      vars = {
        numerator,
        denominator,
      }
    }
  end,

  rarity = 1,
  atlas = 'KHJokers',
  pos = { x = 5, y = 1 },
  cost = 4,

  blueprint_compat = false,

  config = {
    extra = {
      odds = 2,
      base = 1
    }
  },

  calculate = function(self, card, context)
    if context.using_consumeable and context.consumeable and context.consumeable.ability.set == 'Tarot' and not context.blueprint then
      if SMODS.pseudorandom_probability(card, 'yensid', card.ability.extra.base, card.ability.extra.odds, 'yensid1') then
        local hand = MIX.poll_poker_hand("yensid")
        SMODS.calculate_effect({ message = localize('k_level_up_ex'), colour = G.C.GREEN },
          context.blueprint_card or card)

        SMODS.smart_level_up_hand(card, hand, nil, 1)
      end
    end
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      extra = {
        {
          { text = "(" },
          { ref_table = "card.joker_display_values", ref_value = "odds" },
          { text = ")" },
        }
      },
      extra_config = { colour = G.C.GREEN, scale = 0.3 },
      calc_function = function(card)
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { card.ability.extra.base, card.ability.extra.odds } }
      end,
    }
  end
}
