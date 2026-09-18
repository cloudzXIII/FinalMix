KH.DTD_W = G.CARD_W / 2
KH.DTD_H = G.CARD_H / 2

function KH.custom_card_areas(game)
  game.kh_dtd_area = CardArea(
    game.ROOM.T.x + game.ROOM.T.w, 0,
    KH.DTD_W, KH.DTD_H,
    {
      card_limit = 2,
      type = "joker",
      highlight_limit = 1,
      highlighted_limit = 1,
    }
  )

  ---@diagnostic disable-next-line: duplicate-set-field
  function game.kh_dtd_area:align_cards(...)
    for k, card in ipairs(self.cards or {}) do
      if not card.states.drag.is and not card.disable_align then
        if card.ability.kh_consumed then
          card.T.w = KH.DTD_W
          card.T.h = KH.DTD_H
        end
        local parent
        for _, _card in ipairs(G.jokers.cards) do
          if card.ability.kh_consumed == _card.ability.consumed_id then
            parent = _card
            local angle = parent.kh_orbit_timer or 0

            card.T.x = parent.VT.x - G.ROOM.T.x / 2 + parent.VT.w / 2
            card.T.y = parent.VT.y - G.ROOM.T.y + parent.VT.h / 2

            card.T.r = angle
            break
          end
        end
      end
    end
  end
end

local use_and_sell_ref = G.UIDEF.use_and_sell_buttons
---@diagnostic disable-next-line: duplicate-set-field
function G.UIDEF.use_and_sell_buttons(card)
  local buttons = use_and_sell_ref(card)

  if card.area == G.kh_dtd_area then
    return {
      n = G.UIT.ROOT, config = { padding = 0, colour = G.C.CLEAR }, nodes = {}
    }
  end

  return buttons
end

SMODS.Joker {
  attributes = { "reference", "FinalMix", },
  key = 'dtd',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    if cae.saved then
      info_queue[#info_queue + 1] = G.P_CENTERS[cae.saved.save_fields.center]
    end
    return {
      vars = {
        cae.saved and localize({ type = 'name_text', set = cae.saved.ability.set, key = cae.saved.save_fields.center }) or
        localize("k_none")
      },
    }
  end,

  atlas = "KHJokers",
  pos = { x = 0, y = 4 },
  rarity = 2,
  cost = 5,
  blueprint_compat = false,

  config = {
    extra = {
      dtd_triggered = false,
      saved = nil,
      consumed_id = nil
    }
  },

  update = function(self, card, dt)
    if card.ability.consumed_id then
      card.kh_orbit_timer = (card.kh_orbit_timer or 0) + dt / 5
    end
  end,

  calculate = function(self, card, context)
    -- reset stuff
    if context.blind_defeated then
      card.ability.extra.dtd_triggered = false
    end

    if context.starting_shop and card.ability.extra.saved and not card.ability.extra.dtd_triggered then
      local _card = G.kh_dtd_area.cards[1]

      _card.area:remove_card(_card)

      _card.no_ui = nil
      _card.T.w = G.CARD_W
      _card.T.h = G.CARD_H

      G.shop_jokers:emplace(_card)
      --[[
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        func = function()
          return true
        end
      }))
      --]]

      SMODS.calculate_effect({ message = localize("k_kh_summoned"), colour = G.C.FILTER }, card)

      -- Apply edition
      local random_edition = SMODS.poll_edition({ guaranteed = true, key = "kh_dtd" })
      _card:set_edition(random_edition, true)

      -- add buy/sell button
      create_shop_card_ui(_card)

      _card.ability.kh_consumed = nil
      _card.kh_orbit_timer = nil

      card.ability.consumed_id = nil
      card.ability.extra.saved = nil

      card.ability.extra.dtd_triggered = true
    end
  end,

  remove_from_deck = function(self, card, from_debuff)
    if #G.kh_dtd_area.cards > 0 then
      local to_destroy = {}
      for _, v in ipairs(G.kh_dtd_area.cards) do
        to_destroy[#to_destroy + 1] = v
      end
      SMODS.destroy_cards(to_destroy)
    end
  end,
  can_use = function(self, card)
    return G.shop_jokers and
        #G.shop_jokers.highlighted == 1 and
        not card.ability.extra.saved
  end,

  use = function(self, card, area, copier)
    local target = G.shop_jokers.highlighted[1]

    card.ability.extra.saved = target:save()
    card.ability.extra.dtd_triggered = true

    local consumed_id = random_string(20)
    card.ability.consumed_id = consumed_id
    target.ability.kh_consumed = consumed_id

    -- remove shop card ui
    if target.children.price then target.children.price:remove() end
    target.children.price = nil
    if target.children.buy_button then target.children.buy_button:remove() end
    target.children.buy_button = nil
    remove_nils(target.children)

    draw_card(G.shop_jokers, G.kh_dtd_area, 0, "up", nil, target)
    target.no_ui = true
    target.T.w = KH.DTD_W
    target.T.h = KH.DTD_H
    target.kh_orbit_timer = 0
    G.jokers:unhighlight_all()

    SMODS.calculate_effect({ message = localize("k_kh_consumed_ex"), colour = G.C.FILTER }, card)
  end
}
