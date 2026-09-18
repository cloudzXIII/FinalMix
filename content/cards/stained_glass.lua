SMODS.Joker {
  attributes = { "reference", "FinalMix", "enhancements", "generation" },
  key = 'stained_glass',

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
    return {
      vars = {}
    }
  end,

  atlas = "KHJokers",
  pos = { x = 0, y = 5 },
  rarity = 3,
  cost = 12,
  blueprint_compat = true,

  config = {
    extra = {}
  },

  calculate = function(self, card, context)
    if context.press_play then
      return {
        func = function()
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
              local _card = SMODS.add_card({ rank = "King", suit = "Hearts", enhancement = "m_glass", area = G.play })
              SMODS.calculate_context({ playing_card_added = true, cards = { _card } })
              return true
            end
          }))
        end
      }
    end
  end,
}
