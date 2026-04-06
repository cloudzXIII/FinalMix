SMODS.Joker {
    key = 'helpwanted',

    loc_vars = function(self, info_queue, card)
        for task, completed in pairs(card.ability.extra.tasks) do
            if not completed then
                info_queue[#info_queue + 1] = { key = "kh_" .. task, set = "Other" }
            end
        end

        return {
            key = self.key .. '_' .. (card.ability.extra.current_task or "default"),
            vars = {
                card.ability.extra.current_task,
                card.ability.extra.faces_played,
                card.ability.extra.money_remaining,
                card.ability.extra.discards_remaining
            }
        }
    end,

    rarity = 3,
    atlas = "KHJokers",
    pos = { x = 3, y = 4 },
    cost = 7,

    discovered = true,
    blueprint_compat = false,

    config = {
        extra = {
            tasks = {
                ["play_face"] = false,
                ["shopping"] = false,
                ["wheel"] = false,
                ["discard"] = false
            },
            current_task = nil,
            progress = 0,
            faces_played = 7,
            money_remaining = 20,
            discards_remaining = 30,
        }
    },

    calculate = function(self, card, context)
        if not card.ability.extra.current_task then
            local filtered_pool = {}
            for task_name, completed in pairs(card.ability.extra.tasks) do
                if not completed then
                    table.insert(filtered_pool, task_name)
                end
            end

            if #filtered_pool > 0 then
                card.ability.extra.current_task = pseudorandom_element(filtered_pool, pseudoseed("tasks"))
                card.ability.extra.progress = 0
            end

            if #filtered_pool <= 0 and context.main_eval and not context.blueprint then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                G.jokers:remove_card(card)
                                card:remove()
                                card = nil
                                return true;
                            end
                        }))
                        return true
                    end
                }))
                -- Extinct Message
                SMODS.calculate_effect({ message = localize('k_kh_tasks_complete'), colour = G.C.FILTER }, card)
            end
        end

        if card.ability.extra.current_task then
            local current_task = card.ability.extra.current_task

            if current_task == "play_face" and card.ability.extra.faces_played > 0 then
                if context.individual and context.cardarea == G.play and context.other_card:is_face() then
                    card.ability.extra.faces_played = card.ability.extra.faces_played - 1
                    SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.FILTER }, card)
                end

                if card.ability.extra.faces_played <= 0 then
                    card.ability.extra.faces_played = 7
                    local task_key = card.ability.extra.current_task
                    card.ability.extra.tasks[task_key] = true
                    -- win thing here
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            card_eval_status_text(card, 'extra', nil, nil, nil,
                                { message = "+" .. tostring(1) .. " Hand", colour = G.C.BLUE })

                            G.GAME.round_resets.hands = G.GAME.round_resets.hands + 1
                            ease_hands_played(1)

                            return true
                        end
                    }))
                    delay(0.6)

                    card.ability.extra.current_task = nil
                    SMODS.calculate_effect({ message = localize('k_kh_complete'), colour = G.C.FILTER }, card)
                end
            end

            if current_task == "shopping" then
                if context.ending_shop then
                    card.ability.extra.money_remaining = 20
                    SMODS.calculate_effect({ message = localize('k_reset') }, card)
                end

                if context.money_altered and context.amount < 0 then
                    card.ability.extra.money_remaining = card.ability.extra.money_remaining + context.amount
                    SMODS.calculate_effect({ message = localize('k_upgrade_ex') }, card)
                end

                if card.ability.extra.money_remaining <= 0 then
                    card.ability.extra.money_remaining = 20
                    local task_key = card.ability.extra.current_task
                    card.ability.extra.tasks[task_key] = true

                    -- win thing here
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            card_eval_status_text(card, 'extra', nil, nil, nil,
                                { message = "+" .. tostring(1) .. " Shop slot", colour = G.C.BLUE })
                            change_shop_size(1)
                            return true
                        end
                    }))

                    card.ability.extra.current_task = nil
                    SMODS.calculate_effect({ message = localize('k_kh_complete'), colour = G.C.FILTER }, card)
                end
            end

            if current_task == "wheel" then
                if context.pseudorandom_result and context.result and context.identifier == "wheel_of_fortune" then
                    local task_key = card.ability.extra.current_task
                    card.ability.extra.tasks[task_key] = true

                    -- win thing here
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        func = function()
                            card:set_edition('e_negative', true)
                            return true
                        end
                    }))

                    card.ability.extra.current_task = nil
                    SMODS.calculate_effect({ message = localize('k_kh_complete'), colour = G.C.FILTER }, card)
                end
            end
            if current_task == "discard" then
                if context.discard and not context.blueprint then
                    if card.ability.extra.discards_remaining <= 1 then
                        local task_key = card.ability.extra.current_task
                        card.ability.extra.tasks[task_key] = true

                        -- win thing here
                        G.hand:change_size(1)

                        card.ability.extra.current_task = nil
                        SMODS.calculate_effect({ message = localize('k_kh_complete'), colour = G.C.FILTER }, card)
                    else
                        card.ability.extra.discards_remaining = card.ability.extra.discards_remaining - 1
                    end
                end
            end
        end
    end
}
