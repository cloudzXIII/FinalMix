SMODS.Joker {
  attributes = { "reference", "FinalMix", "economy" },
  key = 'hayner',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = {
        cae.dollars
      }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 8, y = 6 },
  rarity = 1,
  cost = 5,
  blueprint_compat = true,

  config = {
    extra = {
      dollars = 5,
    }
  },

  calculate = function(self, card, context)
    if context.selling_card and context.card.ability.set == "Joker" then
      return {
        dollars = card.ability.extra.dollars
      }
    end
  end,
}
