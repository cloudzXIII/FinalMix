SMODS.Challenge {
  key = 'tick_tock',
  button_colour = KH.badge_colour,
  jokers = {
    { id = "j_kh_luxord" },
  },
  rules = {
    custom = {
      { id = "no_skipping" },
      { id = "no_time" }
    },
  },
  deck = {
    type = "Challenge Deck",
  },
  restrictions = {
    banned_cards = {
      { id = "j_throwback" },
      { id = "j_diet_cola" },
    },
    banned_other = {},
  },

  calculate = function(self, context)
    if G.GAME.kh.luxord_destroyed or G.GAME.kh.luxord_sold then
      G.STATE = G.STATES.GAME_OVER
      if not G.GAME.won and not G.GAME.seeded and not G.GAME.challenge then
        G.PROFILES[G.SETTINGS.profile].high_scores.current_streak.amt = 0
      end
      G:save_settings()
      G.FILE_HANDLER.force = true
      G.STATE_COMPLETE = false
    end
  end
}

SMODS.Challenge {
  key = 'chain_reaction',
  button_colour = KH.badge_colour,
  jokers = {
  },
  rules = {
    custom = {
      { id = "chain_reaction" }
    },
  },
  deck = {
    type = "Challenge Deck",
  },
  restrictions = {
    banned_cards = {
    },
    banned_other = {},
  },

  calculate = function(self, context)
    if context.card_added and context.card.ability.set == "Joker" then
      for i = 1, #G.jokers.cards do
        if G.jokers.cards[i].config.center.key ~= context.card.config.center.key then
          G.jokers.cards[i]:set_ability(context.card.config.center.key)
        end
      end
    end
  end
}

SMODS.Challenge {
  key = 'finalmix_only',
  button_colour = KH.badge_colour,
  jokers = {
  },
  rules = {
    custom = {
      { id = "finalmix_only" }
    },
  },
  deck = {
    type = "Challenge Deck",
  },
  restrictions = {
    banned_cards = {
    },
    banned_other = {},
  },

  calculate = function(self, context)
    if G.GAME.modifiers.finalmix_only then
      for k, v in pairs(G.P_CENTER_POOLS['Joker']) do
        local joker_temp = G.P_CENTER_POOLS['Joker'][k]

        local is_kh_joker = joker_temp.attributes and joker_temp.attributes.FinalMix or false

        if not G.GAME.banned_keys[joker_temp.key] and not is_kh_joker then
          G.GAME.banned_keys[joker_temp.key] = "j_kh_cool"
        end
      end
    end
  end,
}

SMODS.Challenge {
  key = 'ink_spill',
  button_colour = KH.badge_colour,
  jokers = {
    { id = "j_kh_sketchbook", eternal = true },
    { id = "j_kh_spellbinder", eternal = true },
  },
  rules = {
    custom = {
    },
  },
  deck = {
    type = "Challenge Deck",
  },
  restrictions = {
    banned_cards = {
    },
    banned_other = {},
  },

  calculate = function(self, context)
  end
}
