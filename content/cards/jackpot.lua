SMODS.Joker {
  attributes = { "reference", "FinalMix", "mod_chance", "passive", "reset" },
  key = 'jackpot',

  loc_vars = function(self, info_queue, card)
    return {
      vars = {}
    }
  end,

  atlas = "KHJokers",
  pos = { x = 7, y = 5 },
  rarity = 2,
  cost = 5,
  blueprint_compat = false,

  config = {
    extra = {
      times_failed = 0
    }
  },

  calculate = function(self, card, context)
    if context.pseudorandom_result then
      if context.result == false then
        SMODS.calculate_effect({ message = localize('k_active_ex'), colour = G.C.GREEN }, card)
        card.ability.extra.times_failed = card.ability.extra.times_failed + 1
      end
      if context.result == true and card.ability.extra.times_failed > 0 then
        card.ability.extra.times_failed = 0
        SMODS.calculate_effect({ message = localize('k_reset'), colour = G.C.FILTER }, card)
      end
    end
    if context.mod_probability and card.ability.extra.times_failed > 0 and not context.blueprint then
      return {
        numerator = context.numerator * (2 ^ card.ability.extra.times_failed)
      }
    end
  end,
}
