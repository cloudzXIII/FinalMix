SMODS.Joker {
  attributes = { "reference", "FinalMix", },
  key = 'demyx',
  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = {
        cae.xmult,
        cae.cards_remaining,
        cae.cards
      }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 9, y = 5 },
  rarity = 2,
  cost = 6,
  blueprint_compat = true,

  config = {
    extra = {
      xmult = 4,
      cards_remaining = 0,
      cards = 4,
    }
  },

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      card.ability.extra.cards_remaining = card.ability.extra.cards_remaining + 1
      if card.ability.extra.cards_remaining >= card.ability.extra.cards then
        card.ability.extra.cards_remaining = 0
        return {
          xmult = card.ability.extra.xmult
        }
      end
    end
  end,
}
