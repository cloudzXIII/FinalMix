SMODS.Joker {
  attributes = { "reference", "FinalMix", "xmult", "playing_card" },
  key = 'wayfinder',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    info_queue[#info_queue + 1] = G.P_CENTERS.m_kh_recard
    return {
      vars = {
        cae.xmult
      }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 3, y = 6 },
  rarity = 3,
  cost = 5,
  blueprint_compat = true,

  config = {
    extra = {
      xmult = 0.1
    }
  },

  calculate = function(self, card, context)
    if context.kh_recard_triggered then
      context.card.ability.perma_x_mult = (context.card.ability.perma_x_mult or 1) + card.ability.extra.xmult
      SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.MULT }, context.card)
    end
  end,
}
