-- When a blind is selected, add a tenth of the chips of the last played hand to this Joker's Mult
SMODS.Joker {
    name = 'Chip and Dale',
    key = "chipanddale",

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.old_hand_chips,
                card.ability.extra.mult
            }
        }
    end,

    rarity = 1,
    cost = 5,
    atlas = 'KHJokers',
    pos = { x = 0, y = 4 },
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,

    config = {
        extra = {
            old_hand_chips = 0,
            mult = 0
        }
    },

    calculate = function(self, card, context)
        if context.after and not context.blueprint and not context.repetition and not context.other_card then
            local handy = hand_chips
            local chip_value = 0

            -- Adapt to different types of hand_chips
            chip_value = ToNumber(handy)
            -- if type(handy) == 'number' then
            --     chip_value = handy
            -- elseif type(handy) == 'table' then
            --     -- Talisman / BigNum method :to_number / :tonumber
            --     if type(handy.to_number) == 'function' then
            --         chip_value = handy:to_number() or 0
            --     elseif type(handy.tonumber) == 'function' then
            --         chip_value = handy:tonumber() or 0
            --     else
            --         -- rollback:
            --         if handy.array and type(handy.array) == 'table' then
            --             -- for Omeganum/bignum-like table，array[1] == chip_value
            --             chip_value = handy.array[1] or 0
            --         else
            --             chip_value = handy.current or handy.value or tonumber(handy) or 0
            --         end
            --     end
            -- end

            if chip_value > 0 then
                card.ability.extra.old_hand_chips = chip_value / 10
            end
        end
        if context.setting_blind and card.ability.extra.old_hand_chips > 0 then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.old_hand_chips
            return {
                message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.old_hand_chips } },
                colour = G.C.RED,
            }
        end
        if context.joker_main and card.ability.extra.mult > 0 then
            return { mult = card.ability.extra.mult }
        end
    end
}
