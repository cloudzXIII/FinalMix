SMODS.Joker {
  attributes = { "reference", "FinalMix", "tag", "economy", },
  key = 'mog_card',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    info_queue[#info_queue + 1] = { key = 'tag_coupon', set = 'Tag' }
    return {
      vars = {
        cae.purchases,
        cae.purchases_remaining,
        localize { type = 'name_text', set = 'Tag', key = 'tag_coupon' }
      }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 9, y = 4 },
  rarity = 2,
  cost = 5,
  blueprint_compat = true,

  config = {
    extra = {
      purchases_remaining = 5,
      purchases = 5,
    }
  },

  calculate = function(self, card, context)
    if context.buying_card and card.ability.extra.purchases_remaining then
      card.ability.extra.free_purchase = false
      card.ability.extra.purchases_remaining = card.ability.extra.purchases_remaining - 1
      SMODS.calculate_effect({ message = localize("k_upgrade_ex") }, card)

      if card.ability.extra.purchases_remaining <= 0 then
        card:juice_up(0.3, 0.5)
        card.ability.extra.purchases_remaining = card.ability.extra.purchases
        G.E_MANAGER:add_event(Event({
          func = (function()
            add_tag({ key = 'tag_coupon' })
            play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
            play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
            return true
          end)
        }))
        return nil, true
      end
    end
  end,
}
