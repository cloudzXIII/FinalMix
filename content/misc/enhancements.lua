SMODS.Enhancement({
  key = "kingdomkey",
  pos = { x = 0, y = 0 },
  atlas = "KHEnhancements",
  config = { extra = { Xmult = 1.5, x_mult_gain = 0.1 } },
  no_suit = true,
  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return { vars = { cae.Xmult, cae.x_mult_gain } }
  end,

  calculate = function(self, card, context)
    if context.main_scoring and context.cardarea == G.play then
      SMODS.calculate_effect({ x_mult = card.ability.extra.Xmult }, card)

      SMODS.scale_card(card, {
        ref_table = card.ability.extra,
        ref_value = "Xmult",
        scalar_value = "x_mult_gain"
      })
    end
    if context.before and context.cardarea == 'unscored' then
      card.ability.extra.Xmult = 1.5
      SMODS.calculate_effect({ message = localize("k_reset") }, card)
    end
  end,
  set_ability = function(self, card, initial, delay_sprites)
    if not card.ability.kingdomkey_rank_cache then
      card.ability.kingdomkey_rank_cache = card.config.card.value
    end
  end,
  draw = function(self, card, layer)
    if (layer == 'card' or layer == 'both') and card.sprite_facing == 'front' then
      card.children.center:draw_shader('booster', nil, card.ARGS.send_to_shader)
    end
  end
})

local hide_ref = Card.should_hide_front
---@diagnostic disable-next-line: duplicate-set-field
function Card:should_hide_front()
  local ref = hide_ref(self)
  if self.config.center.key == "m_kh_kingdomkey" then
    return true
  end
  return ref
end

SMODS.DrawStep {
  key = 'kingdomkey',
  order = 45,
  func = function(self, layer)
    if self.config.center.key == "m_kh_kingdomkey" and (self.config.center.discovered or self.bypass_discovery_center) then
      local rank = self.config.card.value
      if not self.canvas_text or self.ability.kingdomkey_rank_cache ~= rank then
        self.canvas_text = SMODS.CanvasSprite({
          canvasW = 71,
          canvasH = 95,
          text_offset = { x = 50, y = 75 },
          text_width = 45,
          text_height = 18,
          ref_table = SMODS.Ranks[rank],
          ref_value = "shorthand",
          text = "?",
          text_colour = G.C.WHITE
        })
      end
    end
  end,
  conditions = { vortex = false, facing = 'front' },
}

SMODS.Enhancement({
  key = "recard",
  pos = { x = 1, y = 0 },
  atlas = "KHEnhancements",
  config = { extra = {} },
  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return { vars = {} }
  end,

  calculate = function(self, card, context)
    if context.cardarea == G.play and context.repetition then
      if context.kh_retriggered then
        return
      end
      local pos = MIX.get_pos(card, context.scoring_hand)
      local left = context.scoring_hand[pos - 1]
      local right = context.scoring_hand[pos + 1]
      for _, adj in pairs({ left, right }) do
        if adj then
          SMODS.calculate_effect({ message = localize("k_again_ex") }, adj)
          SMODS.score_card(adj,
            {
              cardarea = G.play,
              full_hand = context.full_hand,
              scoring_hand = context.scoring_hand,
              scoring_name = context.scoring_name,
              poker_hands = context.poker_hands,
              kh_retriggered = true,
            })
        end
      end
    end
  end
})
