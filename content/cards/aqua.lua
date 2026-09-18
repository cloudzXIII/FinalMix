SMODS.Joker {
  attributes = { "reference", "FinalMix", "perma_bonus", "modify_card", },
  key = 'aqua',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = {
        cae.chips
      }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 8, y = 3 },
  rarity = 3,
  cost = 8,
  blueprint_compat = true,

  config = {
    extra = {
      chips = 10
    }
  },

  calculate = function(self, card, context)
    if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint then
      if G.consumeables and G.consumeables.cards then
        for _, v in ipairs(G.consumeables.cards) do
          if SMODS.is_playing_card(v) then
            v.ability.perma_bonus = v.ability.perma_bonus + card.ability.extra.chips
            G.E_MANAGER:add_event(Event({
              trigger = 'after',
              delay = 0.4,
              func = function()
                play_sound('tarot1')
                v:juice_up(0.3, 0.5)
                return true
              end
            }))
            G.E_MANAGER:add_event(Event({
              trigger = 'after',
              delay = 0.15,
              func = function()
                v:flip()
                play_sound('card1', 0.4)
                v:juice_up(0.3, 0.3)
                return true
              end
            }))
            delay(0.2)
            G.E_MANAGER:add_event(Event({
              trigger = 'after',
              delay = 1.4,
              func = function()
                play_sound('tarot1')
                v:juice_up(0.3, 0.5)
                return true
              end
            }))
            G.E_MANAGER:add_event(Event({
              trigger = 'after',
              delay = 1.15,
              func = function()
                v:flip()
                play_sound('tarot2', 0.4, 0.6)
                v:juice_up(0.3, 0.3)
                return true
              end
            }))
            delay(0.5)
            SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.CHIPS }, v)
          end
        end
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    if G.consumeables then
      G.consumeables.states.collide.can = true
    end
    if G.deck then
      G.deck.states.collide.can = true
    end
  end,
  remove_from_deck = function(self, card, from_debuff)
    if #SMODS.find_card("j_kh_aqua") > 0 then return end
    if G.consumeables then
      G.consumeables.states.collide.can = false
      for _, v in ipairs(G.consumeables.cards) do
        if SMODS.is_playing_card(v) then
          v.getting_sliced = true
          SMODS.destroy_cards(v)
        end
      end
    end
    if G.deck then
      G.deck.states.collide.can = false
    end
  end
}
