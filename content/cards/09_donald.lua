SMODS.Joker {
    key = 'donald',
    loc_vars = function(self, info_queue, card)
        local _key = card.ability.extra.copied_joker_key
        local copied_name = _key and localize({ type = 'name_text', set = "Joker", key = _key }) or
            'None'

        return {
            vars = {
                copied_name --1
            }
        }
    end,

    rarity = 2,
    atlas = 'KHJokers',
    pos = { x = 4, y = 0 },
    cost = 7,

    discovered = true,
    blueprint_compat = true,

    config = {
        extra = {
            copied_joker_key = nil
        }
    },

    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and G.jokers and #G.jokers.cards > 1 then
            local available_jokers = {}

            for _, joker in ipairs(G.jokers.cards) do
                if joker ~= card and joker.config.center.blueprint_compat then
                    table.insert(available_jokers, joker)
                end
            end

            if #available_jokers > 0 then
                local random_joker = pseudorandom_element(available_jokers, pseudoseed("pleaseberandom"))
                card.ability.extra.copied_joker_key = random_joker.config.center.key
                card:update()
                SMODS.calculate_effect({ message = localize('k_kh_copying'), colour = G.C.FILTER }, card)
            else
                card.ability.extra.copied_joker_key = nil
            end
        end

        if card.ability.extra.copied_joker_key and not card.debuff and G.jokers then
            local copied_joker = MIX.get_joker_by_key(G.jokers.cards, card.ability.extra.copied_joker_key)

            local copied_joker_ret = SMODS.blueprint_effect(card, copied_joker, context)
            if copied_joker_ret then
                return copied_joker_ret
            end
        end
    end
}
