SMODS.Joker {
  attributes = { "reference", "FinalMix", "joker" },
  key = "invitation",

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
      }
    }
  end,

  rarity = 2,
  cost = 6,
  atlas = 'KHJokers',
  pos = { x = 7, y = 2 },

  blueprint_compat = false,

  config = { extra = {} },

  calculate = function(self, card, context)
    if context.starting_shop then
      local edition = SMODS.poll_edition({ guaranteed = true, no_negative = true, key = "kh_invitation" })
      SMODS.calculate_effect({ message = localize('k_kh_challenger'), colour = G.C.FILTER }, card)
      SMODS.add_card { set = "Joker", rarity = "Common", edition = edition }
    end
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      -- Definition
    }
  end
}
