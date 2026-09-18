SMODS.ConsumableType {
  key = "kh_keyblade",
  primary_colour = HEX("9facc4"),
  secondary_colour = HEX("9facc4"),
  collection_rows = { 4, 4 },
}


SMODS.UndiscoveredSprite {
  key = 'kh_keyblade',
  atlas = 'kh_KHKeyblade',
  pos = { x = 0, y = 3 },
  overlay_pos = { x = 1, y = 3 }
}

for keychain, v in pairs(KH.Keychains) do
  SMODS.Consumable {
    key = keychain,
    set = 'kh_keyblade',

    atlas = KH.Keychains[keychain] and KH.Keychains[keychain].keyblade_atlas or "kh_KHKeyblade",
    pos = KH.Keychains[keychain] and KH.Keychains[keychain].keyblade_pos or { x = 0, y = 0 },

    loc_txt = {
      ['default'] = {
        name = "#1#",
        text = {
          "Attach {V:1}#1#{} to",
          "{C:attention}#2#{} selected {C:attention}Joker{}"
        },
      },
    },

    cost = 5,
    config = { extra = { max_highlighted = 1 } },

    loc_vars = function(self, info_queue, card)
      local vars = KH.Keychains[keychain]:loc_vars()["vars"]
      info_queue[#info_queue + 1] = { key = keychain .. "_keychain", set = "Other", vars = vars }
      return {
        vars = {
          G.localization.misc.labels[keychain .. "_keychain"],
          card.ability.extra.max_highlighted,
          colours = {
            G.P_KH_KEYCHAINS[keychain].badge_colour or G.C.FILTER
          }
        }
      }
    end,

    use = function(self, card, area, copier)
      for i = 1, #G.jokers.highlighted do
        G.jokers.highlighted[i]:kh_set_keychain(keychain)
        G.jokers.highlighted[i]:juice_up()
      end
      G.jokers:unhighlight_all()
    end,
    can_use = function(self, card)
      if card.ability.extra.max_highlighted > 1 and #G.jokers.highlighted > 1 then -- for the odd case where someone value manipulates these cards
        for i = 1, #G.jokers.highlighted do
          if G.jokers.highlighted[i].kh_keychain and G.jokers.highlighted[i].kh_keychain == keychain then
            return false
          end
        end
      end

      if G.jokers.highlighted[1] and G.jokers.highlighted[1].kh_keychain and G.jokers.highlighted[1].kh_keychain == keychain then
        return false
      end

      return G.jokers and G.jokers.highlighted[1] and #G.jokers.highlighted <= card.ability.extra.max_highlighted
    end,
  }
end
