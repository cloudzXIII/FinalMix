SMODS.Joker {
  attributes = { "reference", "FinalMix", "mult", "scaling", "reset" },
  key = 'cloudstrife',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = {
        cae.mult_gain,
        cae.mult_max,
        cae.mult
      }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 6, y = 4 },
  rarity = 1,
  cost = 5,
  blueprint_compat = true,

  config = {
    extra = {
      mult = 0,
      mult_gain = 5,
      mult_max = 20
    }
  },

  calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint then
      if card.ability.extra.mult < card.ability.extra.mult_max then
        SMODS.scale_card(card, {
          ref_table = card.ability.extra,
          ref_value = "mult",
          scalar_value = "mult_gain",
          operation = '+',
          message_colour = G.C.MULT
        })
      else
        card.ability.extra.mult = 0
        SMODS.calculate_effect({ message = localize('k_reset'), colour = G.C.FILTER }, card)
      end
    end
    if context.joker_main then
      return {
        mult = card.ability.extra.mult
      }
    end
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
      },
      text_config = { colour = G.C.MULT },
    }
  end
}
