SMODS.Voucher {
  key = 'moogleskip',
  atlas = "KHVouchers",
  pos = { x = 0, y = 0 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, card)
  end,
  calculate = function(self, card, context)
    if context.skip_blind then
      MIX.create_random_tag()
    end
  end
}

SMODS.Voucher {
  key = 'moogleshop',
  atlas = "KHVouchers",
  pos = { x = 1, y = 0 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, card)
  end,
  requires = { 'v_kh_moogleskip' },
  redeem = function(self, card)
    G.GAME.kh_moogleshop = true
  end,
}

local ref_skip_blind = G.FUNCS.skip_blind
function G.FUNCS.skip_blind(e)
  if G.GAME.kh_moogleshop then
    G.E_MANAGER:add_event(Event {
      trigger = "after",
      func = function()
        G.STATE = G.STATES.SHOP
        G.STATE_COMPLETE = false
        return true
      end
    })
    if G.blind_select then
      G.blind_select.alignment.offset.y = G.blind_select.alignment.offset.y + G.blind_select.T.h
      G.E_MANAGER:add_event(Event {
        trigger = "after",
        delay = 0.3,
        func = function()
          G.blind_select:remove()
          G.blind_prompt_box:remove()
          return true
        end
      })
    end
  end
  return ref_skip_blind(e)
end

SMODS.Voucher {
  key = 'inheritance_ceremony',
  atlas = "KHVouchers",
  pos = { x = 0, y = 1 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, card)
    return { vars = {} }
  end,

  calculate = function(self, back, context)
    if context.round_eval and G.GAME.blind and G.GAME.blind.boss and G.consumeables.config.card_limit > #G.consumeables.cards then
      G.E_MANAGER:add_event(Event({
        func = function()
          SMODS.add_card { set = "kh_keyblade" }
          return true
        end
      }))
    end
  end,
}
SMODS.Voucher {
  key = 'keyblade_mastery',
  atlas = "KHVouchers",
  pos = { x = 1, y = 1 },
  config = { extra = {} },
  loc_vars = function(self, info_queue, card)
    return { vars = {} }
  end,
  calculate = function(self, back, context)
    if context.modify_shop_card and context.card.ability.set == "Joker" then
      if pseudorandom('v_kh_keyblade_mastery') > 0.8 then
        local keychain = MIX.poll_keychain("v_kh_keyblade_mastery", { card = context.card })
        context.card:kh_set_keychain(keychain)
      end
    end
  end,
}
