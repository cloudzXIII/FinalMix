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
            XIII.create_random_tag()
        end
    end
}

XIII.send_to_room = function(area)
    -- Credits to All in Jest!
    G.GAME.kh.moogle_shop = true
    stop_use()

    G.deck:shuffle('cashout' .. G.GAME.round_resets.ante)
    G.deck:hard_set_T()

    G.GAME.current_round.used_packs = {}

    local rechain = (G.GAME.selected_back_key or {}).key == 'b_kh_rechain' or
        G.GAME.selected_sleeve == 'sleeve_kh_rechain'
    if not rechain or G.GAME.round_resets.blind.boss then
        G.GAME.current_round.reroll_cost_increase = 0
    end

    G.GAME.current_round.free_rerolls = G.GAME.round_resets.free_rerolls
    calculate_reroll_cost(true)

    if G.blind_prompt_box then
        G.blind_prompt_box:get_UIE_by_ID('prompt_dynatext1').config.object.pop_delay = 0
        G.blind_prompt_box:get_UIE_by_ID('prompt_dynatext1').config.object:pop_out(5)
        G.blind_prompt_box:get_UIE_by_ID('prompt_dynatext2').config.object.pop_delay = 0
        G.blind_prompt_box:get_UIE_by_ID('prompt_dynatext2').config.object:pop_out(5)
    end

    delay(0.3)
    G.E_MANAGER:add_event(Event({
        trigger = "after",
        func = function()
            if G.blind_select then
                G.blind_select:remove()
                G.blind_prompt_box:remove()
                G.blind_select = nil
            end
            G.GAME.current_round.jokers_purchased = 0
            G.STATE = area
            G.GAME.shop_free = nil
            G.GAME.shop_d6ed = nil
            G.STATE_COMPLETE = false
            return true
        end,
    }))
end

local toggle_shop_ref = G.FUNCS.toggle_shop
G.FUNCS.toggle_shop = function(e)
    if G.GAME.kh.moogle_shop then
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 0.5,
            func = function()
                G.GAME.kh.moogle_shop = false
                return true
            end,
        }))
    end
    return toggle_shop_ref(e)
end

local update_shop_ref = Game.update_shop
function Game:update_shop(dt)
    if G.GAME.kh.moogle_shop and G.STATE_COMPLETE and G.shop then
        G.shop.alignment.offset.y = -5.3
    end
    return update_shop_ref(self, dt)
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
            XIII.send_to_room(G.STATES.SHOP)
        end
    end
}
