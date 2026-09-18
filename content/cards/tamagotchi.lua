SMODS.Joker {
  attributes = { "reference", "FinalMix", "x_mult", "scaling", "destroy_card" },
  key = "tamagotchi",

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    info_queue[#info_queue + 1] = { key = "kh_possible_tama_cards", set = "Other" }
    return {
      key = self.key,
      vars = {
        cae.x_mult,
        cae.x_mult_gain,
      }
    }
  end,

  rarity = 2,
  cost = 7,
  atlas = 'KHJokers',
  pos = { x = 0, y = 3 },
  display_size = { w = 63 * 1.3, h = 93 * 1.3 },
  pixel_size = { w = 63, h = 93 },

  blueprint_compat = true,

  config = {
    extra = {
      x_mult = 1,
      x_mult_gain = 0.25,
      fed = false
    }
  },

  calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint and card.ability.extra.fed then
      card.ability.extra.fed = false
      SMODS.calculate_effect({ message = localize("k_kh_hungry_ex"), colour = G.C.FILTER }, card)
    end

    if context.joker_main then
      return {
        x_mult = card.ability.extra.x_mult
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
            { ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp" }
          }
        }
      },
      reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "hungry" },
        { text = ")" },
      },
      calc_function = function(card)
        card.joker_display_values.hungry = card.ability.extra.fed and "Full" or "Hungry"
      end
    }
  end
}

local function can_consume(card, tamagotchi)
  if card.area == G.hand then
    return true
  end

  if card.area == G.jokers and card ~= tamagotchi then
    return true
  end

  if card.area == G.consumeables and (card.ability.set == "Tarot" or card.ability.set == "Planet") then
    return true
  end

  return false
end

local stop_drag_ref = Card.stop_drag
---@diagnostic disable-next-line: duplicate-set-field
function Card:stop_drag(...)
  local ret = stop_drag_ref(self, ...)

  if G.jokers and G.jokers.cards then
    for _, joker in ipairs(G.jokers.cards) do
      if joker.config.center.key == "j_kh_tamagotchi" and not joker.ability.extra.fed
      and can_consume(self, joker) and MIX.kh_is_card_colliding(self, joker) then
        SMODS.destroy_cards(self)
        G.E_MANAGER:add_event(Event({
          trigger = "after",
          delay = 0.6,
          func = function()
            SMODS.scale_card(joker, {
              ref_table = joker.ability.extra,
              ref_value = "x_mult",
              scalar_value = "x_mult_gain",
              operation = '+',
              scaling_message = { message = localize { type = 'variable', key = 'a_xmult', vars = { joker.ability.extra.x_mult } } },
            })
            joker.ability.extra.fed = true
            return true
          end,
        }))
        break
      end
    end
  end

  return ret
end

--#region Tamagotchi emotions on card
SMODS.Atlas {
  key = "kh_tama",
  path = "tamagotchi_emotions.png",
  px = 71,
  py = 95,
}

local main_menu_ref = Game.main_menu
---@diagnostic disable-next-line: duplicate-set-field
function Game:main_menu(change_context)
  local g = main_menu_ref(self, change_context)

  G.shared_tamagotchi_emotions = G.shared_tamagotchi_emotions or {}
  G.shared_tamagotchi_emotions["hungry"] = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["kh_tama"], { x = 1, y = 0 })
  G.shared_tamagotchi_emotions["hover_hungry"] = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["kh_tama"],
    { x = 0, y = 0 })
  G.shared_tamagotchi_emotions["full"] = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["kh_tama"], { x = 2, y = 0 })

  return g
end

SMODS.DrawStep {
  key = 'tamagotchi',
  order = 90,
  func = function(card)
    if card.ability and card.ability.set == "Joker" and card.config and card.config.center.key == "j_kh_tamagotchi" then
      local emotion
      if card.ability.extra.fed then
        emotion = "full"
      else
        local dragged = G.CONTROLLER.dragging.target
        if dragged and (can_consume(dragged, card) or card.area and card.area.config.collection) and MIX.kh_is_card_colliding(dragged, card) then
          emotion = "hover_hungry"
        else
          emotion = "hungry"
        end
      end

      if G.shared_tamagotchi_emotions and G.shared_tamagotchi_emotions[emotion] then
        G.shared_tamagotchi_emotions[emotion].role = { draw_major = card }
        G.shared_tamagotchi_emotions[emotion]:draw_shader('dissolve', nil, nil, nil, card.children.center)
      end
    end
  end,
  conditions = { vortex = false, facing = 'front' },
}
--#endregion
