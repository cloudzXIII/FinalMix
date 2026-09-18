SMODS.Joker {
  attributes = { "reference", "FinalMix", "discard" },
  key = 'vanitas',

  loc_vars = function(self, info_queue, card)
    return {
      vars = {}
    }
  end,

  atlas = "KHJokers",
  pos = { x = 5, y = 7 },
  rarity = 2,
  cost = 5,
  blueprint_compat = false,

  config = {
    extra = {
    }
  },

  calculate = function(self, card, context)
    if context.pre_discard and G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
      SMODS.calculate_effect({ message = localize("k_kh_discard") }, card)
      local hand_count = #G.hand.cards
      for i = 1, hand_count do
        draw_card(G.hand, G.discard, i * 100 / hand_count, 'down', nil, nil, 0.07)
      end
    end
  end,
}
