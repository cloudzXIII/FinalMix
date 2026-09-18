SMODS.Joker {
  attributes = { "reference", "FinalMix", "chips" },
  key = 'jiminy_journal',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = { cae.chips, cae.chips * G.GAME.round }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 1, y = 7 },
  rarity = 1,
  cost = 4,
  blueprint_compat = true,

  config = {
    extra = {
      chips = 4
    }
  },

  calculate = function(self, card, context)
    if context.joker_main then
      return {
        chips = card.ability.extra.chips * G.GAME.round
      }
    end
  end,
}
