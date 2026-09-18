SMODS.Joker {
  attributes = { "reference", "FinalMix", "generation" },
  key = 'gummiship',

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
      }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 3, y = 4 },
  rarity = 2,
  cost = 6,
  blueprint_compat = false,

  config = {
    extra = {
      triggered = false,
    }
  },
  can_use = function(self, card)
    return G.STATE == G.STATES.BLIND_SELECT and not card.ability.extra.triggered
  end,

  use = function(self, card, area, copier)
    MIX.send_to_blind(get_new_boss())
    card.ability.extra.triggered = true
  end,
  calculate = function(self, card, context)
    if context.ante_change and context.ante_end then
      SMODS.calculate_effect({ message = localize("k_reset") }, card)
      card.ability.extra.triggered = false
    end
    if context.modify_final_cashout and G.GAME.blind_on_deck == "kh_Special" then
      return {
        modify = context.amount
      }
    end
  end,
}
