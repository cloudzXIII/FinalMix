SMODS.Joker {
  attributes = { "reference", "FinalMix", "economy", "scaling", "xmult", "reset" },
  key = 'gummi_garage',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = {
        cae.x_mult,
        cae.x_mult_gain,
      },
    }
  end,

  atlas = "KHJokers",
  pos = { x = 2, y = 5 },
  rarity = 2,
  cost = 5,
  blueprint_compat = true,

  config = {
    extra = {
      x_mult = 1,
      x_mult_gain = 0.05
    }
  },

  calculate = function(self, card, context)
    if context.money_altered and context.amount < 0 then
      SMODS.scale_card(card, {
        ref_table = card.ability.extra,
        ref_value = "x_mult",
        scalar_value = "x_mult_gain",
        operation = function(ref_table, ref_value, initial, change)
          ref_table[ref_value] = initial + -context.amount * change
        end,
        message_key = 'a_xmult'
      })
    end
    if G.GAME.dollars <= 0 and card.ability.extra.x_mult > 1 then
      card.ability.extra.x_mult = 1
      SMODS.calculate_effect({ message = localize('k_reset') }, card)
    end
    if context.joker_main then
      return {
        x_mult = card.ability.extra.x_mult
      }
    end
  end,
}
