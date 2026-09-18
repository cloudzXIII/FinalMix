SMODS.Joker {
  attributes = { "reference", "FinalMix", "passive" },
  key = 'soras_gloving',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = { cae.choices }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 2, y = 7 },
  rarity = 1,
  cost = 5,
  blueprint_compat = false,

  config = {
    extra = {
      choices = 1
    }
  },

  add_to_deck = function(self, card, from_debuff)
    G.GAME.modifiers.booster_choice_mod = (G.GAME.modifiers.booster_choice_mod or 0) + card.ability.extra.choices
  end,

  remove_from_deck = function(self, card, from_debuff)
    G.GAME.modifiers.booster_choice_mod = (G.GAME.modifiers.booster_choice_mod or 0) - card.ability.extra.choices
  end,
}
