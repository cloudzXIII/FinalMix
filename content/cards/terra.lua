SMODS.Joker {
  attributes = { "reference", "FinalMix", "destroy_card", "hand_type" },
  key = 'terra',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = {
        cae.type
      }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 7, y = 3 },
  rarity = 1,
  cost = 6,
  blueprint_compat = false,

  config = {
    extra = {
      type = "Three of a Kind"
    }
  },

  calculate = function(self, card, context)
    if context.final_scoring_step and next(context.poker_hands[card.ability.extra.type]) then
      local card_to_destroy = pseudorandom_element(G.hand.cards, "kh_terra")
      SMODS.destroy_cards(card_to_destroy)
      SMODS.calculate_effect({ message = localize('k_kh_destroyed'), colour = G.C.RED }, card)
    end
  end,
}
