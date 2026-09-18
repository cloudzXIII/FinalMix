SMODS.Joker {
  attributes = { "reference", "FinalMix", "chips", "scaling" },
  key = 'xemnas',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return { vars = { cae.chips, cae.chips_gain } }
  end,

  atlas = "KHJokers",
  pos = { x = 8, y = 7 },
  rarity = 2,
  cost = 6,
  blueprint_compat = true,

  config = {
    extra = {
      chips = 0,
      chips_gain = 3
    }
  },

  calculate = function(self, card, context)
    if context.before and context.poker_hands then
      local cph = {}
      for k, v in pairs(context.poker_hands) do
        if next(v) then
          cph[k] = true
        end
      end

      local count = 0
      for k, v in pairs(cph) do
        count = count + 1
      end

      if count > 0 then
        SMODS.scale_card(card, {
          ref_table = card.ability.extra,
          ref_value = "chips",
          scalar_value = "chips_gain",
          message_colour = G.C.CHIPS,
          operation = function(ref_table, ref_value, initial, change)
            ref_table[ref_value] = initial + count * change
          end,
        })
      end
    end
    if context.joker_main then
      return {
        chips = card.ability.extra.chips
      }
    end
  end,
}
