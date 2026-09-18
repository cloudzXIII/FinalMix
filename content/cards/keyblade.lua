function MIX.reset_keyblade_rank()
  G.GAME.current_round.keyblade_rank = { rank = 'Seven', }
  local valid_keyblade_cards = {}
  for _, playing_card in ipairs(G.playing_cards) do
    if not SMODS.has_no_rank(playing_card) then
      valid_keyblade_cards[#valid_keyblade_cards + 1] = playing_card
    end
  end
  local keyblade_card = pseudorandom_element(valid_keyblade_cards, 'j_kh_keyblade' .. G.GAME.round_resets.ante)
  if keyblade_card then
    G.GAME.current_round.keyblade_rank.rank = keyblade_card.base.value
    G.GAME.current_round.keyblade_rank.id = keyblade_card.base.id
  end
end

SMODS.Joker {
  attributes = { "reference", "FinalMix", "rank", "generation", "tag" },
  key = 'keyblade',

  loc_vars = function(self, info_queue, card)
    local keyblade_card = G.GAME.current_round.keyblade_rank or { rank = 'Seven' }
    local key = localize(keyblade_card.rank, 'ranks')
    return {
      vars = {
        G.GAME.current_round.keyblade_rank and key or 7
      }
    }
  end,

  rarity = 1,
  atlas = 'KHJokers',
  pos = { x = 6, y = 0 },
  cost = 4,

  blueprint_compat = false,

  config = {},

  calculate = function(self, card, context)
    if context.first_hand_drawn and not context.blueprint then
      local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
      juice_card_until(card, eval, true)
    end
    if context.destroy_card and not context.blueprint then
      local keyblade_card = G.GAME.current_round.keyblade_rank.rank or { rank = 'Seven' }
      if #context.full_hand == 1 and context.destroy_card == context.full_hand[1] and context.full_hand[1].base.value == keyblade_card and G.GAME.current_round.hands_played == 0 then
        MIX.create_random_tag(card)
        return { remove = true }
      end
    end
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "count", retrigger_type = "mult" }
      },
      reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "keyblade_card", scale = 0.35 },
        { text = ")" },
      },
      calc_function = function(card)
        local _, _, scoring_hand = JokerDisplay.evaluate_hand()
        local keyblade_eval = #scoring_hand == 1 and scoring_hand[1]:get_id() == G.GAME.current_round.keyblade_rank.id
        card.joker_display_values.active = G.GAME and G.GAME.current_round.hands_played == 0
        card.joker_display_values.count = keyblade_eval and 1 or 0
        card.joker_display_values.keyblade_card = localize(G.GAME.current_round.keyblade_rank.rank, 'ranks')
      end,
      style_function = function(card, text, reminder_text, extra)
        if text and text.children[1] and text.children[2] then
          text.children[1].config.colour = card.joker_display_values.active and G.C.SECONDARY_SET.Spectral or
              G.C.UI.TEXT_INACTIVE
          text.children[2].config.colour = card.joker_display_values.active and G.C.SECONDARY_SET.Spectral or
              G.C.UI.TEXT_INACTIVE
        end
        return false
      end
    }
  end
}
