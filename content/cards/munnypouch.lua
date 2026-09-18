SMODS.Joker {
  attributes = { "reference", "FinalMix", "chance", "sell_value", "scaling", },
  key = 'munnypouch',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    local numerator, denominator = SMODS.get_probability_vars(card, cae.base, cae.odds,
      'munnypouch1')
    return {
      vars = {
        numerator,
        denominator,
        cae.price1,
        cae.price2,
      }
    }
  end,
  rarity = 2,
  atlas = "KHJokers",
  pos = { x = 4, y = 2 },
  cost = 5,

  blueprint_compat = false,
  eternal_compat = false,

  config = {
    extra = {
      base = 1,
      odds = 8,
      price = 1,
      price1 = 1,
      price2 = 5,
    }
  },

  calculate = function(self, card, context)
    if context.end_of_round and context.game_over == false and not context.blueprint then
      if SMODS.pseudorandom_probability(card, 'munnypouch', card.ability.extra.base, card.ability.extra.odds, 'munnypouch1') then
        G.E_MANAGER:add_event(Event({
          func = function()
            play_sound('tarot1')
            card.T.r = -0.2
            card:juice_up(0.3, 0.4)
            card.states.drag.is = true
            card.children.center.pinch.x = true
            G.E_MANAGER:add_event(Event({
              trigger = 'after',
              delay = 0.3,
              blockable = false,
              func = function()
                G.jokers:remove_card(card)
                card:remove()
                card = nil
                return true;
              end
            }))
            return true
          end
        }))
        -- Extinct/Survival Message
        SMODS.calculate_effect({ message = localize('k_kh_stolen'), colour = G.C.FILTER }, card)
      else
        card.ability.extra.price = pseudorandom('cool', card.ability.extra.price1, card.ability.extra.price2)
        card.ability.extra_value = card.ability.extra_value + card.ability.extra.price
        card:set_cost()
        SMODS.calculate_effect({ message = localize('k_val_up'), colour = G.C.MONEY }, card)
      end
    end
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        { text = "+$", colour = G.C.MONEY, },
        {
          ref_table = "card",
          ref_value = "sell_cost",
          scale = 0.40,
          colour = G.C.MONEY,
        }
      },
      extra = {
        {
          { text = "(" },
          { ref_table = "card.joker_display_values", ref_value = "odds" },
          { text = ")" },
        }
      },
      extra_config = { colour = G.C.RED, scale = 0.3 },
      calc_function = function(card)
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { card.ability.extra.base, card.ability.extra.odds } }
      end
    }
  end
}
