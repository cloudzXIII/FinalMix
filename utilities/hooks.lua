-- Main Menu Logo
local game_update_ref = Game.update
---@diagnostic disable-next-line: duplicate-set-field
function Game:update(dt)
  local ret = game_update_ref(self, dt)
  if G.STAGE == G.STAGES.MAIN_MENU and G.STATE ~= G.STATES.SPLASH then
    if not KH.config.menu_toggle and G.SPLASH_KH_LOGO then
      G.SPLASH_KH_LOGO:remove()
      G.SPLASH_KH_LOGO = nil
    end
  end

  return ret
end

local main_menu_ref = Game.main_menu
---@diagnostic disable-next-line: duplicate-set-field
Game.main_menu = function(change_context)
  local ret = main_menu_ref(change_context)
  if KH.config.menu_toggle then
    if not G.SPLASH_KH_LOGO then
      -- logo
      local SC_scale = 1.1 * (G.debug_splash_size_toggle and 0.8 or 1)

      G.SPLASH_KH_LOGO = Sprite(0, 0,
        6 * SC_scale,
        6 * SC_scale * (G.ASSET_ATLAS["kh_logo"].py / G.ASSET_ATLAS["kh_logo"].px),
        G.ASSET_ATLAS["kh_logo"], { x = 0, y = 0 }
      )
    end

    G.SPLASH_KH_LOGO:set_alignment({
      major = G.title_top,
      type = 'cm',
      bond = 'Strong',
      offset = { x = 4, y = 3 }
    })

    G.SPLASH_KH_LOGO:define_draw_steps({ {
      shader = 'dissolve',
    } })

    G.SPLASH_KH_LOGO.tilt_var = { mx = 0, my = 0, dx = 0, dy = 0, amt = 0 }
    G.SPLASH_KH_LOGO.dissolve_colours = { G.C.WHITE, G.C.WHITE }
    G.SPLASH_KH_LOGO.dissolve = 1
    G.SPLASH_KH_LOGO.states.collide.can = true

    function G.SPLASH_KH_LOGO:click()
      play_sound('button', 1, 0.3)
      G.FUNCS['openModUI_kingdomhearts']()
    end

    function G.SPLASH_KH_LOGO:hover()
      G.SPLASH_KH_LOGO:juice_up(0.05, 0.03)
      play_sound('paper1', math.random() * 0.2 + 0.9, 0.35)
      Node.hover(self)
    end

    function G.SPLASH_KH_LOGO:stop_hover()
      Node.stop_hover(self)
    end

    --Logo animation
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = change_context == 'splash' and 3.6 or change_context == 'game' and 4 or 1,
      blockable = false,
      blocking = false,
      func = (function()
        play_sound('magic_crumple' .. (change_context == 'splash' and 2 or 3),
          (change_context == 'splash' and 1 or 1.3), 0.9)
        play_sound('whoosh1', 0.2, 0.8)
        ease_value(G.SPLASH_KH_LOGO, 'dissolve', -1, nil, nil, nil,
          change_context == 'splash' and 2.3 or 0.9)
        G.VIBRATION = G.VIBRATION + 1.5
        return true
      end)
    }))
  end
  return ret
end

-- Hook skip button so it doesnt appear if challenge has "no_skipping" on it
local create_UIBox_blind_tag_ref = create_UIBox_blind_tag
---@diagnostic disable-next-line: duplicate-set-field, lowercase-global
function create_UIBox_blind_tag(blind_choice, run_info)
  if not G.GAME.modifiers.no_skipping then
    return create_UIBox_blind_tag_ref(blind_choice, run_info)
  end
end

--#region Balance percent stuff
table.insert(SMODS.calculation_keys, "kh_balance_percent")
if SMODS.other_calculation_keys then
  table.insert(SMODS.other_calculation_keys, "kh_balance_percent")
end

---@diagnostic disable-next-line: lowercase-global
function kh_calculate_balance_percent_values(input_hand_chips, input_mult, percent)
  local chip_mod = percent * input_hand_chips
  local mult_mod = percent * input_mult
  local avg = (chip_mod + mult_mod) / 2
  local new_hand_chips = input_hand_chips + (avg - chip_mod)
  local new_mult = input_mult + (avg - mult_mod)
  new_hand_chips = math.floor(new_hand_chips + 0.5)
  new_mult = math.floor(new_mult + 0.5)
  new_hand_chips = math.max(1, new_hand_chips)
  new_mult = math.max(1, new_mult)
  return new_hand_chips, new_mult
end

local kh_balance_mixed = false
local kh_smods_calculate_effect_ref = SMODS.calculate_individual_effect
---@diagnostic disable-next-line: duplicate-set-field
SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
  if key ~= "kh_balance_percent" then
    return kh_smods_calculate_effect_ref(effect, scored_card, key, amount, from_edition)
  end
  amount = amount / 100
  if effect.card and effect.card ~= scored_card then
    juice_card(effect.card)
  end
  local new_hand_chips, new_mult = kh_calculate_balance_percent_values(hand_chips, mult, amount)
  SMODS.Scoring_Parameters.chips:modify(new_hand_chips - hand_chips)
  SMODS.Scoring_Parameters.mult:modify(new_mult - mult)
  local text = localize("k_balanced") .. " " .. (amount * 100) .. "%"

  -- Plasma colour
  G.E_MANAGER:add_event(Event({
    trigger = "immediate",
    func = (function()
      ease_colour(G.C.UI_CHIPS, mix_colours(G.C.KH_PLASMA, G.C.UI_CHIPS, amount))
      ease_colour(G.C.UI_MULT, mix_colours(G.C.KH_PLASMA, G.C.UI_MULT, amount))
      if not kh_balance_mixed then
        kh_balance_mixed = true
        G.E_MANAGER:add_event(Event({
          trigger = "after",
          blockable = false,
          blocking = false,
          delay = 6.3,
          func = (function()
            if G.STATE ~= 2 then
              ease_colour(G.C.UI_CHIPS, G.C.BLUE, 2)
              ease_colour(G.C.UI_MULT, G.C.RED, 2)
              kh_balance_mixed = false
              return true
            end
          end)
        }))
      end
      return true
    end)
  }))
  if not effect.remove_default_message then
    if from_edition then
      card_eval_status_text(scored_card, "jokers", nil, percent, nil, {
        message = text,
        colour = G.C.KH_PLASMA,
        sound = "gong",
        edition = true
      })
    else
      card_eval_status_text(
        effect.message_card or effect.juice_card or scored_card or effect.card or effect.focus, "extra", nil, percent,
        nil, {
          message = text,
          colour = G.C.KH_PLASMA,
          sound = "gong"
        }
      )
    end
  end
  return true
end
--#endregion

-- Some Shenanigans for Special Blinds
local cash_out_ref = G.FUNCS.cash_out
---@diagnostic disable-next-line: duplicate-set-field
G.FUNCS.cash_out = function(e)
  if G.GAME.blind_on_deck == 'kh_Special' then
    stop_use()
    if G.round_eval then
      e.config.button = nil
      G.round_eval.alignment.offset.y = G.ROOM.T.y + 15
      G.round_eval.alignment.offset.x = 0
      G.deck:shuffle('cashout' .. G.GAME.round_resets.ante)
      G.deck:hard_set_T()
      delay(0.3)
      G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
          if G.round_eval then
            G.round_eval:remove()
            G.round_eval = nil
          end
          G.GAME.current_round.jokers_purchased = 0
          G.GAME.current_round.discards_left = math.max(0, G.GAME.round_resets.discards + G.GAME.round_bonus.discards)
          G.GAME.current_round.hands_left = (math.max(1, G.GAME.round_resets.hands + G.GAME.round_bonus.next_hands))
          G.STATE = G.STATES.BLIND_SELECT
          Handy.regular_keybinds.cashout_skipped = false
          Handy.regular_keybinds.can_skip_cashout = false
          G.GAME.shop_free = nil
          G.GAME.shop_d6ed = nil
          G.STATE_COMPLETE = false
          return true
        end
      }))
      SMODS.money_from_cashout = true
      ease_dollars(G.GAME.current_round.dollars)
      SMODS.money_from_cashout = nil
      G.E_MANAGER:add_event(Event({
        func = function()
          G.GAME.previous_round.dollars = G.GAME.dollars
          return true
        end
      }))
      play_sound("coin7")
      G.VIBRATION = G.VIBRATION + 1
    end
    ease_chips(0)
    if G.GAME.round_resets.blind_states.Boss == 'Defeated' then
      G.GAME.round_resets.blind_states.Boss = 'Upcoming'
    end
    return
  end

  return cash_out_ref(e)
end
