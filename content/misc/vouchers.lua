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
            G.E_MANAGER:add_event(Event {
                trigger = "after",
                func = function()
                    if G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
                        G.STATE = area
                        G.STATE_COMPLETE = false
                        return true
                    end
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
            return true
        end
    })
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
    calculate = function(self, card, context)
        if context.skip_blind then
            MIX.send_to_room(G.STATES.SHOP)
        end
    end
}
