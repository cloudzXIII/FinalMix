SMODS.Joker {
  attributes = { "reference", "FinalMix", "discard", "space" },
  key = "kingdomhearts",

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = {
        cae.discards_remaining,
      }
    }
  end,

  rarity = 3,
  cost = 8,
  atlas = 'KHJokers',
  pos = { x = 9, y = 2 },

  blueprint_compat = false,

  config = {
    extra = {
      discards_remaining = 0,
    }
  },

  calculate = function(self, card, context)
    if context.setting_blind and G.GAME.blind.boss then
      if card.ability.extra.discards_remaining > 0 then
        SMODS.calculate_effect(
          { message = "+" .. tostring(card.ability.extra.discards_remaining) .. " Discard", colour = G.C.RED }, card)
        G.GAME.current_round.discards_left = G.GAME.current_round.discards_left +
            card.ability.extra.discards_remaining
      end
    end
    if context.end_of_round and context.game_over == false and context.main_eval then
      if G.GAME.current_round.discards_left > 0 then
        card.ability.extra.discards_remaining = card.ability.extra.discards_remaining +
            G.GAME.current_round.discards_left
      end

      if G.GAME.blind.boss then
        card.ability.extra.discards_remaining = 0
        return {
          message = localize('k_reset'),
          colour = G.C.RED
        }
      end
    end
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        { ref_table = "card.ability.extra", ref_value = "discards_remaining", colour = G.C.MULT },
        { text = "Discards" },
      },
      reminder_text = {
        { text = "(" },
        { text = "Boss Blind" },
        { text = ")" },
      },
    }
  end
}
