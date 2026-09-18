SMODS.Joker {
  attributes = { "reference", "FinalMix", "hand_type", "hands" },
  key = 'thtnw',

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        localize(MIX.most_played_hand(), 'poker_hands'),
      }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 8, y = 5 },
  rarity = 3,
  cost = 10,
  blueprint_compat = true,

  config = {
    extra = {}
  },

  calculate = function(self, card, context)
    if context.evaluate_poker_hand and G.GAME.current_round.hands_played == 0 then
      return {
        replace_scoring_name = MIX.most_played_hand()
      }
    end
  end,
}
