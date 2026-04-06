SMODS.Joker {
    key = 'xigbar',
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.x_mult,    --1
                card.ability.extra.Xmult_gain --2
            }
        }
    end,

    rarity = 2,
    atlas = 'KHJokers',
    pos = { x = 1, y = 2 },
    cost = 5,

    discovered = true,
    blueprint_compat = true,

    config = {
        extra = {
            x_mult = 1,
            Xmult_gain = 0.2,
        }
    },

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
            local faces = 0
            for k, v in ipairs(context.full_hand) do
                if v:is_face() then
                    faces = faces + 1
                end
            end
            if faces > 0 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "x_mult",
                    scalar_value = "Xmult_gain",
                    operation = '+',
                })
            end
        end

        if context.joker_main and card.ability.extra.x_mult > 1 then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    end

}
