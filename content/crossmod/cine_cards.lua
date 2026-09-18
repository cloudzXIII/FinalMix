---@diagnostic disable: undefined-global

SMODS.Atlas {
  key = "KHCine",
  path = "reverie.png",
  px = 71,
  py = 95,
}

KH.CineCard = SMODS.Consumable:extend({
  set = "Cine",
  atlas = "kh_KHCine",
  set_sprites = function(self, card, front)
    card.ignore_base_shader = { ticket = true }
  end,
  draw = function(self, card, layer)
    card.ARGS = card.ARGS or {}
    if not card.ARGS.send_to_shader then
      card.ARGS.send_to_shader = card.ARGS.send_to_shader or {}
      card.ARGS.send_to_shader[1] = math.min(card.VT.r * 3, 1) + math.sin(G.TIMERS.REAL / 28) + 1 +
          (card.juice and card.juice.r * 20 or 0) + card.tilt_var.amt
      card.ARGS.send_to_shader[2] = G.TIMERS.REAL

      for k, v in pairs(card.children) do
        v.VT.scale = card.VT.scale
      end
    end
    if not (card.edition and card.edition.negative) then
      card.ARGS.send_to_shader = card.ARGS.send_to_shader or {}
      card.ARGS.send_to_shader[3] = card.omit_top_half or 0
      card.ARGS.send_to_shader[4] = card.omit_bottom_half or 0

      if card.ability.name == "The Unseen" and card.ability.progress == nil and (card.config.center.discovered or card.bypass_discovery_center) then
        card.children.center:draw_shader("dvrprv_ticket_negative", nil, card.ARGS.send_to_shader)
      elseif card.ability.name == "I Sing, I've No Shape" and card.ability.progress == nil and card.config.center.discovered then
        card.children.center:draw_shader("dvrprv_ticket_polychrome", nil, card.ARGS.send_to_shader)
      else
        card.children.center:draw_shader("dvrprv_ticket", nil, card.ARGS.send_to_shader)
      end
    end
    if card.edition and card.edition.polychrome then
      card.ARGS.send_to_shader[3] = card.omit_top_half or 0
      card.ARGS.send_to_shader[4] = card.omit_bottom_half or 0

      -- Different from "ticket_negative", this is a direct copy of negative with no intended visual changes
      card.children.center:draw_shader("dvrprv_cine_polychrome", nil, card.ARGS.send_to_shader)
    end
    if card.edition and card.edition.negative then
      card.ARGS.send_to_shader[3] = card.omit_top_half or 0
      card.ARGS.send_to_shader[4] = card.omit_bottom_half or 0

      -- Different from "ticket_negative", this is a direct copy of negative with no intended visual changes
      card.children.center:draw_shader("dvrprv_cine_negative", nil, card.ARGS.send_to_shader)
    end
  end,
  update = function(self, card)
    if card.VT.w <= 0 then
      card.children.center:set_sprite_pos(G.P_CENTERS[card.config.center.key].pos)
      card.ability.progress = nil
    end
  end,
})

KH.CineCard {
  key = "firethunderfreeze_quest",
  pos = { x = 0, y = 0 },
  cost = 4,
  reward = "c_kh_firethunderfreeze",
  config = {
    progress = 0,
    extra = {
      goal = 2
    }
  },
  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS[self.reward]
    return { vars = { card.ability.extra.goal, card.ability.progress } }
  end,
  can_use = function(self, card)
    if card.config.center.reward then
      return false
    else
      return G.STATE == G.STATES.SHOP and G.shop
    end
  end,
  calculate = function(self, card, context)
    if context.using_consumeable and context.consumeable.ability.set == "kh_keyblade" then
      Reverie.progress_cine_quest(card)
    end
  end
}

-- Jank (this needs to load really early to show up ingame, and "Reverie" is nil at that time)
function MIX.use_cine(center, card, area, copier)
  return Reverie.use_cine(center, card, area, copier)
end

KH.CineCard {
  key = "firethunderfreeze",
  pos = { x = 1, y = 0 },
  cost = 4,
  config = {
    extra = {
    }
  },
  loc_vars = function(self, info_queue, card)
    return { vars = {} }
  end,
  can_use = function(self, card)
    if card.config.center.reward then
      return false
    else
      return G.STATE == G.STATES.SHOP and G.shop
    end
  end,
  use = MIX.use_cine
}
