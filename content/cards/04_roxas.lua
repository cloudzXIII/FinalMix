SMODS.Joker {
    key = 'roxas',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.total_chips, --1
                card.ability.extra.chips_gain   -- 2
            }
        }
    end,

    rarity = 2,
    atlas = 'KHJokers',
    pos = { x = 1, y = 0 },
    cost = 5,

    discovered = true,
    blueprint_compat = true,

    config = {
        extra = {
            total_chips = 0,
            chips_gain = 13
        }
    },

    calculate = function(self, card, context)
        if context.before and context.cardarea == G.jokers and not context.blueprint and G.GAME.current_round.hands_played == 0 then
            local suits = {}
            for _, v in ipairs(context.scoring_hand) do
                suits[v.base.suit] = true
            end

            local unique_suits = 0
            for _ in pairs(suits) do
                unique_suits = unique_suits + 1
            end

            local total = unique_suits * card.ability.extra.chips_gain
            card.ability.extra.total_chips = card.ability.extra.total_chips + total
            return { message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.total_chips } } }
        end

        if context.joker_main then
            return {
                chips = card.ability.extra.total_chips
            }
        end
    end
}
