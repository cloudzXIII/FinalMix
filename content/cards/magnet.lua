-- Munny Magnet, Steel cards shuffled to the top of deck
local shuffle_ref = CardArea.shuffle
---@diagnostic disable-next-line: duplicate-set-field
function CardArea:shuffle(_seed)
  local g = shuffle_ref(self, _seed)
  if self == G.deck then
    local priorities = {}
    local others = {}
    for k, v in pairs(self.cards) do
      if next(SMODS.find_card("j_kh_magnet")) and (SMODS.has_enhancement(v, "m_steel") or SMODS.has_enhancement(v, "m_gold")) then
        table.insert(priorities, v)
      else
        table.insert(others, v)
      end
    end
    for _, card in ipairs(priorities) do
      table.insert(others, card)
    end
    self.cards = others
    self:set_ranks()
  end
  return g
end

SMODS.Joker {
  attributes = { "reference", "FinalMix", "enhancements", "economy" },
  key = "magnet",

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
    info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
    return {
      vars = {
      }
    }
  end,

  rarity = 3,
  cost = 8,
  atlas = 'KHJokers',
  pos = { x = 8, y = 2 },

  blueprint_compat = false,

  config = {
    extra = {
      dollars = 3
    }
  },

  in_pool = function(self, args)
    local steel = false
    local gold = false
    for _, playing_card in ipairs(G.playing_cards or {}) do
      if SMODS.has_enhancement(playing_card, "m_steel") then
        steel = true
      end
      if SMODS.has_enhancement(playing_card, "m_gold") then
        gold = true
      end
    end
    return gold or steel
  end,

  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {}
  end,
}
