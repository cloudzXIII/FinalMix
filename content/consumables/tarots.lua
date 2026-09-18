SMODS.Consumable {
  key = 'creation',
  set = 'Tarot',
  atlas = "KHConsumables",
  pos = { x = 1, y = 0 },
  cost = 5,

  use = function(self, card, area, copier)
    local used_card = copier or card

    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('timpani')
        SMODS.add_card { set = "Joker", attributes = { "FinalMix" }, }
        used_card:juice_up(0.3, 0.5)
        return true
      end
    }))

    delay(0.6)
  end,

  can_use = function(self, card)
    return G.jokers and #G.jokers.cards < G.jokers.config.card_limit
  end
}

SMODS.Consumable {
  key = 'awakening',
  set = 'Tarot',
  atlas = "KHConsumables",
  pos = { x = 0, y = 0 },
  cost = 5,
  config = { max_highlighted = 2, mod_conv = 'm_kh_kingdomkey' },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
    return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
  end,
}

SMODS.Consumable {
  key = 'remind',
  set = 'Tarot',
  atlas = "KHConsumables",
  pos = { x = 3, y = 0 },
  cost = 5,
  config = { max_highlighted = 1, mod_conv = 'm_kh_recard' },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.mod_conv]
    return { vars = { card.ability.max_highlighted, localize { type = 'name_text', set = 'Enhanced', key = card.ability.mod_conv } } }
  end,
}
