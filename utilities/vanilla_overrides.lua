-- Make perkeo only copy consumables, not jokers
SMODS.Joker:take_ownership('j_perkeo',
  {
    calculate = function(self, card, context)
      if context.ending_shop and G.consumeables.cards[1] then
        local kh_consumables = {}
        for _, consumable in ipairs(G.consumeables.cards) do
          if consumable.ability.consumeable then
            kh_consumables[#kh_consumables + 1] = consumable
          end
        end
        if #kh_consumables > 0 then
          G.E_MANAGER:add_event(Event({
            func = function()
              local card_to_copy, _ = pseudorandom_element(kh_consumables, 'perkeo')
              local copied_card = SMODS.copy_card(card_to_copy)
              copied_card:set_edition("e_negative", true)
              return true
            end
          }))
          return { message = localize('k_duplicated_ex') }
        else
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
              attention_text({
                text = localize('k_nope_ex'),
                scale = 1.3,
                hold = 1.4,
                major = card,
                backdrop_colour = G.C.SECONDARY_SET.Tarot,
                align = 'cm',
                offset = { x = 0, y = 0 },
                silent = true
              })
              G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.06 * G.SETTINGS.GAMESPEED,
                blockable = false,
                blocking = false,
                func = function()
                  play_sound('tarot2', 0.76, 0.4)
                  return true
                end
              }))
              play_sound('tarot2', 1, 0.4)
              card:juice_up(0.3, 0.5)
              return true
            end
          }))
          return {}
        end
      end
    end,
  }, true
)
