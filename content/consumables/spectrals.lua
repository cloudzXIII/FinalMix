if next(SMODS.find_mod("abandonia")) and ABN.GlyphCard then
  ABN.GlyphCard {
    key = "sorcerer",
    atlas = "KHConsumables",
    pos = { x = 0, y = 2 },
    dependencies = { "abandonia" },

    config = { extra = { seal = 'kh_luckyemblem' }, max_highlighted = 1 },

    abn_artist_credits = {
      artist = "cloudzXIII",
      colour = G.C.GOLD
    },
  }

  ABN.GlyphCard {
    key = "hearts",
    atlas = "KHConsumables",
    pos = { x = 1, y = 2 },
    dependencies = { "abandonia" },

    config = { extra = { seal = 'kh_kingdom' }, max_highlighted = 1 },

    abn_artist_credits = {
      artist = "cloudzXIII",
      colour = G.C.GOLD
    },
  }
else
  SMODS.Consumable {
    key = "sorcerer",
    set = "Spectral",
    cost = 4,
    atlas = "KHConsumables",
    pos = { x = 0, y = 1 },

    config = {
      max_highlighted = 1,
      extra = {
        seal = "kh_luckyemblem"
      }
    },
    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
      return {
        vars = {
          card.ability.max_highlighted,
          localize { type = 'name_text', set = "Other", key = string.lower(card.ability.extra.seal) .. '_seal' },
          colours = {
            G.P_SEALS[card.ability.extra.seal].badge_colour or G.C.FILTER
          }
        }
      }
    end,

    use = function(self, card, area, copier)
      G.E_MANAGER:add_event(Event({
        func = function()
          play_sound('tarot1')
          card:juice_up(0.3, 0.5)
          return true
        end
      }))

      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
          for i = 1, #G.hand.highlighted do
            G.hand.highlighted[i]:set_seal(card.ability.extra.seal, nil, true)
          end
          return true
        end
      }))

      delay(0.5)
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function()
          G.hand:unhighlight_all()
          return true
        end
      }))
    end
  }

  SMODS.Consumable {
    key = "hearts",
    set = "Spectral",
    cost = 4,
    atlas = "KHConsumables",
    pos = { x = 2, y = 1 },

    config = {
      max_highlighted = 1,
      extra = {
        seal = "kh_kingdom"
      }
    },
    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_SEALS[card.ability.extra.seal]
      return {
        vars = {
          card.ability.max_highlighted,
          localize { type = 'name_text', set = "Other", key = string.lower(card.ability.extra.seal) .. '_seal' },
          colours = {
            G.P_SEALS[card.ability.extra.seal].badge_colour or G.C.FILTER
          }
        }
      }
    end,


    use = function(self, card, area, copier)
      G.E_MANAGER:add_event(Event({
        func = function()
          play_sound('tarot1')
          card:juice_up(0.3, 0.5)
          return true
        end
      }))

      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.1,
        func = function()
          for i = 1, #G.hand.highlighted do
            G.hand.highlighted[i]:set_seal(card.ability.extra.seal, nil, true)
          end
          return true
        end
      }))

      delay(0.5)
      G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = function()
          G.hand:unhighlight_all()
          return true
        end
      }))
    end
  }
end
