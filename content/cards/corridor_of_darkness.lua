SMODS.Joker {
  attributes = { "reference", "FinalMix", "chance", "destroy_card", "discard" },
  key = 'corridor_of_darkness',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    local numerator, denominator = SMODS.get_probability_vars(card, cae.base, cae.odds)

    return {
      vars = {
        numerator,
        denominator
      }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 0, y = 6 },
  rarity = 3,
  cost = 7,
  blueprint_compat = true,

  config = {
    extra = {
      base = 1,
      odds = 4
    }
  },

  calculate = function(self, card, context)
    if context.discard then
      if SMODS.pseudorandom_probability(card, 'kh_corridor_of_darkness', 1, card.ability.extra.odds) then
        return {
          remove = true
        }
      end
    end
  end,
}
