SMODS.Joker {
  attributes = { "reference", "FinalMix", "skip", "reset" },
  key = 'traverse_town',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = {
        cae.discount,
        cae.discount * cae.count,
      }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 6, y = 6 },
  rarity = 2,
  cost = 5,
  blueprint_compat = false,

  config = {
    extra = {
      discount = 25,
      count = 0
    }
  },

  calculate = function(self, card, context)
    if context.skip_blind then
      G.GAME.discount_percent = G.GAME.discount_percent + card.ability.extra.discount
      card.ability.extra.count = card.ability.extra.count + 1
      SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.FILTER }, card)
    end
    if context.ending_shop then
      G.GAME.discount_percent = G.GAME.discount_percent - (card.ability.extra.discount * card.ability.extra.count)
      card.ability.extra.count = 0
      SMODS.calculate_effect({ message = localize('k_reset'), colour = G.C.FILTER }, card)
    end
  end,
}
