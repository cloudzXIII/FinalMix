SMODS.Joker {
  attributes = { "reference", "FinalMix", "suit", "mult", "chips", "scaling" },
  key = "kairi",

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "kh_lightsuit", set = "Other" }
    info_queue[#info_queue + 1] = { key = "kh_darksuit", set = "Other" }
    local cae = card.ability.extra

    local vars = {
      cae.chips,
      cae.mult,
      cae.dark,
      cae.light
    }

    local currently_nodes = {}
    localize { type = "descriptions", set = "Joker", key = "j_kh_kairi_extra", nodes = currently_nodes, vars = vars, scale = 1 }

    local box_nodes = {}
    localize { type = "descriptions", set = "Joker", key = "j_kh_kairi_" .. (cae.side == "KAIRI" and "namine" or "kairi"), nodes = box_nodes, vars = vars, scale = 0.8 }

    local main_end = {
      {
        n = G.UIT.R,
        config = { align = "cm", padding = 0.08 },
        nodes = {
          {
            n = G.UIT.R,
            config = { align = "cm" },
            nodes = currently_nodes[1]
          },
          {
            n = G.UIT.R,
            config = { align = "cm" },
            nodes = currently_nodes[2]
          },

          {
            n = G.UIT.R,
            config = { align = "cm", padding = 0.08, colour = G.C.UI.BACKGROUND_INACTIVE, r = 0.1 },
            nodes = {
              {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                  {
                    n = G.UIT.T,
                    config = {
                      text = localize("kh_namine_side"),
                      colour = G.C.WHITE,
                      scale = 0.32
                    }
                  },
                }
              },

              {
                n = G.UIT.R,
                config = {
                  align = "cm",
                  outline_colour = G.C.UI.BACKGROUND_WHITE,
                  colour = G.C.UI.BACKGROUND_WHITE,
                  outline = 0.5,
                  r = 0.1,
                  padding = 0.1
                },
                nodes = {
                  {
                    n = G.UIT.R,
                    config = { align = "cm" },
                    nodes = box_nodes[1]
                  },
                  {
                    n = G.UIT.R,
                    config = { align = "cm" },
                    nodes = box_nodes[2]
                  },
                }
              }
            }
          }
        }
      }
    }

    return {
      key = cae.side == "KAIRI" and self.key .. "_kairi" or self.key .. "_namine",
      main_end = main_end,
      vars = vars
    }
  end,

  rarity = 2,
  atlas = "KHJokers",
  pos = { x = 2, y = 0 },
  cost = 6,

  blueprint_compat = true,

  config = {
    extra = {
      side = "KAIRI",
      chips = 0,
      mult = 0,
      dark = 1,
      light = 1
    }
  },

  update = function(self, card)
    if card.VT.w <= 0 then
      if card.ability.extra.side == "KAIRI" then
        card.children.center:set_sprite_pos({ x = 2, y = 0 })
      else
        card.children.center:set_sprite_pos({ x = 3, y = 1 })
      end
    end
  end,

  set_sprites = function(self, card, front)
    if self.discovered or card.bypass_discovery_center then
      if card.ability and card.ability.extra and card.ability.extra.side then
        if card.ability.extra.side == "KAIRI" then
          card.children.center:set_sprite_pos({ x = 2, y = 0 })
        else
          card.children.center:set_sprite_pos({ x = 3, y = 1 })
        end
      end
    end
  end,

  calculate = function(self, card, context)
    if context.end_of_round and context.main_eval and not context.blueprint then
      card:flip()
    end

    if context.flip and not context.blueprint then
      SMODS.calculate_effect({
        message = localize("kh_" .. (card.ability.extra.side == "KAIRI" and "namine" or "kairi") .. "_side"),
        message_colour = G.C.RED,
        instant = true
      }, card)

      if card.ability.extra.side == "KAIRI" then
        card.ability.extra.side = "NAMINE"
      else
        card.ability.extra.side = "KAIRI"
      end
    end

    if context.individual and context.cardarea == G.play and not context.blueprint then
      local side = card.ability.extra.side
      if MIX.is_light(context.other_card) then
        if side == "KAIRI" then -- KAIRI
          -- Gain Chips
          SMODS.scale_card(card, {
            ref_table = card.ability.extra,
            ref_value = "chips",
            scalar_value = "dark",
            operation = "+",
            message_colour = G.C.CHIPS,
          })
        end

        if side == "NAMINE" and card.ability.extra.mult > 0 then
          -- Lose Mult
          SMODS.scale_card(card, {
            ref_table = card.ability.extra,
            ref_value = "mult",
            scalar_value = "light",
            operation = "-",
            scaling_message = {
              message = localize("k_nope_ex"),
              colour = G.C.PURPLE
            }
          })
        end
      end

      if MIX.is_dark(context.other_card) then
        if side == "KAIRI" and card.ability.extra.chips > 0 then
          --Lose Chips
          SMODS.scale_card(card, {
            ref_table = card.ability.extra,
            ref_value = "chips",
            scalar_value = "light",
            operation = "-",
            scaling_message = {
              message = localize("k_nope_ex"),
              colour = G.C.PURPLE
            }
          })
        end

        if side == "NAMINE" then
          -- Gain Mult
          SMODS.scale_card(card, {
            ref_table = card.ability.extra,
            ref_value = "mult",
            scalar_value = "dark",
            operation = "+",
            message_colour = G.C.MULT,
          })
        end
      end
    end

    if context.joker_main then
      return {
        chips = card.ability.extra.chips,
        mult = card.ability.extra.mult,
      }
    end
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        { text = "+", colour = G.C.CHIPS, },
        { ref_table = "card.ability.extra", ref_value = "chips", colour = G.C.CHIPS },
        { text = ", " },
        { text = "+", colour = G.C.MULT, },
        { ref_table = "card.ability.extra", ref_value = "mult", colour = G.C.MULT },
      },
      reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "light_or_dark", },
        { text = "," },
        { ref_table = "card.joker_display_values", ref_value = "mult_or_chips", },
      },
      calc_function = function(card)
        local side = card.ability.extra.side
        card.joker_display_values.light_or_dark = side == "NAMINE" and localize("k_kh_dark") or localize("k_kh_light")
        card.joker_display_values.mult_or_chips = side == "NAMINE" and localize("k_kh_mult") or localize("k_kh_chips")
      end,
      style_function = function(card, text, reminder_text, extra)
        local side = card.ability.extra.side

        if reminder_text and reminder_text.children then
          for _, child in ipairs(reminder_text.children) do
            if child.config and child.config.ref_value then
              if child.config.ref_value == "light_or_dark" then
                child.config.colour = (side == "NAMINE") and G.C.BLUE or G.C.SUITS.Diamonds
              elseif child.config.ref_value == "mult_or_chips" then
                child.config.colour = (side == "NAMINE") and G.C.MULT or G.C.CHIPS
              end
            end
          end
        end

        return false
      end
    }
  end
}
