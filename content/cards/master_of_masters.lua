function MIX.reset_kh_mom_card()
  G.GAME.current_round.kh_mom_card = { rank = 'Ace' }
  local valid_mom_cards = {}
  for _, playing_card in ipairs(G.playing_cards) do
    if not SMODS.has_no_rank(playing_card) then
      valid_mom_cards[#valid_mom_cards + 1] = playing_card
    end
  end
  local mom_card = pseudorandom_element(valid_mom_cards, 'kh_mom' .. G.GAME.round_resets.ante)
  if mom_card then
    G.GAME.current_round.kh_mom_card.rank = mom_card.base.value
  end
end

SMODS.Joker {
  attributes = { "reference", "FinalMix", "rank", "xmult", "full_deck" },
  key = "master_of_masters",

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    local mom_card = G.GAME.current_round.kh_mom_card or { rank = 'Ace' }
    local rank_tally = 0
    if G.playing_cards then
      for _, playing_card in ipairs(G.playing_cards) do
        if playing_card.base.value == mom_card.rank then rank_tally = rank_tally + 1 end
      end
    end
    return { vars = { cae.xmult, localize(mom_card.rank, 'ranks'), 1 + (cae.xmult * rank_tally) } }
  end,


  rarity = 2,
  atlas = 'KHJokers',
  pos = { x = 6, y = 3 },
  cost = 6,

  blueprint_compat = true,

  config = {
    extra = {
      xmult = 0.25
    },
  },
  calculate = function(self, card, context)
    if context.joker_main then
      local rank_tally = 0
      if G.playing_cards then
        for _, playing_card in ipairs(G.playing_cards) do
          if playing_card.base.value == G.GAME.current_round.kh_mom_card.rank then
            rank_tally = rank_tally +
                1
          end
        end
      end
      return {
        x_mult = 1 + (card.ability.extra.xmult * rank_tally)
      }
    end
  end
}
