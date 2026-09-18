SMODS.Joker {
  attributes = { "reference", "FinalMix", "balance" },
  key = "randomjoker",

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    local r_percent = {}
    for i = cae.min, cae.max do
      r_percent[#r_percent + 1] = tostring(i)
    end
    local loc_percent = '%'
    local main_start = {
      { n = G.UIT.T, config = { text = localize("k_kh_balance") .. ' ', colour = G.C.L_BLACK, scale = 0.32 } },
      { n = G.UIT.O, config = { object = DynaText({ string = r_percent, colours = { G.C.KH_PLASMA }, pop_in_rate = 9999999, silent = true, random_element = true, pop_delay = 0.5, scale = 0.32, min_cycle_time = 0 }) } },
      {
        n = G.UIT.O,
        config = {
          object = DynaText({
            string = {
              { string = '?', colour = G.C.RED },
              loc_percent, loc_percent, loc_percent,
              loc_percent, loc_percent, loc_percent,
              { string = '#', colour = G.C.RED },
              loc_percent, loc_percent, loc_percent,
              { string = '@', colour = G.C.RED },
              loc_percent, loc_percent, loc_percent
            },
            colours = { G.C.KH_PLASMA },
            pop_in_rate = 9999999,
            silent = true,
            random_element = true,
            pop_delay = 0.2011,
            scale = 0.32,
            min_cycle_time = 0
          })
        }
      },

      { n = G.UIT.T, config = { text = ' ' .. localize("k_kh_of"), colour = G.C.L_BLACK, scale = 0.32 } },

    }
    return { main_start = main_start }
  end,

  rarity = 1,
  atlas = 'KHJokers',
  pos = { x = 6, y = 2 },
  cost = 4,

  blueprint_compat = true,

  config = {
    extra = {
      percent = 0,
      min = 1,
      max = 25
    }
  },


  calculate = function(self, card, context)
    if context.final_scoring_step then
      card.ability.extra.percent = pseudorandom("j_kh_randomjoker", card.ability.extra.min, card.ability.extra.max)
      return {
        kh_balance_percent = card.ability.extra.percent
      }
    end
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        { text = "%", colour = G.C.PURPLE },
        {
          dynatext = {
            string = (
              function()
                local r_mult = {}
                for i = G.P_CENTERS["j_kh_randomjoker"].config.extra.min, G.P_CENTERS["j_kh_randomjoker"].config.extra.max do
                  r_mult[#r_mult + 1] = tostring(i)
                end
                return r_mult
              end
            )(),
            colours = { G.C.PURPLE },
            pop_in_rate = 9999999,
            silent = true,
            random_element = true,
            pop_delay = 0.5,
            scale = 0.4,
            min_cycle_time = 0
          }
        }
      }
    }
  end
}
