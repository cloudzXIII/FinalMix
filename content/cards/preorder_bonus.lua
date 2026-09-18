local scu = set_consumeable_usage
function set_consumeable_usage(card)
  local ret = scu(card)
  if card.config.center.consumeable and next(SMODS.find_card("j_kh_preorder_bonus")) and card.config.center.key ~= "c_soul" then
    G.E_MANAGER:add_event(Event({
      trigger = 'immediate',
      func = function()
        G.E_MANAGER:add_event(Event({
          trigger = 'immediate',
          func = function()
            G.GAME.last_tarot_planet = card.config.center.key
            return true
          end
        }))
        return true
      end
    }))
  end
  return ret
end

SMODS.Joker {
  attributes = { "reference", "FinalMix", "tarot", "passive", "generation" },
  key = 'preorder_bonus',

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = { key = "kh_preorder_fool", set = "Other" }
    return {
      vars = {
      }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 4, y = 3 },
  rarity = 3,
  cost = 8,
  blueprint_compat = true,

  config = {
    extra = {
      original_loc = nil
    }
  },

  calculate = function(self, card, context)
    if context.end_of_round and context.beat_boss and context.main_eval then
      if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
        G.E_MANAGER:add_event(Event({
          func = (function()
            G.E_MANAGER:add_event(Event({
              func = function()
                SMODS.add_card {
                  set = "Tarot",
                  key = "c_fool"
                }
                G.GAME.consumeable_buffer = 0
                return true
              end
            }))
            SMODS.calculate_effect({ message = localize('k_plus_tarot'), colour = G.C.PURPLE },
              context.blueprint_card or card)
            return true
          end)
        }))
        return nil, true
      else
        alert_no_space(card, G.consumeables)
      end
    end
  end,
  add_to_deck = function(self, card, from_debuff)
    card.ability.extra.original_loc = G.localization.descriptions.Tarot["c_fool"]
    G.localization.descriptions.Tarot["c_fool"] = {
      name = "The Fool",
      text = {
        "Creates the last",
        "{C:attention}Consumable{} card",
        "used during this run",
        "{s:0.8,C:tarot}The Fool{s:0.8} and {s:0.8,C:spectral}The Soul{s:0.8} excluded",
      },
    }
    init_localization()
  end,
  remove_from_deck = function(self, card, from_debuff)
    G.localization.descriptions.Tarot["c_fool"] = {
      name = card.ability.extra.original_loc.name,
      text = card.ability.extra.original_loc.text
    }
    init_localization()
  end
}
