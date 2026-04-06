SMODS.Joker {
    key = "invitation",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
            }
        }
    end,

    rarity = 2,
    cost = 6,
    atlas = 'KHJokers',
    pos = { x = 2, y = 5 },

    discovered = true,
    blueprint_compat = false,

    config = {
        extra = {
            kh_invite_triggered = false
        }
    },

    calculate = function(self, card, context)
        if context.create_shop_card and not card.ability.extra.kh_invite_triggered then
            card.ability.extra.kh_invite_triggered = true
            local edition = poll_edition('kh_invitation', nil, true, true, { 'e_polychrome', 'e_holo', 'e_foil' })
            SMODS.calculate_effect({ message = localize('k_kh_challenger'), colour = G.C.FILTER }, card)
            return { shop_create_flags = { set = "Joker", rarity = "Common", edition = edition } }
        end
        if context.end_of_round and not context.blueprint and not context.repetition then
            card.ability.extra.kh_invite_triggered = false
        end
    end
}
