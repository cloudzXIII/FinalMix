SMODS.Joker {
  attributes = { "FinalMix" },
  key = 'cloudzxiii',

  loc_vars = function(self, info_queue, card)
    return {
      vars = {}
    }
  end,

  atlas = "KHJokers",
  pos = { x = 7, y = 7 },
  soul_pos = { x = 0, y = 8 },
  rarity = 2,
  cost = 5,
  blueprint_compat = true,

  config = {
    extra = {
    }
  },

  calculate = function(self, card, context)
  end,
  add_to_deck = function(self, card, from_debuff)
    if G.consumeables then
      G.consumeables.states.collide.can = true
    end
    if G.jokers then
      G.jokers.states.collide.can = true
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    if #SMODS.find_card("j_kh_cloudzxiii") > 0 then return end
    if G.consumeables then
      G.consumeables.states.collide.can = false
    end
    if G.jokers then
      G.jokers.states.collide.can = false
    end
  end
}
