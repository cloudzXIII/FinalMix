SMODS.Joker {
  attributes = { "reference", "FinalMix", },
  key = 'strelitzia',
  loc_vars = function(self, info_queue, card)
    return {
      vars = {}
    }
  end,

  atlas = "KHJokers",
  pos = { x = 9, y = 3 },
  rarity = 2,
  cost = 6,
  blueprint_compat = false,

  config = {
    extra = {
    }
  },

  calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint then
      local pos = MIX.get_pos(card, G.jokers.cards)
      local left = G.jokers.cards[pos - 1]
      local right = G.jokers.cards[pos + 1]
      if left and left.kh_keychain and right then
        local keychain = left.kh_keychain
        left.kh_keychain = nil
        left:juice_up(0.3, 0.5)

        local possibly_strelitzia = G.jokers.cards[pos + 2]
        local key = G.jokers.cards[pos + 2] and G.jokers.cards[pos + 2].config.center.key or nil
        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          func = (function()
            right:kh_set_keychain(keychain)
            right:juice_up(0.3, 0.5)
            -- yummers
            if key and key == "j_kh_strelitzia" then
              G.E_MANAGER:add_event(Event({
                trigger = 'after',
                func = (function()
                  possibly_strelitzia:calculate_joker({ setting_blind = true })
                  return true
                end)
              }))
            end
            return true
          end)
        }))
        SMODS.calculate_effect({ message = localize("k_kh_transferred_ex") }, card)
      end
    end
  end,
  in_pool = function(self, args)
    local has_keychain = false
    for _, joker in ipairs(G.jokers.cards or {}) do
      if joker.kh_keychain then
        has_keychain = true
      end
    end
    return has_keychain
  end
}
