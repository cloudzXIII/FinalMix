SMODS.Joker {
  attributes = { "reference", "FinalMix" },
  key = 'better_weapon',

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.xmult
      }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 6, y = 7 },
  rarity = 2,
  cost = 5,
  blueprint_compat = true,

  config = {
    extra = {
      active = false,
      xmult = 3
    }
  },

  calculate = function(self, card, context)
    if context.using_consumeable then
      card.ability.extra.active = true
      local eval = function() return card.ability.extra.active end
      MIX.kh_juice_until(card, eval, true)
      SMODS.calculate_effect({ message = localize("k_active_ex") }, card)
    end
    if context.joker_main and card.ability.extra.active then
      return {
        xmult = card.ability.extra.xmult
      }
    end
    if context.after and context.main_eval and not context.blueprint then
      card.ability.extra.active = false
      SMODS.calculate_effect({ message = localize("k_reset") }, card)
    end
  end,
}
