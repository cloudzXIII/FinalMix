local get_flush_ref = get_flush
---@diagnostic disable-next-line: duplicate-set-field
function get_flush(hand)
  local flush_required_card_count = SMODS.four_fingers('flush')
  if #hand >= flush_required_card_count and next(SMODS.find_card('j_kh_spellbinder')) then
    local cards_of_enhancement = {}
    for _, playing_card in ipairs(hand) do
      for enhancement_key, _ in pairs(SMODS.get_enhancements(playing_card)) do
        if not cards_of_enhancement[enhancement_key] then
          cards_of_enhancement[enhancement_key] = {}
        end
        table.insert(cards_of_enhancement[enhancement_key], playing_card)
      end
    end
    for _, cards_of_this_enhancement in pairs(cards_of_enhancement) do
      if #cards_of_this_enhancement >= flush_required_card_count then
        return cards_of_this_enhancement
      end
    end
  end
  return get_flush_ref(hand)
end

SMODS.Joker {
  attributes = { "reference", "FinalMix", "hand_type", "passive" },
  key = 'spellbinder',

  loc_vars = function(self, info_queue, card)
    return {
      vars = {}
    }
  end,

  atlas = "KHJokers",
  pos = { x = 1, y = 5 },
  rarity = 2,
  cost = 5,
  blueprint_compat = false,

  config = {
    extra = {}
  },

  calculate = function(self, card, context)
  end,
}
