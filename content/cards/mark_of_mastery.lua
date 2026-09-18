SMODS.Joker {
  attributes = { "reference", "FinalMix", "mult", "enhancements" },
  key = 'mark_of_mastery',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = {
        cae.mult
      }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 4, y = 7 },
  rarity = 2,
  cost = 5,
  blueprint_compat = true,

  config = {
    extra = {
      mult = 6
    }
  },

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card.ability.set == "Enhanced" then
        return {
          mult = card.ability.extra.mult
        }
      end
    end
  end,
  in_pool = function(self, args)
    for _, v in ipairs(G.playing_cards or {}) do
      if v.ability.set == "Enhanced" then
        return true
      end
    end
    return false
  end
}
