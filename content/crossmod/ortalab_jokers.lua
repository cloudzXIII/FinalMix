SMODS.Joker {
    key = 'timeless_sora',

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mod,
            }
        }
    end,

    rarity = 3,
    atlas = 'KHJokers',
    pos = { x = 3, y = 6 },
    cost = 7,

    discovered = true,
    blueprint_compat = true,

    config = {
        extra = {
            repetitions = 0,
            mod = 1
        }
    },

    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local count = 0
            for _, v in ipairs(context.scoring_hand) do
                if v:is_suit("Hearts") then
                    count = count + card.ability.extra.mod
                end
            end
            card.ability.extra.repetitions = count
        end
        if context.repetition and context.cardarea == G.play and context.other_card == context.scoring_hand[1] and card.ability.extra.repetitions > 0 then
            return {
                repetitions = card.ability.extra.repetitions
            }
        end
    end
}
