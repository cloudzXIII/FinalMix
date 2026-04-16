SMODS.Joker {
  key = 'axel',
  loc_vars = function(self, info_queue, card)
    return { vars = {} }
  end,

  rarity = 3,
  atlas = 'KHJokers',
  pos = { x = 4, y = 2 },
  cost = 8,

  discovered = true,
  blueprint_compat = false,

  config = { extra = {} },

  update = function(self, card, dt)
    local condition = false
    if G.jokers and G.jokers.cards then
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i] == card then
          condition = true
        end
      end
    end
    if condition then
      if G.consumeables and G.consumeables.cards then
        for k, v in ipairs(G.consumeables.cards) do
          if v.config.center.set == "Planet" and not v.xiii_flipped then
            v:flip()
            v.xiii_flipped = true
          end
        end
      end
      if G.pack_cards and G.pack_cards.cards then
        for k, v in ipairs(G.pack_cards.cards) do
          if v.config.center.set == "Planet" and not v.xiii_flipped then
            v:flip()
            v.xiii_flipped = true
          end
        end
      end
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    if G.consumeables and G.consumeables.cards then
      for k, v in ipairs(G.consumeables.cards) do
        if v.config.center.set == "Planet" and v.xiii_flipped then
          v:flip()
          v.xiii_flipped = false
        end
      end
    end
  end,
}
local use_consumeable_ref = Card.use_consumeable
function Card:use_consumeable(area, copier)
  local g = use_consumeable_ref(self, area, copier)
  if next(SMODS.find_card('j_kh_axel')) then
    for k, v in pairs(SMODS.find_card('j_kh_axel')) and self.ability.set == "Planet" do
      SMODS.calculate_effect({ message = localize('k_again_ex') }, self)
      use_consumeable_ref(self, area, copier)
    end
  end
  return g
end
