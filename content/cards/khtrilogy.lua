SMODS.Joker {
  attributes = { "reference", "FinalMix", "chips", "mult", "xmult" },
  key = "khtrilogy",

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      key = self.key .. '_kh' .. tostring(card.ability.extra.level),
      vars = {
        cae.chips,
        cae.mult,
        cae.xmult,
        cae.discards_remaining,
        cae.discards,
      }
    }
  end,

  rarity = 2,
  atlas = 'KHJokers',
  pos = { x = 7, y = 1 },
  cost = 6,

  blueprint_compat = true,
  display_size = { w = 69, h = 69 },
  pixel_size = { w = 69, h = 69 },

  config = {
    extra = {
      chips = 75,
      mult = 25,
      xmult = 3,
      level = 1,
      pos_override = { x = 7, y = 1 },
      discards = 30,
      discards_remaining = 30,
      level_up = false
    },
  },

  load = function(self, card, card_table, other_card)
    G.E_MANAGER:add_event(Event({
      func = function()
        card.children.center:set_sprite_pos(card.ability.extra.pos_override)
        return true
      end
    }))
  end,

  calculate = function(self, card, context)
    if card.ability.extra.level == 1 and G.GAME.current_round.hands_played == 0 then
      if context.after and (G.GAME.chips + SMODS.calculate_round_score()) > G.GAME.blind.chips then
        card.ability.extra.level_up = true
      end
    end

    if context.discard and not context.blueprint and card.ability.extra.level == 2 then
      card.ability.extra.discards_remaining = card.ability.extra.discards_remaining - 1

      if card.ability.extra.discards_remaining <= 0 then
        card.ability.extra.level_up = true
      end
    end

    if card.ability.extra.level_up and card.ability.extra.level < 3 then
      card.ability.extra.level_up = false

      G.E_MANAGER:add_event(Event({
        func = function()
          G.E_MANAGER:add_event(Event({
            func = function()
              card:juice_up(1, 0.5)
              card.ability.extra.pos_override.x = card.ability.extra.pos_override.x + 1
              card.children.center:set_sprite_pos(card.ability.extra.pos_override)
              return true
            end
          }))
          SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.FILTER }, card)
          return true
        end
      }))
      return
    end

    if context.joker_main then
      local bonuses = {
        [1] = { chips = card.ability.extra.chips },
        [2] = { mult = card.ability.extra.mult },
        [3] = { xmult = card.ability.extra.xmult },
      }
      return bonuses[card.ability.extra.level]
    end
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        { ref_table = "card.joker_display_values", ref_value = "value", colour = G.C.CHIPS }
      },
      reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "counter" },
        { ref_table = "card.joker_display_values", ref_value = "slash" },
        { ref_table = "card.joker_display_values", ref_value = "total" },
        { text = ")" },
      },
      calc_function = function(card)
        local d = card.joker_display_values
        local cae = card.ability.extra

        if cae.level == 1 then
          d.value = "+" .. cae.chips
        elseif cae.level == 2 then
          d.value = "+" .. cae.mult
        elseif cae.level == 3 then
          d.prefix = ""
          d.value = "X" .. cae.xmult
        end

        if cae.level == 1 then
          d.counter = cae.counter
          d.total = cae.total
          d.slash = "/"
        elseif cae.level == 2 then
          d.counter = ""
          d.total = ""
          d.slash = cae.discards_remaining
        else
          d.counter = ""
          d.total = ""
          d.slash = "Max"
        end
      end,
      style_function = function(card, text, reminder_text, extra)
        local level = card.ability.extra.level or 1
        if text and text.children and #text.children >= 1 then
          local colour = (level == 1 and G.C.CHIPS) or
              (level == 2 and G.C.RED) or
              (level == 3 and G.C.XMULT)
          text.children[1].config.colour = colour
        end
        return false
      end
    }
  end
}
