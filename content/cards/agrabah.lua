function MIX.reset_agrabah_world()
  local pool = {}
  for _, v in ipairs(G.P_CENTER_POOLS.Enhanced) do
    if v.key then
      pool[#pool + 1] = v.key
    end
  end
  G.GAME.current_round.agrabah_world_enhancement = SMODS.poll_enhancement({
    key = "j_kh_agrabah",
    guaranteed = true,
    options = pool
  })
end

SMODS.Joker {
  attributes = { "reference", "FinalMix", "enhancements", "playing_card" },
  key = 'agrabah',

  loc_vars = function(self, info_queue, card)
    local current_enh = G.GAME.current_round.agrabah_world_enhancement or "m_lucky"
    info_queue[#info_queue + 1] = G.P_CENTERS[current_enh]
    return {
      vars = {
        localize({ type = 'name_text', key = current_enh, set = 'Enhanced' }),
      }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 7, y = 6 },
  rarity = 2,
  cost = 5,
  blueprint_compat = false,

  config = {
    extra = {
    }
  },

  add_to_deck = function(self, card)
    G.E_MANAGER:add_event(Event({
      func = function()
        G.GAME.playing_card_rate = G.GAME.playing_card_rate + 3
        return true
      end
    }))
  end,
  remove_from_deck = function(self, card)
    G.E_MANAGER:add_event(Event({
      func = function()
        G.GAME.playing_card_rate = G.GAME.playing_card_rate - 3
        return true
      end
    }))
  end,

  calculate = function(self, card, context)
    if context.modify_shop_card and SMODS.is_playing_card(context.card) then
      local enh = G.GAME.current_round.agrabah_world_enhancement or "m_lucky"
      context.card:set_ability(enh)
      create_shop_card_ui(card)
    end
  end,
}
