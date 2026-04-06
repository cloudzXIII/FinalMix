SMODS.Joker {
    key = "nobody",

    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.base, card.ability.extra.odds,
            'nobody')
        return {
            vars = {
                numerator,
                denominator,
            }
        }
    end,


    rarity = 4,
    atlas = 'KHJokers',
    pos = { x = 0, y = 1 },
    soul_pos = { x = 0, y = 2, },
    cost = 10,

    discovered = true,
    blueprint_compat = true,

    config = {
        extra = {
            base = 1,
            odds = 4,
        },
    },
}

local oldsmodsscorecard = SMODS.score_card
function SMODS.score_card(card, context)
    local conditions = false
    if G.jokers and G.jokers.cards then
        for _, j in ipairs(G.jokers.cards) do
            if j.config and j.config.center and j.config.center.key == "j_kh_nobody" then
                conditions = true
                J = j
                break
            end
        end
    end

    if not G.scorehand and conditions and context.cardarea == G.hand then
        G.scorehand = true
        context.cardarea = G.play
        SMODS.score_card(card, context)

        local base = J.ability.extra.base or 1
        local odds = J.ability.extra.odds or 2
        local retrigger = SMODS.pseudorandom_probability(card, 'nobody', base, odds)

        if retrigger then
            card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize("k_again_ex") })
            SMODS.score_card(card, context)
        end

        context.cardarea = G.hand
        G.scorehand = nil
    end
    return oldsmodsscorecard(card, context)
end
