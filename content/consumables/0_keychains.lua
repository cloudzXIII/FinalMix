MIX.Keychain {
  key = 'kingdomkey',
  pos = { x = 0, y = 0 },
  keyblade_pos = { x = 0, y = 0 },
  badge_colour = G.C.RED,
  config = { mult = 15 },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        (card and card.ability.kh_keychain or self.config).mult
      }
    }
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult = (card and card.ability.kh_keychain or self.config).mult
      }
    end
  end
}

MIX.Keychain {
  key = 'oathkeeper',
  pos = { x = 1, y = 0 },
  keyblade_pos = { x = 1, y = 0 },
  badge_colour = HEX("3ba6a6"),
  config = { base = 1, odds = 4 },

  loc_vars = function(self, info_queue, card)
    local numerator, denominator = SMODS.get_probability_vars(card,
      (card and card.ability.kh_keychain or self.config).base, (card and card.ability.kh_keychain or self.config).odds,
      'oathkeeper')
    return {
      vars = {
        numerator,
        denominator
      }
    }
  end,

  calculate = function(self, card, context)
    if context.retrigger_joker_check and context.other_card == card then
      if SMODS.pseudorandom_probability(card, 'keychain', (card and card.ability.kh_keychain or self.config).base, (card and card.ability.kh_keychain or self.config).odds, 'oathkeeper') then
        return {
          repetitions = 1
        }
      else
        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.4,
          func = function()
            attention_text({
              text = localize('k_nope_ex'),
              scale = 1.3,
              hold = 1.4,
              major = card,
              backdrop_colour = G.C.SECONDARY_SET.Tarot,
              align = 'cm',
              offset = { x = 0, y = 0 },
              silent = true
            })
            G.E_MANAGER:add_event(Event({
              trigger = 'after',
              delay = 0.06 * G.SETTINGS.GAMESPEED,
              blockable = false,
              blocking = false,
              func = function()
                play_sound('tarot2', 0.76, 0.4)
                return true
              end
            }))
            play_sound('tarot2', 1, 0.4)
            card:juice_up(0.3, 0.5)
            return true
          end
        }))
      end
    end
  end
}

MIX.Keychain {
  key = 'oblivion',
  pos = { x = 2, y = 0 },
  keyblade_pos = { x = 2, y = 0 },
  badge_colour = G.C.L_BLACK,
  config = { xmult = 2 },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        (card and card.ability.kh_keychain or self.config).xmult
      }
    }
  end,

  calculate = function(self, card, context)
    if context.post_joker and G.jokers.cards[1] == card then
      return {
        xmult = (card and card.ability.kh_keychain or self.config).xmult
      }
    end
  end
}

MIX.Keychain {
  key = 'ultima_weapon',
  pos = { x = 3, y = 0 },
  keyblade_pos = { x = 3, y = 0 },
  badge_colour = G.C.BLUE,
  config = { chips_gain = 5 },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        (card and card.ability.kh_keychain or self.config).chips_gain
      }
    }
  end,

  calculate = function(self, card, context)
    if context.end_of_round and context.main_eval and not context.blueprint then
      card.ability.kh_perma_bonus = (card.ability.kh_perma_bonus or 0) +
          (card and card.ability.kh_keychain or self.config).chips_gain
      SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.CHIPS }, card)
    end
  end
}

MIX.Keychain {
  key = 'olympia',
  pos = { x = 4, y = 0 },
  keyblade_pos = { x = 4, y = 0 },
  badge_colour = G.C.GOLD,
  config = {},

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
      }
    }
  end,

  apply = function(self, card, val)
    card.ability[self.key] = val
    card.ability.extra_value = (card.ability.extra_value or 0) + card.sell_cost
  end,
}

MIX.Keychain {
  key = 'lady_luck',
  pos = { x = 0, y = 1 },
  keyblade_pos = { x = 0, y = 1 },
  badge_colour = G.C.PALE_GREEN,
  config = {},

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
      }
    }
  end,

  calculate = function(self, card, context)
    if context.mod_probability and context.trigger_obj and context.trigger_obj.ability and context.trigger_obj.ability.set and context.trigger_obj.ability.set == "Joker" and context.trigger_obj == card then
      return {
        numerator = context.numerator * 2
      }
    end
  end
}

MIX.Keychain {
  key = 'sweet_memories',
  pos = { x = 1, y = 1 },
  keyblade_pos = { x = 1, y = 1 },
  badge_colour = HEX("a6302c"),
  config = {},

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
      }
    }
  end,
}


local smods_showman_ref = SMODS.showman
---@diagnostic disable-next-line: duplicate-set-field
function SMODS.showman(card_key)
  if G.jokers then
    for _, joker in ipairs(G.jokers.cards) do
      if joker.kh_keychain and joker.kh_keychain == "kh_sweet_memories" then
        return true
      end
    end
  end
  return smods_showman_ref(card_key)
end

MIX.Keychain {
  key = 'kingdomkeyd',
  pos = { x = 2, y = 1 },
  keyblade_pos = { x = 2, y = 1 },
  badge_colour = HEX("c8a134"),
  config = { chips = 100 },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        (card and card.ability.kh_keychain or self.config).chips
      }
    }
  end,

  calculate = function(self, card, context)
    if context.pre_joker then
      return {
        chips = (card and card.ability.kh_keychain or self.config).chips
      }
    end
  end
}

MIX.Keychain {
  key = 'way_to_dawn',
  pos = { x = 1, y = 2 },
  keyblade_pos = { x = 3, y = 1 },
  badge_colour = HEX("bec7d4"),
  config = { chips = 20, mult = 4 },

  loc_vars = function(self, info_queue, card)
    local pos = G.jokers and MIX.get_pos(card, G.jokers.cards) or 0
    local jokers_left = (pos - 1)
    local total = G.jokers and #G.jokers.cards or 0
    local jokers_right = (total - pos)
    return {
      vars = {
        (card and card.ability.kh_keychain or self.config).mult,
        (card and card.ability.kh_keychain or self.config).chips,
        jokers_left > 0 and (card and card.ability.kh_keychain or self.config).mult * jokers_left or 0,
        jokers_right > 0 and (card and card.ability.kh_keychain or self.config).chips * jokers_right or 0
      }
    }
  end,

  calculate = function(self, card, context)
    if context.joker_main then
      local pos = MIX.get_pos(card, G.jokers.cards)
      local jokers_left = (pos - 1)
      local jokers_right = (#G.jokers.cards - pos)
      return {
        chips = jokers_right > 0 and (card and card.ability.kh_keychain or self.config).chips * jokers_right or nil,
        mult = jokers_left > 0 and (card and card.ability.kh_keychain or self.config).mult * jokers_left or nil
      }
    end
  end
}

MIX.Keychain {
  key = 'star_seeker',
  pos = { x = 4, y = 1 },
  keyblade_pos = { x = 4, y = 1 },
  badge_colour = HEX("fde388"),
  config = { mult_gain = 2, money = 20, money_remaining = 20 },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        (card and card.ability.kh_keychain or self.config).mult_gain,
        (card and card.ability.kh_keychain or self.config).money,
        (card and card.ability.kh_keychain or self.config).money_remaining
      }
    }
  end,

  calculate = function(self, card, context)
    if context.money_altered and context.amount < 0 then
      if (card and card.ability.kh_keychain or self.config).money_remaining <= 1 then
        (card and card.ability.kh_keychain or self.config).money_remaining = (card and card.ability.kh_keychain or self.config)
            .money
        card.ability.kh_perma_mult = (card.ability.kh_perma_mult or 0) +
            (card and card.ability.kh_keychain or self.config).mult_gain
        SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.MULT }, card)
      else
        (card and card.ability.kh_keychain or self.config).money_remaining = (card and card.ability.kh_keychain or self.config)
            .money_remaining + context.amount
        return nil, true -- This is for Joker retrigger purposes
      end
    end
  end
}

MIX.Keychain {
  key = 'xblade',
  pos = { x = 3, y = 2 },
  keyblade_pos = { x = 0, y = 2 },
  badge_colour = HEX("74cca8"),
  config = {},

  loc_vars = function(self, info_queue, card)
    local left_compat = false
    local right_compat = false
    if G.jokers then
      local pos = MIX.get_pos(card, G.jokers.cards)
      if pos then
        left_compat = G.jokers.cards[pos - 1] and G.jokers.cards[pos - 1].config.center.blueprint_compat
        right_compat = G.jokers.cards[pos + 1] and G.jokers.cards[pos + 1].config.center.blueprint_compat
      end
    end
    return {
      vars = {
        localize('k_' .. (left_compat and 'compatible' or 'incompatible')),
        localize('k_' .. (right_compat and 'compatible' or 'incompatible')),

        colours = { left_compat and G.C.GREEN or G.C.RED, right_compat and G.C.GREEN or G.C.RED, },
      },
    }
  end,

  calculate = function(self, card, context)
    local pos
    if G.jokers then
      pos = MIX.get_pos(card, G.jokers.cards)

      -- left joker
      local effect1_def
      if G.jokers.cards[pos - 1] then
        effect1_def = SMODS.blueprint_effect(card, G.jokers.cards[pos - 1], context)
        if effect1_def then
          effect1_def.colour = HEX("9facc4")
        end
      end

      -- right joker
      local effect2_def
      if G.jokers.cards[pos + 1] then
        effect2_def = SMODS.blueprint_effect(card, G.jokers.cards[pos + 1], context)
        if effect2_def then
          effect2_def.colour = HEX("9facc4")
        end
      end

      local effect_to_return = nil
      if effect1_def and effect2_def then
        effect_to_return = SMODS.merge_effects { effect1_def, effect2_def }
      else
        effect_to_return = effect1_def or effect2_def
      end
      return effect_to_return
    end
  end
}

MIX.Keychain {
  key = 'flame_liberator',
  pos = { x = 4, y = 2 },
  keyblade_pos = { x = 1, y = 2 },
  badge_colour = G.C.MULT,
  config = { xmult_gain = 0.25 },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        (card and card.ability.kh_keychain or self.config).xmult_gain
      }
    }
  end,

  calculate = function(self, card, context)
    if context.end_of_round and context.main_eval and not context.blueprint and context.beat_boss then
      card.ability.kh_perma_xmult = (card.ability.kh_perma_xmult or 1) +
          (card and card.ability.kh_keychain or self.config).xmult_gain
      SMODS.calculate_effect({ message = localize("k_upgrade_ex"), colour = G.C.MULT }, card)
    end
  end,

}

MIX.Keychain {
  key = 'monochrome',
  pos = { x = 3, y = 1 },
  keyblade_pos = { x = 2, y = 2 },
  badge_colour = G.C.JOKER_GREY,
  config = {},

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
      }
    }
  end,

  calculate = function(self, card, context)
    if context.joker_type_destroyed and context.card == card then
      return {
        message = localize("k_saved_ex"),
        colour = G.C.JOKER_GREY,
        no_destroy = true
      }
    end
  end
}
local set_debuff_ref = Card.set_debuff
---@diagnostic disable-next-line: duplicate-set-field
function Card:set_debuff(should_debuff)
  if self.kh_keychain and self.kh_keychain == "kh_monochrome" then
    self.debuff = false
    self.perma_debuff = false
  end
  set_debuff_ref(self, should_debuff)
end

MIX.Keychain {
  key = 'follow_the_wind',
  pos = { x = 2, y = 2 },
  keyblade_pos = { x = 3, y = 2 },
  badge_colour = HEX("c88000"),
  config = { price = 1 },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        (card and card.ability.kh_keychain or self.config).price
      }
    }
  end,

  calculate = function(self, card, context)
    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
      card.ability.extra_value = card.ability.extra_value + (card and card.ability.kh_keychain or self.config).price
      card:set_cost()
      return {
        message = localize('k_val_up'),
        colour = G.C.MONEY
      }
    end
  end
}

MIX.Keychain {
  key = 'mysterious_abyss',
  pos = { x = 0, y = 2 },
  keyblade_pos = { x = 4, y = 2 },
  badge_colour = G.C.PURPLE,
  config = {},

  loc_vars = function(self, info_queue, card)
    local reps = G.jokers and G.jokers.config.card_limit - #G.jokers.cards or 0
    return {
      vars = {
        reps > 0 and reps or 0
      }
    }
  end,

  calculate = function(self, card, context)
    if context.retrigger_joker_check and context.other_card == card then
      local reps = G.jokers.config.card_limit - #G.jokers.cards
      if reps > 0 then
        return {
          repetitions = reps
        }
      end
    end
  end
}
