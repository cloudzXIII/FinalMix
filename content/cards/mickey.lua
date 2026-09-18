SMODS.Joker {
  attributes = { "reference", "FinalMix", "rank", "discard", "perma_bonus" },
  key = 'mickey',
  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = {
        cae.mult_gain
      }
    }
  end,

  rarity = 3,
  atlas = 'KHJokers',
  pos = { x = 3, y = 0 },
  cost = 8,

  blueprint_compat = false,
  config = {
    extra = {
      mult_gain = 3
    }
  },

  calculate = function(self, card, context)
    if context.pre_discard and not context.blueprint then
      for _, v in ipairs(context.full_hand) do
        if v:get_id() == 13 then
          v.ability.perma_mult = (v.ability.perma_mult or 0) +
              card.ability.extra.mult_gain
          SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.MULT }, v)
        end
      end
    end
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
  end
}
