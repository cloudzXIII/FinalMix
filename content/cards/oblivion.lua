SMODS.Joker {
  attributes = { "reference", "FinalMix", "hearts" },
  key = 'oblivion',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = { cae.mult }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 3, y = 5 },
  rarity = 1,
  cost = 4,
  discovered = false,
  blueprint_compat = true,

  config = {
    extra = {
      mult = 5
    }
  },

  calculate = function(self, card, context)
    if context.stay_flipped and context.to_area == G.hand and context.other_card:is_suit("Hearts") then
      return {
        stay_flipped = true
      }
    end
    if context.kh_play_cards then
      for i = 1, #G.hand.highlighted do
        if G.hand.highlighted[i].facing == 'back' then
          G.hand.highlighted[i].oblivion_flipped = true
        end
      end
    end
    if context.individual and context.cardarea == "unscored" and context.other_card and context.other_card.oblivion_flipped then
      context.other_card.oblivion_flipped = nil
      return {
        mult = card.ability.extra.mult,
        card = card
      }
    end
  end,
}
