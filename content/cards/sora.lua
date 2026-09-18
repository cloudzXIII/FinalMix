SMODS.Joker {
  attributes = { "reference", "FinalMix", "reset", "hearts", "xmult", "scaling", "reset" },
  key = 'sora',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = {
        cae.x_mult,
        cae.Xmult_gain
      }
    }
  end,

  rarity = 3,
  atlas = 'KHJokers',
  pos = { x = 0, y = 0 },
  cost = 7,

  blueprint_compat = true,

  config = {
    extra = {
      x_mult = 1,
      Xmult_gain = 0.2,
    }
  },

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and not context.blueprint then
      if context.other_card:is_suit("Hearts") then
        SMODS.scale_card(card, {
          ref_table = card.ability.extra,
          ref_value = "x_mult",
          scalar_value = "Xmult_gain",
          operation = '+',
          message_colour = G.C.MULT
        })
      end
    end

    if context.joker_main and card.ability.extra.x_mult > 1 then
      return {
        x_mult = card.ability.extra.x_mult
      }
    end

    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and context.beat_boss then
      card.ability.extra.x_mult = 1
      return {
        message = localize('k_reset'),
        colour = G.C.RED
      }
    end
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        {
          border_nodes = {
            { text = "X" },
            { ref_table = "card.ability.extra", ref_value = "x_mult" }
          }
        }
      },
      reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text", colour = lighten(G.C.SUITS["Hearts"], 0.35) },
        { text = ")" }
      },
      calc_function = function(card)
        card.joker_display_values.localized_text = localize("Hearts", 'suits_plural')
      end
    }
  end
}
