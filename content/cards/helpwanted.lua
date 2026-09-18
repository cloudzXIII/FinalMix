function generate_task(card)
  local cae = card.ability.extra
  local task_types = { "play", "discard", "use_tarot", "use_planet" }
  if cae.task_type then
    for k, v in pairs(task_types) do
      if v == cae.task_type then
        table.remove(task_types, k)
      end
    end
  end
  local selected = pseudorandom_element(task_types, "j_kh_helpwanted")
  local reward = 0

  if selected == "play" or selected == "discard" then
    local _poker_hands = {}
    for k, v in pairs(G.GAME.hands) do
      if SMODS.is_poker_hand_visible(k) then _poker_hands[#_poker_hands + 1] = k end
    end

    local current_hand = pseudorandom_element(_poker_hands, pseudoseed("j_kh_helpwanted"))
    cae.current_hand = current_hand

    reward = 4 + pseudorandom("j_kh_helpwanted" .. selected, 1, 3)
  elseif selected == "use_tarot" then
    reward = 4 + pseudorandom("j_kh_helpwanted" .. selected, 1, 3)
    cae.current_hand = "Tarot"
  elseif selected == "use_planet" then
    reward = 4 + pseudorandom("j_kh_helpwanted" .. selected, 1, 3)
    cae.current_hand = "Planet"
  end

  cae.task_type = selected
  cae.reward = reward
  cae.task_complete = false
end

SMODS.Joker {
  attributes = { "reference", "FinalMix", },
  key = 'helpwanted',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    local task_type = cae.task_type or "default"

    return {
      key = self.key .. '_' .. task_type,
      vars = {
        cae.current_hand and localize(cae.current_hand, 'poker_hands') or "",
        cae.reward,
      }
    }
  end,

  rarity = 3,
  atlas = "KHJokers",
  pos = { x = 3, y = 2 },
  cost = 7,

  blueprint_compat = false,

  config = {
    extra = {
      task_type = nil,
      current_hand = nil,
      reward = 0,
      task_complete = false,
    }
  },
  kh_use_config = { colour = G.C.GREEN, text = localize("k_reroll"):upper(), cost = 4 },
  can_use = function(self, card)
    return G.GAME.dollars >= 4
  end,
  use = function(self, card)
    generate_task(card)
    ease_dollars(-4)
  end,
  add_to_deck = function(self, card, from_debuff)
    generate_task(card)
  end,

  set_ability = function(self, card, initial, delay_sprites)
    generate_task(card)
  end,

  calculate = function(self, card, context)
    local cae = card.ability.extra
    local task = cae.task_type

    if not cae.task_complete then
      if task == "play" and context.before and next(context.poker_hands[cae.current_hand]) then
        cae.task_complete = true
      end

      if task == "discard" and context.discard and context.full_hand == cae.current_hand then
        if context.scoring_hand == cae.current_hand then
          cae.task_complete = true
        end
      end

      if task == "use_tarot" and context.using_consumeable and context.consumeable.ability.set == "Tarot" then
        cae.task_complete = true
      end

      if task == "use_planet" and context.using_consumeable and context.consumeable.ability.set == "Planet" then
        cae.task_complete = true
      end
    end

    if cae.task_complete and not context.blueprint then
      cae.task_complete = false
      generate_task(card)
      ease_dollars(cae.reward)
      SMODS.calculate_effect({ message = "+$" .. cae.reward, colour = G.C.MONEY }, card)
    end
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        { ref_table = "card.ability.extra", ref_value = "current_hand", colour = G.C.ORANGE },
      },
      reminder_text = {
        { text = "+$", colour = G.C.MONEY, },
        { ref_table = "card.ability.extra", ref_value = "reward", colour = G.C.MONEY },
      },
    }
  end
}
