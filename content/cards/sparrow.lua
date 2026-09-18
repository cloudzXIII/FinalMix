SMODS.Joker {
  attributes = { "reference", "FinalMix", "hand_type", "jack", "passive" },
  key = 'sparrow',

  loc_vars = function(self, info_queue, card)
    return {
      vars = {}
    }
  end,

  atlas = "KHJokers",
  pos = { x = 6, y = 5 },
  rarity = 2,
  cost = 5,
  blueprint_compat = true,

  config = {
    extra = {}
  },

  calculate = function(self, card, context)
  end,
}
local orig_get_straight = get_straight
function get_straight(hand, min_length, skip, wrap)
  min_length = min_length or 5
  if min_length < 2 then min_length = 2 end
  if #hand < min_length then return {} end

  local has_sparrow = next(SMODS.find_card('j_kh_sparrow'))

  if not has_sparrow then
    return orig_get_straight(hand, min_length, skip, wrap)
  end

  -- Collect ranks and jacks
  local ranks = {}
  for k, _ in pairs(SMODS.Ranks) do ranks[k] = {} end

  local jacks = {}
  for _, card in ipairs(hand) do
    local id = card:get_id()
    if id == 11 then
      table.insert(jacks, card)
    elseif id > 0 then
      for k, v in pairs(SMODS.Ranks) do
        if v.id == id then
          table.insert(ranks[k], card)
          break
        end
      end
    end
  end

  -- Helper function to get next ranks (from original function)
  local function next_ranks(key, start)
    local rank = SMODS.Ranks[key]
    local ret = {}
    if not start and not wrap and rank.straight_edge then return ret end
    for _, v in ipairs(rank.next) do
      ret[#ret + 1] = v
      if skip and (wrap or not SMODS.Ranks[v].straight_edge) then
        for _, w in ipairs(SMODS.Ranks[v].next) do
          ret[#ret + 1] = w
        end
      end
    end
    return ret
  end

  local tuples = {}
  local ret = {}

  -- Start with all available ranks (including potential jack-substituted ones)
  local available_ranks = {}
  for _, k in ipairs(SMODS.Rank.obj_buffer) do
    if next(ranks[k]) or #jacks > 0 then
      available_ranks[k] = true
    end
  end

  for _, k in ipairs(SMODS.Rank.obj_buffer) do
    if available_ranks[k] then
      tuples[#tuples + 1] = { k }
    end
  end

  for i = 2, #hand + 1 do
    local new_tuples = {}
    for _, tuple in ipairs(tuples) do
      local any_tuple
      if i ~= #hand + 1 then
        for _, l in ipairs(next_ranks(tuple[i - 1], i == 2)) do
          if available_ranks[l] then
            local new_tuple = {}
            for _, v in ipairs(tuple) do new_tuple[#new_tuple + 1] = v end
            new_tuple[#new_tuple + 1] = l
            new_tuples[#new_tuples + 1] = new_tuple
            any_tuple = true
          end
        end
      end

      if i > min_length and not any_tuple then
        -- Build straight, using jacks to fill missing ranks
        local used_jacks = {}
        local straight = {}
        local valid = true

        for _, rank_key in ipairs(tuple) do
          local rank_id = SMODS.Ranks[rank_key].id
          if next(ranks[rank_key]) then
            -- Use an actual card of this rank
            for _, card in ipairs(ranks[rank_key]) do
              if not card.used_in_straight then
                table.insert(straight, card)
                card.used_in_straight = true
                break
              end
            end
          else
            -- Need to use a Jack
            local found_jack = false
            for _, jack in ipairs(jacks) do
              if not jack.used_in_straight then
                table.insert(straight, jack)
                jack.used_in_straight = true
                found_jack = true
                break
              end
            end
            if not found_jack then
              valid = false
              break
            end
          end
        end

        -- Clean up used_in_straight markers
        for _, card in ipairs(straight) do
          card.used_in_straight = nil
        end

        if valid and #straight >= min_length then
          ret[#ret + 1] = straight
        end
      end
    end
    tuples = new_tuples
  end

  table.sort(ret, function(a, b) return #a > #b end)
  return ret
end
