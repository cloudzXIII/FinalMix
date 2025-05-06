SMODS.Joker {
    key = 'nobody',

    loc_txt = {
        name = 'Nobody',
        text = {
            "Gains {C:chips}+13{} Chips per",
            "unique {C:attention}suit{} in played hand",
            "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
            "{C:inactive,s:0.8} Nobody? Who's Nobody?",
        }
    },

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,

    rarity = 4,
    atlas = 'KHJokers',
    pos = { x = 0, y = 1 },
	soul_pos = { x = 0, y = 2 },
    cost = 10,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
	eternal = false,
    perishable_compat = true,

    config = {
        extra = {
            chips = 0,
            bonuschips = 13
        }
    },

    calculate = function(self, card, context)
        -- Only calculate new chips at the start of scoring
        if context.before and context.cardarea == G.jokers then --and G.GAME.current_round.hands_played == 0 then
            -- Avoid double-triggering from Blueprint copies
            if not context.blueprint then
                local suits = {}
                for _, v in ipairs(context.scoring_hand) do
                    suits[v.base.suit] = true
                end

                local unique_suits = 0
                for _ in pairs(suits) do
                    unique_suits = unique_suits + 1
                end

                local total_chips = unique_suits * card.ability.extra.bonuschips
                card.ability.extra.chips = card.ability.extra.chips + total_chips

                return {
                    message = '+'..total_chips,
                    colour = G.C.CHIPS
                }
            end
        end

        -- Give chips when Joker is used
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}