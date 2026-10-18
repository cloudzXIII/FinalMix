SMODS.Joker {
  attributes = { "reference", "FinalMix", "chips", "reset" },
  key = 'luxord',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    local vars = {
      cae.chips,
      cae.cap,
      cae.chips_lose,
    }
    local main_start = {
      {
        n = G.UIT.T,
        config = {
          text = "+",
          colour = G.C.CHIPS,
          scale = 0.32
        }
      },
      {
        n = G.UIT.T,
        config = {
          ref_table = card.ability.extra,
          ref_value = "chips",
          colour = G.C.CHIPS,
          scale = 0.32
        }
      },
      {
        n = G.UIT.T,
        config = {
          text = " " .. localize("k_kh_chips"),
          colour = G.C.UI.TEXT_DARK,
          scale = 0.32
        }
      },
    }

    return { main_start = main_start, vars = vars, }
  end,
  rarity = 2,
  atlas = 'KHJokers',
  pos = { x = 1, y = 2, },
  cost = 6,

  blueprint_compat = true,
  eternal_compat = false,

  config = {
    extra = {
      chips = 100,
      cap = 100,
      chips_lose = 1,
      time_spent = 0,
    },
  },

  update = function(self, card, dt)
    if G.GAME.blind and G.GAME.blind.in_blind and card.area == G.jokers then
      -- checks if game is not paused and hand isn't being played
      if not G.SETTINGS.paused and G.STATE ~= G.STATES.HAND_PLAYED then
        card.ability.extra.time_spent = card.ability.extra.time_spent + G.real_dt
        card.ability.extra.chips = math.floor(card.ability.extra.cap -
          (card.ability.extra.time_spent * card.ability.extra.chips_lose))
      end
    end

    if card.ability.extra.chips <= 0 and not G.GAME.kh.luxord_destroyed then
      G.GAME.kh.luxord_destroyed = true
      SMODS.destroy_cards(card, nil, nil, true)
      SMODS.calculate_effect({ message = localize("k_kh_times_up_ex"), colour = G.C.FILTER }, card)
    end
  end,

  add_to_deck = function(self, card)
    if G.GAME.kh.luxord_destroyed then
      G.GAME.kh.luxord_destroyed = false
    end
  end,

  calculate = function(self, card, context)
    if context.selling_self then
      G.GAME.kh.luxord_sold = true -- for the challenge, no idea if this is the best way of doing it but hey, it works!
    end

    if context.setting_blind and not card.getting_sliced and not context.blueprint then
      card.ability.extra.chips = card.ability.extra.cap
      SMODS.calculate_effect({ message = "Start!", colour = G.C.FILTER }, card)
    end

    if context.first_hand_drawn and not context.blueprint then
      local eval = function() return card.ability.extra.active and not G.RESET_JIGGLES end
      juice_card_until(card, eval, true)
    end

    if context.joker_main then
      return {
        chips = card.ability.extra.chips,
      }
    end

    if context.end_of_round and not context.individual and not context.repetition and not context.blueprint then
      if context.beat_boss then
        card.ability.extra.chips_lose = card.ability.extra.chips_lose * 1.5
        card.ability.extra.cap = card.ability.extra.cap * 1.5
      end
      card.ability.extra.time_spent = 0
      card.ability.extra.chips = card.ability.extra.cap
      SMODS.calculate_effect(
        { context.beat_boss and localize('k_upgrade_ex') or localize('k_reset'), colour = G.C.FILTER }, card)
    end
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        { text = "(" },
        { text = "+", colour = G.C.CHIPS, },
        { ref_table = "card.joker_display_values", ref_value = "chips", colour = G.C.CHIPS },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "cap", colour = G.C.UI.ATTENTION },
        { text = ")" },
      },
      reminder_text = {
        { text = "(Round)" },
      },
      calc_function = function(card)
        card.joker_display_values.chips = card.ability.extra.chips
      end,
    }
  end
}
