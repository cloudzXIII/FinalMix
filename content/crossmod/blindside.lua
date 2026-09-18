---@diagnostic disable: undefined-global

--#region Joker
SMODS.Atlas({
  key = 'KHBlindSide_Jokers',
  path = 'blindside_jokers.png',
  px = 34,
  py = 34,
  atlas_table = 'ANIMATION_ATLAS',
  frames = 21
})

BLINDSIDE.Joker({
  key = 'sora',
  atlas = 'KHBlindSide_Jokers',
  pos = { x = 0, y = 0 },
  boss_colour = HEX('334362'),
  mult = 6,
  base_dollars = 4,
  order = 1,
  small = { min = 1 },
  active = true,
  calculate = function(self, blind, context)
    if context.setting_blind and G.GAME.modifiers.enable_bld_deplete_hands and G.GAME.current_round.hands_left > 1 then
      ease_hands_played(-1)
    end
    if context.scoring_hand and context.poker_hands and G.STATE == G.STATES.SELECTING_HAND and not G.GAME.blind.disabled then
      local red = false
      for i = 1, #context.scoring_hand do
        if context.scoring_hand[i]:is_color("Red") and context.scoring_hand[i].facing ~= "back" then
          red = true
        end
      end
      if red then
        BLINDSIDE.alert_debuff(self, true, "Hand contains a Red Blind")
      else
        BLINDSIDE.alert_debuff(self, false)
      end
    end

    if context.pre_discard then
      BLINDSIDE.alert_debuff(self, false)
    end
    if context.before then
      BLINDSIDE.alert_debuff(self, false)
      if context.scoring_hand and not G.GAME.blind.disabled and G.GAME.modifiers.enable_bld_deadly_small_big then
        for key, value in pairs(context.scoring_hand) do
          if value:is_color("Red") then
            value.config.center.blind_debuff(value, true)
          end
        end
      end
    end

    if context.after and not G.GAME.blind.disabled then
      local changed = false
      for i = 1, #context.scoring_hand do
        if context.scoring_hand[i]:is_color("Red") then
          changed = true
        end
      end
      if changed then
        BLINDSIDE.chipsmodify(9, 0, 1.5, 0)
        blind:wiggle()
        BLINDSIDE.chipsupdate()
      end
    end
  end,
  joker_defeat = function(self)
    BLINDSIDE.inc_stats('small_joker_defeat', self.key, true)
  end
})
--#endregion
--#region Blinds
SMODS.Atlas({
  key = 'KHBlindSide',
  path = 'blindside.png',
  px = 71,
  py = 95
})

BLINDSIDE.Blind({
  key = 'crown',
  atlas = 'KHBlindSide',
  pos = { x = 0, y = 0 },
  config = {
    extra = {
    }
  },
  hues = { "Faded" },
  basic = true,
  calculate = function(self, card, context)
    if context.cardarea == G.play and context.main_scoring then
      if card.ability.extra.upgraded then
      else
      end
    end
  end,
  loc_vars = function(self, info_queue, card)
  end,
  upgrade = function(card)
    if not card.ability.extra.upgraded then
      card.ability.extra.upgraded = true
    end
  end
})

BLINDSIDE.Blind({
  key = 'kingdom_hearts',
  atlas = 'KHBlindSide',
  pos = { x = 1, y = 0 },
  config = {
    extra = {
    }
  },
  hues = { "Blue" },
  basic = true,
  calculate = function(self, card, context)
    if context.cardarea == G.play and context.main_scoring then
      if card.ability.extra.upgraded then
      else
      end
    end
  end,
  loc_vars = function(self, info_queue, card)
  end,
  upgrade = function(card)
    if not card.ability.extra.upgraded then
      card.ability.extra.upgraded = true
    end
  end
})

BLINDSIDE.Blind({
  key = 'keyhole',
  atlas = 'KHBlindSide',
  pos = { x = 2, y = 0 },
  config = {
    extra = {
    }
  },
  hues = { "Faded" },
  basic = true,
  calculate = function(self, card, context)
    if context.cardarea == G.play and context.main_scoring then
      if card.ability.extra.upgraded then
      else
      end
    end
  end,
  loc_vars = function(self, info_queue, card)
  end,
  upgrade = function(card)
    if not card.ability.extra.upgraded then
      card.ability.extra.upgraded = true
    end
  end
})
--#endregion
