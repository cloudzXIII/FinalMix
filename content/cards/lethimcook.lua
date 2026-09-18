SMODS.Joker {
  attributes = { "reference", "FinalMix", "retrigger" },
  key = 'lethimcook',

  rarity = 3,
  atlas = 'cooking',
  pos = { x = 0, y = 0 },
  cost = 10,

  blueprint_compat = false,

  config = { extra = {} },
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {

    }
  end
}
function MIX.shuffle_cards(table, seed)
  seed = seed or 'shuffley'
  local ret = {}
  for i = 1, #table do
    ret[#ret + 1] = table[i]
  end
  pseudoshuffle(ret, pseudoseed(seed))
  return ret
end

local calc_main_scoring_ref = SMODS.calculate_main_scoring
---@diagnostic disable-next-line: duplicate-set-field
function SMODS.calculate_main_scoring(context, scoring_hand)
  if context.cardarea == G.play and next(SMODS.find_card('j_kh_lethimcook')) then
    -- call normal scoring
    calc_main_scoring_ref(context, scoring_hand)

    local original_cardarea = context.cardarea
    local original_scoring_hand = context.scoring_hand

    -- call scoring again in a random order
    if SMODS.calculate_round_score() < G.GAME.blind.chips then
      for _, joker in ipairs(SMODS.find_card('j_kh_lethimcook')) do
        local rnd_order = MIX.shuffle_cards(scoring_hand, "randomiser")
        context.cardarea = { cards = rnd_order }
        context.scoring_hand = rnd_order
        SMODS.calculate_effect({ message = localize('k_kh_rescore_ex'), colour = G.C.SECONDARY_SET.Enhanced }, joker)
        calc_main_scoring_ref(context, rnd_order)
      end
    end

    -- make it back to normal
    context.cardarea = original_cardarea
    context.scoring_hand = original_scoring_hand

    return
  end

  return calc_main_scoring_ref(context, scoring_hand)
end
