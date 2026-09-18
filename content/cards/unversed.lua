local has_any_suit_ref = SMODS.has_any_suit
---@diagnostic disable-next-line: duplicate-set-field
function SMODS.has_any_suit(card)
  if next(SMODS.find_card("j_kh_unversed")) and card.base.suit == G.GAME.current_round.kh_unversed_card.suit then
    return true
  end
  return has_any_suit_ref(card)
end

function MIX.reset_unversed_card()
  G.GAME.current_round.kh_unversed_card = G.GAME.current_round.kh_unversed_card or { suit = 'Hearts' }
  local unversed_suits = {}
  for _, playing_card in ipairs(G.playing_cards) do
    if not SMODS.has_no_suit(playing_card) and playing_card.base.suit ~= G.GAME.current_round.kh_unversed_card.suit and not MIX.table_contains(unversed_suits, playing_card.base.suit) then
      unversed_suits[#unversed_suits + 1] = playing_card.base.suit
    end
  end
  local unversed_card = pseudorandom_element(unversed_suits, 'j_kh_unversed' .. G.GAME.round_resets.ante)
  G.GAME.current_round.kh_unversed_card.suit = unversed_card
end

SMODS.Joker {
  attributes = { "reference", "FinalMix", "suit" },
  key = 'unversed',

  loc_vars = function(self, info_queue, card)
    local suit = (G.GAME.current_round.kh_unversed_card or {}).suit or 'Hearts'
    return {
      vars = {
        localize(suit, 'suits_plural'),
        colours = { G.C.SUITS[suit] }
      }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 4, y = 6 },
  rarity = 2,
  cost = 5,
  blueprint_compat = true,

  config = {
    extra = {
      suit = "Hearts"
    }
  },

  calculate = function(self, card, context)
  end,
}
