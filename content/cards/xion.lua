function MIX.reset_xion_joker()
  local pool = {}
  for _, v in ipairs(G.P_CENTER_POOLS.Enhanced) do
    if v.key ~= "m_lucky" then pool[#pool + 1] = v.key end
  end
  G.GAME.current_round.kh_xion_current_enh = SMODS.poll_enhancement({ key = "kh_new", guaranteed = true, options = pool })
end

SMODS.Joker {
  attributes = { "reference", "FinalMix", "enhancements" },
  key = 'xion',

  loc_vars = function(self, info_queue, card)
    local current_enh = G.GAME.current_round.kh_xion_current_enh or "m_glass"
    info_queue[#info_queue + 1] = G.P_CENTERS[current_enh]
    return {
      vars = {
        localize({ type = 'name_text', key = "m_lucky", set = 'Enhanced' }),
        localize({ type = 'name_text', key = current_enh, set = 'Enhanced' }),
      }
    }
  end,

  rarity = 2,
  atlas = 'KHJokers',
  pos = { x = 4, y = 4 },
  cost = 6,
  discovered = false,
  blueprint_compat = false,

  calculate = function(self, card, context)
    if context.check_enhancement and (context.other_card.config.center_key == "m_lucky") then
      local current_enh = G.GAME.current_round.kh_xion_current_enh or "m_glass"
      return {
        [current_enh] = true,
      }
    end
  end,
  enhancement_gate = "m_lucky",

}
