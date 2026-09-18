-- This Joker is a reference to Mega64's video on Kingdom Hearts :D (https://www.youtube.com/watch?v=4YVTBQCbezQ&t=1s)

function MIX.reset_kh_bryce_card()
  G.GAME.current_round.kh_bryce_card = G.GAME.current_round.kh_bryce_card or { suit = 'Hearts' }
  local bryce_suits = {}
  for _, playing_card in ipairs(G.playing_cards) do
    if not SMODS.has_no_suit(playing_card) and playing_card.base.suit ~= G.GAME.current_round.kh_bryce_card.suit and not MIX.table_contains(bryce_suits, playing_card.base.suit) then
      bryce_suits[#bryce_suits + 1] = playing_card.base.suit
    end
  end
  local bryce_card = pseudorandom_element(bryce_suits, 'j_kh_bryce' .. G.GAME.round_resets.ante)
  G.GAME.current_round.kh_bryce_card.suit = bryce_card
end

SMODS.Joker {
  attributes = { "reference", "FinalMix", "perma_bonus", "suit" },
  key = 'brycethenobody',

  loc_vars = function(self, info_queue, card)
    local suit = (G.GAME.current_round.kh_bryce_card or {}).suit or 'Hearts'
    return {
      vars = {
        card.ability.extra.mult,
        localize(suit, 'suits_singular'),
        colours = { G.C.SUITS[suit] }
      }
    }
  end,

  rarity = 2,
  atlas = 'KHJokers',
  pos = { x = 6, y = 1 },
  cost = 5,

  blueprint_compat = true,
  config = {
    extra = {
      mult = 3,
    }
  },
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card:is_suit(G.GAME.current_round.kh_bryce_card.suit) then
        context.other_card.ability.perma_mult = (context.other_card.ability.perma_mult or 0) + card.ability.extra.mult
        SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.MULT }, context.other_card)
      end
    end
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", colour = G.C.MULT },
      },
      reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "bryce_card_suit" },
        { text = ")" }
      },
      calc_function = function(card)
        card.joker_display_values.bryce_card_suit = localize(G.GAME.current_round.kh_bryce_card.suit, 'suits_singular')
      end,
      style_function = function(card, text, reminder_text, extra)
        if reminder_text and reminder_text.children[2] then
          reminder_text.children[2].config.colour = lighten(G.C.SUITS[G.GAME.current_round.kh_bryce_card.suit], 0.35)
        end
        return false
      end
    }
  end
}
