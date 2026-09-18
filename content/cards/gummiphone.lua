SMODS.Joker {
  attributes = { "reference", "FinalMix", "chips" },
  key = "gummiphone",

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = {
        cae.mult
      }
    }
  end,

  rarity = 1,
  cost = 5,
  atlas = 'KHJokers',
  pos = { x = 0, y = 2 },

  blueprint_compat = true,

  config = {
    extra = {
      mult = 0
    }
  },

  calculate = function(self, card, context)
    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
      local _mult = 0
      if hand_chips then
        _mult = hand_chips / 10
      end
      card.ability.extra.mult = card.ability.extra.mult + _mult
      return {
        message = localize { type = 'variable', key = 'a_mult', vars = { _mult } },
        colour = G.C.RED,
      }
    end
    if context.joker_main and card.ability.extra.mult > 0 then
      return { mult = card.ability.extra.mult }
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
