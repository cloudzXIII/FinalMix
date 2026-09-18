SMODS.Seal {
  key = "kingdom",
  badge_colour = HEX("e83d6d"),
  atlas = "KHSeals",
  pos = { x = 1, y = 0 },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
      }
    }
  end,

  config = {
    extra = {
    }
  },
  calculate = function(self, card, context)
    if context.discard and context.other_card == card and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
      G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
      G.E_MANAGER:add_event(Event({
        trigger = 'before',
        delay = 0.0,
        func = function()
          SMODS.add_card({ set = 'kh_keyblade' })
          G.GAME.consumeable_buffer = 0
          return true
        end
      }))
      return { message = localize('k_kh_plus_keyblade'), colour = G.C.SECONDARY_SET.kh_keyblade }
    end
  end,
}

SMODS.Seal {
  key = "luckyemblem",
  badge_colour = HEX("fab950"),
  atlas = "KHSeals",
  pos = { x = 0, y = 0 },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
      }
    }
  end,

  config = {
    extra = {
    }
  },

  calculate = function(self, card, context)
    if context.main_scoring and context.cardarea == G.play then
      local valid_cards = {}
      for _, c in ipairs(G.hand.cards) do
        if not c.lucky_chosen then
          table.insert(valid_cards, c)
        end
      end

      if #valid_cards > 0 then
        local chosen = pseudorandom_element(valid_cards, "kh_luckyemblem")
        chosen.lucky_chosen = true

        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.4,
          func = function()
            play_sound('tarot1')
            chosen:juice_up(0.3, 0.5)
            return true
          end
        }))

        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.15,
          func = function()
            chosen:flip()
            play_sound('card1', 1)
            chosen:juice_up(0.3, 0.3)
            return true
          end
        }))

        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.1,
          func = function()
            assert(SMODS.change_base(chosen, card.base.suit, card.base.value))
            return true
          end
        }))

        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.15,
          func = function()
            chosen:flip()
            play_sound('tarot2', 1, 0.6)
            chosen:juice_up(0.3, 0.3)
            return true
          end
        }))

        delay(0.5)
      end
    end
  end
}
