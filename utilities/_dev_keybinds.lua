--[[
SMODS.Keybind {
  key_pressed = 'r', -- reroll boss
  held_keys = { "lshift" },
  event = 'pressed',
  action = function(self)
    G.from_boss_tag = true
    G.FUNCS.reroll_boss()
  end
}

SMODS.Keybind {
  key_pressed = 'w', -- win blind
  held_keys = { "lshift" },
  event = 'pressed',
  action = function(self)
    if G.STATE ~= G.STATES.SELECTING_HAND then
      return
    end
    G.GAME.chips = G.GAME.blind.chips
    G.STATE = G.STATES.HAND_PLAYED
    G.STATE_COMPLETE = true
    end_round()
  end
}

SMODS.Keybind {
  key_pressed = 'm', -- mute
  held_keys = { "lshift" },
  event = 'pressed',
  action = function(self)
    G.SETTINGS.SOUND.volume = 0
  end
}

SMODS.Keybind {
  key_pressed = 'u', -- unmute
  held_keys = { "lshift" },
  event = 'pressed',
  action = function(self)
    G.SETTINGS.SOUND.volume = 7
  end
}
--]]
