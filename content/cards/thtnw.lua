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
  rarity = 2,
  cost = 6,
  blueprint_compat = true,

  config = {
    extra = {}
  },

  calculate = function(self, card, context)
    if context.poker_hands and context.scoring_hand then
      if not next(context.poker_hands[MIX.most_played_hand()]) then
        table.insert(context.poker_hands[MIX.most_played_hand()], context.scoring_hand)
      end
    end
  end,
}
