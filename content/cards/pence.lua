SMODS.Joker {
  attributes = { "reference", "FinalMix", "enhancements" },
  key = 'pence',

  loc_vars = function(self, info_queue, card)
    return {
      vars = {}
    }
  end,

  atlas = "KHJokers",
  pos = { x = 9, y = 6 },
  rarity = 3,
  cost = 8,
  blueprint_compat = true,

  config = {
    extra = {}
  },

  calculate = function(self, card, context)
    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.4,
        func = function()
          play_sound('tarot1')
          card:juice_up(0.3, 0.5)
          return true
        end
      }))
      for i = 1, #G.hand.cards do
        if G.hand.cards[i].config.center == G.P_CENTERS.c_base then
          local percent = 1.15 - (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
              G.hand.cards[i]:flip()
              play_sound('card1', percent)
              G.hand.cards[i]:juice_up(0.3, 0.3)
              return true
            end
          }))
        end
      end
      for i = 1, #G.hand.cards do
        if G.hand.cards[i].config.center == G.P_CENTERS.c_base then
          G.E_MANAGER:add_event(Event({
            func = function()
              local _card = G.hand.cards[i]
              local enhancement = SMODS.poll_enhancement { key = "kh_seed", guaranteed = true }
              _card:set_ability(enhancement, true)
              return true
            end
          }))
        end
      end
      for i = 1, #G.hand.cards do
        if G.hand.cards[i].config.center == G.P_CENTERS.c_base then
          local percent = 0.85 + (i - 0.999) / (#G.hand.cards - 0.998) * 0.3
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
              G.hand.cards[i]:flip()
              play_sound('tarot2', percent, 0.6)
              G.hand.cards[i]:juice_up(0.3, 0.3)
              return true
            end
          }))
        end
      end
      delay(0.5)
    end
  end,
}
