SMODS.Joker {
  attributes = { "reference", "retrigger", "hearts" },
  key = 'timeless_sora',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = {
        cae.mod,
      }
    }
  end,

  rarity = 3,
  atlas = 'KHJokers',
  pos = { x = 3, y = 3 },
  cost = 7,

  blueprint_compat = true,

  config = {
    extra = {
      repetitions = 0,
      mod = 1
    }
  },

  calculate = function(self, card, context)
    if context.before and not context.blueprint then
      local count = 0
      for _, v in ipairs(context.full_hand) do
        if v:is_suit("Hearts") then
          count = count + card.ability.extra.mod
        end
      end
      card.ability.extra.repetitions = count
    end
    if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[1] and card.ability.extra.repetitions > 0 then
      return {
        repetitions = card.ability.extra.repetitions
      }
    end
  end
}
