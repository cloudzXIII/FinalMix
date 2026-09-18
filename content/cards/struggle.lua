SMODS.Joker {
  attributes = { "reference", "FinalMix", "reroll", "tag", "generation" },
  key = 'struggle',

  loc_vars = function(self, info_queue, card)
    return {
      vars = {}
    }
  end,

  atlas = "KHJokers",
  pos = { x = 5, y = 5 },
  rarity = 1,
  cost = 5,
  blueprint_compat = true,

  config = {
    extra = {
      rerolled = false
    }
  },

  calculate = function(self, card, context)
    if context.starting_shop then
      card.ability.extra.rerolled = false
    end
    if context.reroll_shop then
      card.ability.extra.rerolled = true
      SMODS.calculate_effect({ message = localize('k_reset'), colour = G.C.FILTER }, card)
    end
    if context.ending_shop and not card.ability.extra.rerolled then
      MIX.create_random_tag(card)
    end
  end,
}
