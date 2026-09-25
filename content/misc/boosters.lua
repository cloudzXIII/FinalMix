local pos = {
  normal = {
    { x = 0, y = 0 },
    { x = 1, y = 0 },
    { x = 2, y = 0 },
    { x = 3, y = 0 },
  },
  jumbo = {
    { x = 0, y = 1 },
    { x = 1, y = 1 },
  },
  mega = {
    { x = 2, y = 1 },
    { x = 3, y = 1 },
  }
}

for i = 1, #pos["normal"] or 4 do
  SMODS.Booster {
    key = 'keyblade_normal_' .. i,

    atlas = "KHBoosters",
    pos = pos["normal"][i],
    config = { extra = 3, choose = 1 },

    weight = 0.8,
    cost = 4,

    kind = "kh_Keyblade",

    group_key = 'k_kh_keyblade_pack',
    discovered = false,

    create_card = function(self, card, i)
      return {
        set = "kh_keyblade",
        area = G.pack_cards,
        skip_materialize = true,
        soulable = true,
        key_append = "kh_keyblade"
      }
    end,

    loc_vars = function(self, info_queue, card)
      local cfg = (card and card.ability) or self.config
      return {
        vars = {
          math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
            math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
          math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))
        },
        key = self.key:sub(1, -3),
      }
    end,

    ease_background_colour = function(self)
      ease_colour(G.C.DYN_UI.MAIN, G.C.SET.kh_keyblade)
      ease_background_colour({ new_colour = G.C.BLUE, special_colour = G.C.JOKER_GREY, contrast = 2 })
    end,
  }
end

for i = 1, #pos["jumbo"] or 2 do
  SMODS.Booster {
    key = 'keyblade_jumbo_' .. i,

    atlas = "KHBoosters",
    pos = pos["jumbo"][i],
    config = { extra = 5, choose = 1 },

    weight = 0.8,
    cost = 6,

    kind = "kh_Keyblade",

    group_key = 'k_kh_keyblade_pack',
    discovered = false,

    create_card = function(self, card, i)
      return {
        set = "kh_keyblade",
        area = G.pack_cards,
        skip_materialize = true,
        soulable = true,
        key_append = "kh_keyblade"
      }
    end,

    loc_vars = function(self, info_queue, card)
      local cfg = (card and card.ability) or self.config
      return {
        vars = {
          math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
            math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
          math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))
        },
        key = self.key:sub(1, -3),
      }
    end,

    ease_background_colour = function(self)
      ease_colour(G.C.DYN_UI.MAIN, G.C.SET.kh_keyblade)
      ease_background_colour({ new_colour = G.C.BLUE, special_colour = G.C.JOKER_GREY, contrast = 2 })
    end,
  }
end


for i = 1, #pos["mega"] or 2 do
  SMODS.Booster {
    key = 'keyblade_mega_' .. i,

    atlas = "KHBoosters",
    pos = pos["mega"][i],
    config = { extra = 5, choose = 2 },

    weight = 0.25,
    cost = 8,

    kind = "kh_Keyblade",

    group_key = 'k_kh_keyblade_pack',
    discovered = false,

    create_card = function(self, card, i)
      return {
        set = "kh_keyblade",
        area = G.pack_cards,
        skip_materialize = true,
        soulable = true,
        key_append = "kh_keyblade"
      }
    end,

    loc_vars = function(self, info_queue, card)
      local cfg = (card and card.ability) or self.config
      return {
        vars = {
          math.min(cfg.choose + (G.GAME.modifiers.booster_choice_mod or 0),
            math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))),
          math.max(1, cfg.extra + (G.GAME.modifiers.booster_size_mod or 0))
        },
        key = self.key:sub(1, -3),
      }
    end,

    ease_background_colour = function(self)
      ease_colour(G.C.DYN_UI.MAIN, G.C.SET.kh_keyblade)
      ease_background_colour({ new_colour = G.C.BLUE, special_colour = G.C.JOKER_GREY, contrast = 2 })
    end,
  }
end
