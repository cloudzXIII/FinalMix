SMODS.Voucher {
    key = 'moogleskip',
    atlas = "KHVouchers",
    unlocked = true,
    discovered = true,
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

MIX.send_to_room = function(area)
    G.E_MANAGER:add_event(Event {
        trigger = "after",
        func = function()
            G.STATE = area
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

SMODS.Voucher {
    key = 'moogleshop',
    atlas = "KHVouchers",
    unlocked = true,
    discovered = true,
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
        MIX.send_to_room(G.STATES.SHOP)
    end
    return ref_skip_blind(e)
end