function MIX.reset_kh_heartless_card()
  G.GAME.current_round.kh_heartless_card = { rank = 'Ace', suit = 'Spades' }
  local valid_heartless_cards = {}
  for _, playing_card in ipairs(G.playing_cards) do
    if not SMODS.has_no_suit(playing_card) and not SMODS.has_no_rank(playing_card) then
      valid_heartless_cards[#valid_heartless_cards + 1] = playing_card
    end
  end
  local heartless_card = pseudorandom_element(valid_heartless_cards, 'kh_heartless' .. G.GAME.round_resets.ante)
  if heartless_card then
    G.GAME.current_round.kh_heartless_card.rank = heartless_card.base.value
    G.GAME.current_round.kh_heartless_card.suit = heartless_card.base.suit
    G.GAME.current_round.kh_heartless_card.id = heartless_card.base.id
  end
end

SMODS.Joker {
  attributes = { "reference", "FinalMix", "rank", "suit" },
  key = "heartless",

  loc_vars = function(self, info_queue, card)
    local heartless_card = G.GAME.current_round.kh_heartless_card or { rank = 'King', suit = 'Hearts' }
    return { vars = { localize(heartless_card.rank, 'ranks'), localize(heartless_card.suit, 'suits_plural'), colours = { G.C.SUITS[heartless_card.suit] } } }
  end,


  rarity = 2,
  atlas = 'KHJokers',
  pos = { x = 5, y = 3 },
  cost = 6,

  blueprint_compat = true,

  config = {
    extra = {
    },
  },
  calculate = function(self, card, context)
    if context.after and context.main_eval and not context.blueprint then
      MIX.reset_kh_heartless_card()
    end
  end
}

local oldsmodsscorecard = SMODS.score_card
function SMODS.score_card(card, context)
  if not G.scorehand and next(SMODS.find_card("j_kh_heartless")) and context.cardarea == G.hand then
    G.scorehand = true
    context.cardarea = G.play

    if not SMODS.has_no_rank(card) and not SMODS.has_no_suit(card) and SMODS.Ranks[G.GAME.current_round.kh_heartless_card.rank].id == card:get_id() and card:is_suit(G.GAME.current_round.kh_heartless_card.suit) then
      SMODS.score_card(card, context)
    end

    context.cardarea = G.hand
    G.scorehand = nil
  end
  return oldsmodsscorecard(card, context)
end
