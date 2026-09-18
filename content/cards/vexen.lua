SMODS.Joker {
  attributes = { "reference", "FinalMix", },
  key = 'vexen',
  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra

    local even_count = MIX.count_in_table(G.deck and G.deck.cards or {}, MIX.is_even)

    local highlighted_even = MIX.count_in_table(G.hand and G.hand.highlighted or {}, MIX.is_even)

    local chips = (cae.chips * even_count) - highlighted_even
    return {
      vars = {
        cae.chips,
        chips
      }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 9, y = 7 },
  rarity = 2,
  cost = 6,
  blueprint_compat = false,

  config = {
    extra = {
      chips = 2
    }
  },

  calculate = function(self, card, context)
    if context.before and not context.blueprint then
      local even_count = MIX.count_in_table(G.deck.cards, MIX.is_even)
      local evens_scored = MIX.count_in_table(context.full_hand, MIX.is_even)
      if even_count > 0 then
        for _, v in ipairs(context.full_hand) do
          if MIX.is_even(v) then
            v.ability.perma_bonus = (v.ability.perma_bonus or 0) +
                ((card.ability.extra.chips * even_count) - evens_scored)
            SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, v)
          end
        end
      end
    end
  end,
}
