SMODS.Attribute { key = "FinalMix" }

-- Returns true if a card has a dark suit
MIX.is_dark = function(card)
  if SMODS.has_no_suit(card) then return false end
  if (Card.is_suit_shade and card:is_suit_shade("dark")) or card:is_suit('bunc_Halberds') or card:is_suit('paperback_Crowns') then
    return true
  end
  return false
end

-- Returns true if a card has a light suit
MIX.is_light = function(card)
  if SMODS.has_no_suit(card) then return false end
  if (Card.is_suit_shade and card:is_suit_shade("light")) or card:is_suit('bunc_Fleurons') or card:is_suit('paperback_Stars') then
    return true
  end
  return false
end

-- Returns true if a card has an even rank
MIX.is_even = function(card)
  if card:get_id() <= 10 and card:get_id() >= 0 and card:get_id() % 2 == 0 then
    return true
  end
  if next(SMODS.find_mod("abandonia")) then
    local even_ranks = { "abn_12", "abn_14" }
    for _, rank in ipairs(even_ranks) do
      if card:get_id() == SMODS.Ranks[rank].id then
        return true
      end
    end
  end
  return false
end

-- Returns true if a card has an odd rank
MIX.is_odd = function(card)
  if (card:get_id() <= 10 and card:get_id() >= 0 and card:get_id() % 2 == 1) or (card:get_id() == 14) then
    return true
  end
  if next(SMODS.find_mod("abandonia")) then
    local odd_ranks = { "abn_11", "abn_13" }
    for _, rank in ipairs(odd_ranks) do
      if card:get_id() == SMODS.Ranks[rank].id then
        return true
      end
    end
  end
  return false
end

-- Find position of card
MIX.get_pos = function(card, area)
  for pos, _card in ipairs(area) do
    if _card == card then
      return pos
    end
  end
  return nil
end

-- Function to get a Joker by its key from a list of Jokers. (Donald)
MIX.get_joker_by_key = function(jokers, key)
  for _, j in ipairs(jokers) do
    if j.config.center.key == key then
      return j
    end
  end
  return nil
end

-- Returns all cards with a specific prefix
MIX.get_center_with_prefix = function(prefix)
  local results = {}
  if type(prefix) == "string" then
    for k, v in pairs(G.P_CENTERS) do
      if k:sub(1, #prefix) == prefix then
        table.insert(results, k)
      end
    end
  elseif type(prefix) == "table" then
    for k, v in pairs(G.P_CENTERS) do
      for kk, vv in ipairs(prefix) do
        if k:sub(1, #vv) == vv then
          table.insert(results, k)
        end
      end
    end
  end
  return results
end

-- Returns a random Poker Hand (Master Yen Sid)
MIX.poll_poker_hand = function(seed)
  seed = seed or "funny"
  local poker_hands = {}
  local total_weight = 0
  for _, handname in ipairs(G.handlist) do
    if G.GAME.hands[handname].visible then
      local weight = G.GAME.hands[handname].played + 1
      total_weight = total_weight + weight
      poker_hands[#poker_hands + 1] = { handname, total_weight }
    end
  end

  local weight = pseudorandom(seed) * total_weight
  local hand
  for _, h in ipairs(poker_hands) do
    if weight < h[2] then
      hand = h[1]
      break
    end
  end

  return hand
end

-- Returns most played Poker Hand
MIX.most_played_hand = function()
  local _handname, _played, _order = 'High Card', -1, 100
  for k, v in pairs(G.GAME.hands) do
    if v.played > _played or (v.played == _played and _order > v.order) then
      _played = v.played
      _handname = k
    end
  end
  if _played == 0 then return "High Card" end
  return _handname
end

-- Creates a random tag
MIX.create_random_tag = function(card)
  local tag_pool = get_current_pool('Tag')
  local selected_tag = pseudorandom_element(tag_pool, 'kh_seed')
  local it = 1
  while selected_tag == 'UNAVAILABLE' do
    it = it + 1
    selected_tag = pseudorandom_element(tag_pool, 'kh_kingdom_key_seed' .. it)
  end

  if card then
    SMODS.calculate_effect({ message = localize("k_kh_plus_tag_ex") }, card)
  end

  G.E_MANAGER:add_event(Event({
    func = (function()
      add_tag(Tag(selected_tag, false, 'Small'))
      return true
    end)
  }))
end

-- Keeps juicing and doesn't increase juicing speed until requirement is met
MIX.kh_juice_until = function(card, eval_func, first, delay)
  if card.kh_juicing then return end

  card.kh_juicing = true

  local function wrapped_eval(c)
    if not eval_func(c) then
      c.kh_juicing = nil
      return false
    end
    return true
  end

  juice_card_until(card, wrapped_eval, first, delay)
end


--#region
--Send someone to a specific blind
function MIX.send_to_blind(blind, reward)
  stop_use()
  if G.blind_select then
    G.GAME.facing_blind = true
    G.blind_prompt_box:get_UIE_by_ID('prompt_dynatext1').config.object.pop_delay = 0
    G.blind_prompt_box:get_UIE_by_ID('prompt_dynatext1').config.object:pop_out(5)
    G.blind_prompt_box:get_UIE_by_ID('prompt_dynatext2').config.object.pop_delay = 0
    G.blind_prompt_box:get_UIE_by_ID('prompt_dynatext2').config.object:pop_out(5)

    G.E_MANAGER:add_event(Event({
      trigger = 'before',
      delay = 0.2,
      func = function()
        G.blind_prompt_box.alignment.offset.y = -10
        G.blind_select.alignment.offset.y = 40
        G.blind_select.alignment.offset.x = 0
        return true
      end
    }))

    G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = function()
        ease_round(1)
        inc_career_stat('c_rounds', 1)
        if _DEMO then
          G.SETTINGS.DEMO_ROUNDS = (G.SETTINGS.DEMO_ROUNDS or 0) + 1
          inc_steam_stat('demo_rounds')
          G:save_settings()
        end
        G.blind_select:remove()
        G.blind_prompt_box:remove()
        G.blind_select = nil
        delay(0.2)
        return true
      end
    }))

    G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = function()
        MIX.kh_new_round(blind, reward or {})
        return true
      end
    }))
  end
end

function MIX.kh_new_round(blind, reward)
  G.RESET_JIGGLES = nil
  delay(0.4)
  G.E_MANAGER:add_event(Event({
    trigger = 'immediate',
    func = function()
      G.GAME.current_round.discards_left = math.max(0, G.GAME.round_resets.discards + G.GAME.round_bonus.discards)
      G.GAME.current_round.hands_left = (math.max(1, G.GAME.round_resets.hands + G.GAME.round_bonus.next_hands))
      G.GAME.current_round.hands_played = 0
      G.GAME.current_round.discards_used = 0
      G.GAME.current_round.any_hand_drawn = nil
      G.GAME.current_round.reroll_cost_increase = 0
      G.GAME.current_round.used_packs = {}

      for k, v in pairs(G.GAME.hands) do
        v.played_this_round = 0
      end

      for k, v in pairs(G.playing_cards) do
        v.ability.wheel_flipped = nil
      end

      G.GAME.current_round.free_rerolls = G.GAME.round_resets.free_rerolls
      calculate_reroll_cost(true)

      G.GAME.round_bonus.next_hands = 0
      G.GAME.round_bonus.discards = 0

      local blhash = ''
      if G.GAME.round_resets.blind_states.Small == 'Current' then
        G.GAME.round_resets.blind_states.Small = 'Current'
        G.GAME.current_boss_streak = 0
        blhash = 'S'
      elseif G.GAME.round_resets.blind_states.Big == 'Current' then
        G.GAME.round_resets.blind_states.Big = 'Current'
        G.GAME.current_boss_streak = 0
        blhash = 'B'
      else
        G.GAME.round_resets.blind_states.Boss = 'Current'
        blhash = 'L'
      end
      G.GAME.subhash = (G.GAME.round_resets.ante) .. (blhash)

      G.GAME.blind_on_deck = 'kh_Special'
      G.GAME.blind:set_blind(G.P_BLINDS[blind])

      MIX.apply_rewards(reward)

      SMODS.calculate_context({ setting_blind = true, blind = G.GAME.round_resets.blind })

      delay(0.4)

      G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
          G.STATE = G.STATES.DRAW_TO_HAND
          G.deck:shuffle('nr' .. G.GAME.round_resets.ante)
          G.deck:hard_set_T()
          ---@diagnostic disable-next-line: undefined-global
          if Talisman and Talisman.scoring_coroutine then return false end
          G.STATE_COMPLETE = false
          return true
        end
      }))
      return true
    end
  }))
end

-- Make it so these blinds are not counted as Boss Blinds (therefore not increasing the ante)
local get_type_ref = Blind.get_type
---@diagnostic disable-next-line: duplicate-set-field
function Blind:get_type()
  local ret = get_type_ref(self)
  if G.GAME.blind_on_deck == 'kh_Special' then
    return "Big"
  end
  return ret
end

-- Apply bonuses at the start of these blinds
function MIX.apply_rewards(reward)
  if reward.tag then
    MIX.create_random_tag()
  end
  if reward.dollars then
    ease_dollars(reward.dollars)
  end
  if reward.hand_size then
    G.hand:change_size(reward.hand_size)
  end
  if reward.hands_mod then
    if (G.GAME.current_round.hands_left + reward.hands_mod) > 0 then
      ease_hands_played(reward.hands_mod)
    end
  end
  if reward.discards_mod then
    if (G.GAME.current_round.discards_left + reward.discards_mod) >= 0 then
      ease_discard(reward.discards_mod)
    end
  end
end

--#endregion

--- Returns whether 2 cards are colliding visually
MIX.kh_is_card_colliding = function(c1, c2)
  local c1CenterX, c1CenterY = c1.T.x + c1.T.w / 2, c1.T.y + c1.T.h / 2
  local xiscolliding = c1CenterX > c2.T.x and c1CenterX < c2.T.x + c2.T.w
  local yiscolliding = c1CenterY > c2.T.y and c1CenterY < c2.T.y + c2.T.h
  return xiscolliding and yiscolliding
end

-- borrowed the acquire function from Bunco (thank you)
MIX.kh_acquire = function(acquired_card)
  acquired_card.area:remove_card(acquired_card)
  acquired_card:add_to_deck()
  if acquired_card.children.price then acquired_card.children.price:remove() end
  acquired_card.children.price = nil
  if acquired_card.children.buy_button then acquired_card.children.buy_button:remove() end
  acquired_card.children.buy_button = nil
  remove_nils(acquired_card.children)
  if acquired_card.ability.set == 'Default' or acquired_card.ability.set == 'Enhanced' then
    inc_career_stat('c_playing_cards_bought', 1)
    G.playing_card = (G.playing_card and G.playing_card + 1) or 1
    G.deck:emplace(acquired_card)
    acquired_card.playing_card = G.playing_card
    playing_card_joker_effects({ acquired_card })
    table.insert(G.playing_cards, acquired_card)
  else
    if acquired_card.ability.consumeable then
      G.consumeables:emplace(acquired_card)
    else
      G.jokers:emplace(acquired_card)
    end
    G.E_MANAGER:add_event(Event({
      func = function()
        acquired_card:calculate_joker({ buying_card = true, card = acquired_card })
        return true
      end
    }))
  end
  G.GAME.round_scores.cards_purchased.amt = G.GAME.round_scores.cards_purchased.amt + 1
  if acquired_card.ability.consumeable then
    if acquired_card.config.center.set == 'Planet' then
      inc_career_stat('c_planets_bought', 1)
    elseif acquired_card.config.center.set == 'Tarot' then
      inc_career_stat('c_tarots_bought', 1)
    end
  elseif acquired_card.ability.set == 'Joker' then
    G.GAME.current_round.jokers_purchased = G.GAME.current_round.jokers_purchased + 1
  end
end

-- Returns a random keychain
function MIX.poll_keychain(seed, args)
  seed = seed or "kh_keychain"
  args = args or {}

  local keychains = {}
  for k, v in pairs(KH.Keychains) do
    if k ~= "kh_lady_luck" and not (args.exclude and args.exclude[k]) then
      keychains[#keychains + 1] = k
    elseif args.card and args.card:has_attribute("chance") and k == "kh_lady_luck" then
      keychains[#keychains + 1] = k
    end
  end

  local key = pseudorandom_element(keychains, seed)
  return key
end

MIX.table_contains = function(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function MIX.remove_from_table(tbl, element)
  for i, v in ipairs(tbl) do
    if v == element then
      table.remove(tbl, i)
      return true
    end
  end
  return false
end

MIX.count_in_table = function(tbl, func)
  local count = 0
  for _, v in ipairs(tbl) do
    if not func or func(v) then
      count = count + 1
    end
  end
  return count
end
