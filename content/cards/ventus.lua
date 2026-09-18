SMODS.Joker {
  attributes = { "reference", "FinalMix", "discard", "economy" },
  key = 'ventus',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    local extra_cards = math.floor((G.GAME.dollars or 0) / cae.dollars)
    return {
      vars = {
        1,
        extra_cards,
        cae.dollars
      }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 2, y = 4 },
  rarity = 2,
  cost = 5,
  blueprint_compat = false,

  config = {
    extra = {
      dollars = 15,
      draw_now = false
    }
  },

  calculate = function(self, card, context)
    if context.discard and G.GAME.current_round.discards_used == 0 then
      card.ability.extra.draw_now = true
    end
    if context.hand_drawn and card.ability.extra.draw_now then
      card.ability.extra.draw_now = false
      local extra_cards = math.floor(G.GAME.dollars / card.ability.extra.dollars)
      if extra_cards > 0 then
        G.E_MANAGER:add_event(Event({
          blocking = false,
          func = function()
            SMODS.draw_cards(extra_cards)
            return true
          end
        }))
      end
    end
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "count", },
        { text = "extra cards" },
      },
      calc_function = function(card)
        local _, _, scoring_hand = JokerDisplay.evaluate_hand()
        local extra_cards = math.floor(G.GAME.dollars / card.ability.extra.dollars)
        local ventus_eval = #scoring_hand > 0 and extra_cards > 0
        card.joker_display_values.active = G.GAME.current_round.discards_used == 0
        card.joker_display_values.count = ventus_eval and extra_cards or 0
      end,
      style_function = function(card, text, reminder_text, extra)
        if text and text.children[1] and text.children[2] then
          text.children[1].config.colour = card.joker_display_values.active and G.C.FILTER or
              G.C.UI.TEXT_INACTIVE
          text.children[2].config.colour = card.joker_display_values.active and G.C.FILTER or
              G.C.UI.TEXT_INACTIVE
        end
      end
    }
  end
}
