SMODS.Joker {
    key = "magnet",

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return {
            vars = {
                card.ability.extra.dollars
            }
        }
    end,

    rarity = 3,
    cost = 8,
    atlas = 'KHJokers',
    pos = { x = 3, y = 5 },

    discovered = true,
    blueprint_compat = false,

    config = {
        extra = {
            dollars = 3
        }
    },

    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.hand and not context.end_of_round and SMODS.has_enhancement(context.other_card, "m_steel") then
            if context.other_card.debuff then
                return {
                    message = localize('k_debuffed'),
                    colour = G.C.RED
                }
            else
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_steel') then
                return true
            end
        end
        return false
    end
}
