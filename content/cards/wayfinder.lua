SMODS.Joker {
  attributes = { "reference", "FinalMix", "reroll" },
  key = 'wayfinder',

  loc_vars = function(self, info_queue, card)
    return {
      vars = {}
    }
  end,

  atlas = "KHJokers",
  pos = { x = 3, y = 6 },
  rarity = 3,
  cost = 5,
  blueprint_compat = true,

  config = {
    extra = {}
  },

  calculate = function(self, card, context)
    if context.reroll_shop and not context.blueprint then
      card:juice_up(0.3, 0.5)
      local consumables = {}
      for _, v in ipairs(G.consumeables.cards) do
        table.insert(consumables, v)
      end

      if #consumables > 0 then
        local pool = SMODS.get_clean_pool("Consumeables")

        for i, v in ipairs(consumables) do
          local percent = 1.15 - (i - 0.999) / (#consumables - 0.998) * 0.3
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
              v:flip()
              play_sound('card1', percent)
              v:juice_up(0.3, 0.3)
              return true
            end
          }))
        end

        for i, v in ipairs(consumables) do
          local new_key = pseudorandom_element(pool, "kh_wayfinder")
          G.E_MANAGER:add_event(Event({
            func = function()
              v:set_ability(G.P_CENTERS[new_key])
              local center = G.P_CENTERS[new_key]
              local slots_used = center.size == "XL" and 2 or center.size == "XS" and -1
              v.ability.extra_slots_used = slots_used or 0
              return true
            end
          }))
        end

        for i, v in ipairs(consumables) do
          local percent = 0.85 + (i - 0.999) / (#consumables - 0.998) * 0.3
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
              v:flip()
              play_sound('tarot2', percent, 0.6)
              v:juice_up(0.3, 0.3)
              return true
            end
          }))
        end

        delay(0.5)
      end
    end
  end,
}
