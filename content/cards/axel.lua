SMODS.Joker {
  attributes = { "reference", "FinalMix", },
  key = 'axel',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    local numerator, denominator = SMODS.get_probability_vars(card, cae.base, cae.odds,
      'axel1')
    return {
      vars = {
        numerator,
        denominator,
      }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 4, y = 1 },
  rarity = 2,
  cost = 5,
  blueprint_compat = true,

  config = {
    extra = {
      base = 1,
      odds = 2
    }
  },

  calculate = function(self, card, context)
    if context.modify_shop_card and context.card.ability.set == "Joker" and SMODS.pseudorandom_probability(card, 'axel', card.ability.extra.base, card.ability.extra.odds, 'axel1') then
      context.card.ability.axeled = true
      G.E_MANAGER:add_event(Event({
        trigger = 'before',
        func = function()
          context.card:flip()
          return true
        end
      }))
    end
  end,
}

local set_cost_ref = Card.set_cost_value
---@diagnostic disable-next-line: duplicate-set-field
function Card:set_cost_value(...)
  local ret = set_cost_ref(self, ...)
  if next(SMODS.find_card("j_kh_axel")) and self.ability.axeled then
    self.cost = math.floor(self.cost / 2)
  end
  return ret
end
