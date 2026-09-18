SMODS.Joker {
  attributes = { "reference", "FinalMix", "hearts", "economy" },
  key = 'olette',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = {
        cae.dollars
      }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 0, y = 7 },
  rarity = 2,
  cost = 5,
  blueprint_compat = true,

  config = {
    extra = {
      dollars = 3
    }
  },

  calculate = function(self, card, context)
    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
      for i = 1, #G.hand.cards do
        if G.hand.cards[i]:is_suit("Hearts") then
          card:juice_up()
          SMODS.calculate_effect({ dollars = card.ability.extra.dollars }, G.hand.cards[i])
        end
      end
    end
  end,
}
