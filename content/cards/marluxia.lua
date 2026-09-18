SMODS.Joker {
  attributes = { "reference", "FinalMix", "retrigger", "discard" },
  key = 'marluxia',

  loc_vars = function(self, info_queue, card)
    return {
      vars = {}
    }
  end,

  atlas = "KHJokers",
  pos = { x = 3, y = 7 },
  rarity = 2,
  cost = 7,
  blueprint_compat = true,

  config = {
    extra = {
    }
  },

  calculate = function(self, card, context)
    if context.discard and not context.retrigger_joker then
      local _, calculated = context.other_card:calculate_seal(context)
      if calculated then
        SMODS.calculate_effect({ message = localize("k_again_ex") }, context.blueprint_card or card)
      end
    end
    if context.retrigger_joker_check and not context.retrigger_joker then
      if context.other_context.discard then
        return {
          repetitions = 1,
        }
      end
      if context.other_context.pre_discard then
        return {
          repetitions = 1,
        }
      end
    end
  end,
}
