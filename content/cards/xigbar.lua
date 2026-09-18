SMODS.Joker {
  attributes = { "reference", "FinalMix", "xmult", "face" },
  key = 'xigbar',
  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = {
        cae.xmult,
      }
    }
  end,

  rarity = 2,
  atlas = 'KHJokers',
  pos = { x = 1, y = 1 },
  cost = 5,

  blueprint_compat = true,

  config = {
    extra = {
      xmult = 1.75
    }
  },

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      local faces = true
      for k, v in ipairs(context.full_hand) do
        if not v:is_face() then
          faces = false
        end
      end
      if faces then
        return {
          xmult = card.ability.extra.xmult
        }
      end
    end
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
  end
}
