SMODS.Joker {
  attributes = { "reference", "FinalMix", "economy", "joker_slot", "joker" },
  key = 'moogle',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    local joker_count = 0
    if G.jokers and G.jokers.cards then
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].ability.set == 'Joker' then
          joker_count = joker_count + 1
        end
      end
    end
    return {
      vars = {
        cae.dollars,
        cae.dollars * joker_count
      }
    }
  end,

  rarity = 1,
  atlas = 'KHJokers',
  pos = { x = 2, y = 2 },
  cost = 5,

  blueprint_compat = false,

  config = {
    extra = {
      dollars = 1
    }
  },

  calc_dollar_bonus = function(self, card)
    local joker_count = 0
    if G.jokers and G.jokers.cards then
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].ability.set == 'Joker' then
          joker_count = joker_count + 1
        end
      end
    end
    return card.ability.extra.dollars * joker_count
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        { text = "+$", colour = G.C.MONEY, },
        {
          ref_table = "card.joker_display_values",
          ref_value = "joker_count",
          scale = 0.40,
          colour = G.C.MONEY,
        }
      },
      reminder_text = {
        { text = "(Round)" }
      },
      calc_function = function(card)
        card.joker_display_values.joker_count = (G.jokers and G.jokers.cards and #G.jokers.cards or 0) *
            card.ability.extra.dollars
      end
    }
  end
}
