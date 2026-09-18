SMODS.Joker {
  attributes = { "reference", "FinalMix", "mult", "scaling", "hand_type", "hands", "reset" },
  key = "xehanort",

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = {
        cae.mult_gain,
        cae.mult
      }
    }
  end,

  rarity = 2,
  cost = 6,
  atlas = 'KHJokers',
  pos = { x = 1, y = 3 },

  blueprint_compat = true,

  config = {
    extra = {
      last_played = "",
      mult = 0,
      mult_gain = 5,
    }
  },
  calculate = function(self, card, context)
    if context.press_play then
      card.ability.extra.last_played = G.GAME.last_hand_played
    end
    if context.joker_main then
      if card.ability.extra.last_played ~= context.scoring_name then
        SMODS.scale_card(card, {
          ref_table = card.ability.extra,
          ref_value = "mult",
          scalar_value = "mult_gain",
          operation = '+',
          message_colour = G.C.MULT
        })
      else
        if card.ability.extra.mult > 0 then
          card.ability.extra.mult = 0
          SMODS.calculate_effect({ message = localize('k_reset'), colour = G.C.FILTER }, card)
        end
      end
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
