SMODS.Joker {
  attributes = { "reference", "FinalMix", "scaling", "chips" },
  key = 'zexion',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = {
        cae.chips,
        cae.chips_gain
      }
    }
  end,

  rarity = 2,
  atlas = 'KHJokers',
  pos = { x = 1, y = 6 },
  cost = 5,

  blueprint_compat = true,

  config = {
    extra = {
      chips = 0,
      chips_gain = 13
    }
  },

  calculate = function(self, card, context)
    if context.before and not context.blueprint and G.GAME.current_round.hands_played == 0 then
      local suits = {}
      for _, v in ipairs(context.scoring_hand) do
        suits[v.base.suit] = true
      end

      local unique_suits = MIX.count_in_table(suits)

      local total = unique_suits * card.ability.extra.chips_gain

      SMODS.scale_card(card, {
        ref_table = card.ability.extra,
        ref_value = "chips",
        scalar_value = "chips_gain",
        operation = function(ref_table, ref_value, initial, change)
          ref_table[ref_value] = initial + total * change
        end,
        no_message = true
      })
      return {
        message = localize { type = 'variable', key = 'a_chips',
          vars = { card.ability.extra.chips }
        }
      }
    end

    if context.joker_main then
      return {
        chips = card.ability.extra.chips
      }
    end
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS },
      },
      reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "suit_count" },
        { text = " suits", scale = 0.35, },
        { text = ")" },
      },
      calc_function = function(card)
        local d = card.joker_display_values
        local extra = card.ability.extra

        -- Default values
        d.chips = extra.total_chips
        d.suit_count = 0

        local _, _, scoring_hand = JokerDisplay.evaluate_hand()
        if scoring_hand then
          local suits = {}
          for _, v in ipairs(scoring_hand) do
            if v.base and v.base.suit then
              suits[v.base.suit] = true
            end
          end

          local unique_suits = 0
          for _ in pairs(suits) do
            unique_suits = unique_suits + 1
          end

          d.suit_count = unique_suits
        end

        card.joker_display_values.active = G.GAME and G.GAME.current_round.hands_played == 0
      end,
      style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[1] and reminder_text.children[2] and reminder_text.children[3] and reminder_text.children[4] then
          reminder_text.children[1].config.colour = card.joker_display_values.active and G.C.CHIPS or
              G.C.UI.TEXT_INACTIVE
          reminder_text.children[2].config.colour = card.joker_display_values.active and G.C.CHIPS or
              G.C.UI.TEXT_INACTIVE
          reminder_text.children[3].config.colour = card.joker_display_values.active and G.C.CHIPS or
              G.C.UI.TEXT_INACTIVE
          reminder_text.children[4].config.colour = card.joker_display_values.active and G.C.CHIPS or
              G.C.UI.TEXT_INACTIVE
        end
        return false
      end
    }
  end
}
