SMODS.Joker {
  attributes = { "reference", "FinalMix", "enhancements", "xmult", "mult", "chips", "economy" },
  key = "goofy",
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
    local cae = card.ability.extra
    return {
      vars = {
        cae.mult,
        cae.chips,
        cae.xmult,
        cae.dollars,
      }
    }
  end,

  rarity = 2,
  atlas = 'KHJokers',
  pos = { x = 2, y = 1 },
  cost = 6,

  blueprint_compat = true,

  config = {
    extra = {
      mult = 4,
      xmult = 1.5,
      chips = 30,
      dollars = 3,
    }
  },

  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and not context.blueprint and not context.repetition then
      if SMODS.has_enhancement(context.other_card, 'm_wild') then
        local bonuses = {
          { mult = card.ability.extra.mult },
          { chips = card.ability.extra.chips },
          { dollars = card.ability.extra.dollars },
          { xmult = card.ability.extra.xmult }
        }

        local choice = pseudorandom_element(bonuses, "goofy_bonus")

        return choice
      end
    end
  end,
  enhancement_gate = "m_wild",
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        {
          border_nodes = {
            { text = "X" },
            { ref_table = "card.ability.extra", ref_value = "xmult" }
          },
          colour = G.C.MULT
        },
        { text = ", " },
        { text = "+$", colour = G.C.MONEY, },
        { ref_table = "card.ability.extra", ref_value = "dollars", colour = G.C.MONEY, },
      },
      reminder_text = {
        { text = "+", colour = G.C.MULT, },
        { ref_table = "card.ability.extra", ref_value = "mult", colour = G.C.MULT, },
        { text = ", " },
        { text = "+", colour = G.C.CHIPS, },
        { ref_table = "card.ability.extra", ref_value = "chips", colour = G.C.CHIPS },
      },
    }
  end
}
