SMODS.Joker {
    key = "gummiphone",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult
            }
        }
    end,

    rarity = 1,
    cost = 5,
    atlas = 'KHJokers',
    pos = { x = 0, y = 4 },

    discovered = true,
    blueprint_compat = true,

    config = {
        extra = {
            mult = 0
        }
    },

    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
            local mult =  hand_chips / 10
            card.ability.extra.mult = card.ability.extra.mult + mult
            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { mult } },
                colour = G.C.RED,
            }
        end
        if context.joker_main and card.ability.extra.mult > 0 then
            return { mult = card.ability.extra.mult }
        end
    end
}
