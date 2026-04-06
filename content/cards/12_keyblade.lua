SMODS.Joker {
    key = 'keyblade',

    loc_vars = function(self, info_queue, card)
        local keyblade_card = G.GAME.current_round.keyblade_rank or { rank = 'Seven' }
        local key = localize(keyblade_card.rank, 'ranks')
        return {
            vars = {
                G.GAME.current_round.keyblade_rank and key or 7
            }
        }
    end,

    rarity = 1,
    atlas = 'KHJokers',
    pos = { x = 1, y = 1 },
    cost = 3,

    discovered = true,
    blueprint_compat = false,

    config = {},

    calculate = function(self, card, context)
        if context.first_hand_drawn and not context.blueprint then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.destroy_card and not context.blueprint then
            local keyblade_card = G.GAME.current_round.keyblade_rank.rank or { rank = 'Seven' }
            if #context.full_hand == 1 and context.destroy_card == context.full_hand[1] and context.full_hand[1].base.value == keyblade_card and G.GAME.current_round.hands_played == 0 then
                MIX.create_random_tag(card)
                return { remove = true }
            end
        end
    end
}
