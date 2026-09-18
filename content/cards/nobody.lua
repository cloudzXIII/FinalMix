SMODS.Joker {
  attributes = { "reference", "FinalMix", "chance", "retrigger" },
  key = "nobody",

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
      }
    }
  end,


  rarity = 4,
  atlas = 'KHJokers',
  pos = { x = 5, y = 0 },
  soul_pos = { x = 0, y = 1, },
  cost = 10,
  unlocked = false,

  blueprint_compat = true,

  config = {
    extra = {
    },
  },
}

local oldsmodsscorecard = SMODS.score_card
function SMODS.score_card(card, context)
  if not G.scorehand and next(SMODS.find_card("j_kh_nobody")) and context.cardarea == G.hand then
    G.scorehand = true
    context.cardarea = G.play
    SMODS.score_card(card, context)

    context.cardarea = G.hand
    G.scorehand = nil
  end
  return oldsmodsscorecard(card, context)
end
