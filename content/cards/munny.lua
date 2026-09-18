SMODS.Joker {
  attributes = { "reference", "FinalMix", "xmult", "economy" },
  key = "munny",

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = {
        cae.xmult,
        cae.xmult_gain
      }
    }
  end,

  rarity = 2,
  cost = 5,
  atlas = 'KHJokers',
  pos = { x = 5, y = 2 },
  discovered = false,
  blueprint_compat = true,
  config = { extra = { xmult = 1, xmult_gain = 0.5 } },

  set_sprites = function(self, card, front)
    G.E_MANAGER:add_event(Event({
      blockable = false,
      func = function()
        if not card.canvas_text then
          card.canvas_text = SMODS.CanvasSprite {
            canvasW = 71, canvasH = 95,
            text_offset = { x = 55, y = 15 },
            text_colour = G.C.MONEY,
            text_width = 15,
            text_height = 10,
            ref_table = G.GAME,
            ref_value = "kh_munny_cost",
          }
        end
        return true
      end
    }))
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      return {
        x_mult = card.ability.extra.xmult
      }
    end
  end,
}

local stop_drag_ref = Card.stop_drag
---@diagnostic disable-next-line: duplicate-set-field
function Card:stop_drag(...)
  local ret = stop_drag_ref(self, ...)

  if self.config.center.key == "j_kh_munny" and G.STATE == G.STATES.SHOP and G.shop_jokers and G.shop_jokers.cards then
    local joker = self

    for _, shop_card in ipairs(G.shop_jokers.cards) do
      if joker and MIX.kh_is_card_colliding(joker, shop_card) then
        -- Check for space
        if shop_card.ability.consumeable and #G.consumeables.cards >= G.consumeables.config.card_limit then
          alert_no_space(joker, G.consumeables)
          return ret
        end

        MIX.kh_acquire(shop_card)

        SMODS.scale_card(joker, {
          ref_table = joker.ability.extra,
          ref_value = "xmult",
          scalar_value = "xmult_gain",
          operation = '+',
          message_key = "a_xmult"
        })

        G.GAME.kh_swap_count = (G.GAME.kh_swap_count or 0) + 1
        joker:set_cost()

        joker.area:remove_card(joker)
        G.shop_jokers:emplace(joker)

        -- add buy/sell button
        create_shop_card_ui(joker)
        break
      end
    end
  end

  return ret
end

local setcost = Card.set_cost
function Card:set_cost()
  setcost(self)
  if self.config.center.key == 'j_kh_munny' then
    self.cost = self.cost + (G.GAME.kh_swap_count or 0)
    G.GAME.kh_munny_cost = "$" .. self.cost
  end
end
