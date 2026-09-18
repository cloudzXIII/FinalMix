SMODS.Joker {
  attributes = { "reference", "FinalMix", "xmult", "hand_type", "reset" },
  key = 'datasora',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = {
        cae.x_mult + (cae.x_mult_gain * #G.GAME.kh.unique_hands),
        cae.x_mult_gain
      }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 7, y = 4 },
  soul_pos = {
    x = 8, y = 4,
    draw = function(card, scale_mod, rotate_mod)
      card.hover_tilt = card.hover_tilt * 1.5
      card.children.floating_sprite:draw_shader('hologram', nil, card.ARGS.send_to_shader, nil,
        card.children.center, 1 * scale_mod, 1 * rotate_mod)
      card.hover_tilt = card.hover_tilt / 1.5
    end
  },
  rarity = 2,
  cost = 5,
  blueprint_compat = true,

  config = {
    extra = {
      x_mult = 1,
      x_mult_gain = 0.5
    }
  },

  calculate = function(self, card, context)
    if context.joker_main then
      return {
        x_mult = card.ability.extra.x_mult + (card.ability.extra.x_mult_gain * #G.GAME.kh.unique_hands)
      }
    end
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        {
          border_nodes = {
            { text = "X" },
            { ref_table = "card.joker_display_values", ref_value = "x_mult" }
          }
        }
      },
      calc_function = function(card)
        card.joker_display_values.x_mult = card.ability.extra.x_mult +
            (card.ability.extra.x_mult_gain * #G.GAME.kh.unique_hands)
      end,
    }
  end
}
