SMODS.Booster({
  key = 'keyblade_normal_1',

  atlas = 'KHBoosters',
  pos = { x = 0, y = 0 },
  config = { extra = 3, choose = 1 },

  weight = 0.8,
  cost = 4,

  kind = "kh_Keyblade",
  group_key = 'kh_keyblade_pack',
  discovered = false,

  create_card = function(self, card)
    return {
      set = "kh_keyblade",
      area = G.pack_cards,
      skip_materialize = true,
      soulable = true,
      key_append = "kh_keyblade_cards"
    }
  end,

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.choose, card.ability.extra }, key = self.key:sub(1, -3), }
  end,

  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SET.kh_keyblade)
    ease_background_colour({ new_colour = G.C.BLUE, special_colour = G.C.JOKER_GREY, contrast = 2 })
  end,
})

SMODS.Booster({
  key = 'keyblade_normal_2',

  atlas = 'KHBoosters',
  pos = { x = 1, y = 0 },
  config = { extra = 3, choose = 1 },

  weight = 0.8,
  cost = 4,

  kind = "kh_Keyblade",
  group_key = 'kh_keyblade_pack',
  discovered = false,

  create_card = function(self, card)
    return {
      set = "kh_keyblade",
      area = G.pack_cards,
      skip_materialize = true,
      soulable = true,
      key_append = "kh_keyblade_cards"
    }
  end,

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.choose, card.ability.extra }, key = self.key:sub(1, -3), }
  end,

  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SET.kh_keyblade)
    ease_background_colour({ new_colour = G.C.BLUE, special_colour = G.C.JOKER_GREY, contrast = 2 })
  end,
})

SMODS.Booster({
  key = 'keyblade_normal_3',

  atlas = 'KHBoosters',
  pos = { x = 2, y = 0 },
  config = { extra = 3, choose = 1 },

  weight = 0.8,
  cost = 4,

  kind = "kh_Keyblade",
  group_key = 'kh_keyblade_pack',
  discovered = false,

  create_card = function(self, card)
    return {
      set = "kh_keyblade",
      area = G.pack_cards,
      skip_materialize = true,
      soulable = true,
      key_append = "kh_keyblade_cards"
    }
  end,

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.choose, card.ability.extra }, key = self.key:sub(1, -3), }
  end,

  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SET.kh_keyblade)
    ease_background_colour({ new_colour = G.C.BLUE, special_colour = G.C.JOKER_GREY, contrast = 2 })
  end,
})

SMODS.Booster({
  key = 'keyblade_normal_4',

  atlas = 'KHBoosters',
  pos = { x = 3, y = 0 },
  config = { extra = 3, choose = 1 },

  weight = 0.8,
  cost = 4,

  kind = "kh_Keyblade",
  group_key = 'kh_keyblade_pack',
  discovered = false,

  create_card = function(self, card)
    return {
      set = "kh_keyblade",
      area = G.pack_cards,
      skip_materialize = true,
      soulable = true,
      key_append = "kh_keyblade_cards"
    }
  end,

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.choose, card.ability.extra }, key = self.key:sub(1, -3), }
  end,

  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SET.kh_keyblade)
    ease_background_colour({ new_colour = G.C.BLUE, special_colour = G.C.JOKER_GREY, contrast = 2 })
  end,
})

SMODS.Booster({
  key = 'keyblade_jumbo_1',

  atlas = 'KHBoosters',
  pos = { x = 0, y = 1 },
  config = { extra = 5, choose = 1 },

  weight = 0.8,
  cost = 6,

  kind = "kh_Keyblade",
  group_key = 'kh_keyblade_pack',
  discovered = false,

  create_card = function(self, card)
    return {
      set = "kh_keyblade",
      area = G.pack_cards,
      skip_materialize = true,
      soulable = true,
      key_append = "kh_keyblade_cards"
    }
  end,

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.choose, card.ability.extra }, key = self.key:sub(1, -3), }
  end,

  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SET.kh_keyblade)
    ease_background_colour({ new_colour = G.C.BLUE, special_colour = G.C.JOKER_GREY, contrast = 2 })
  end,
})

SMODS.Booster({
  key = 'keyblade_jumbo_2',

  atlas = 'KHBoosters',
  pos = { x = 1, y = 1 },
  config = { extra = 5, choose = 1 },

  weight = 0.8,
  cost = 6,

  kind = "kh_Keyblade",
  group_key = 'kh_keyblade_pack',
  discovered = false,

  create_card = function(self, card)
    return {
      set = "kh_keyblade",
      area = G.pack_cards,
      skip_materialize = true,
      soulable = true,
      key_append = "kh_keyblade_cards"
    }
  end,

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.choose, card.ability.extra }, key = self.key:sub(1, -3), }
  end,

  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SET.kh_keyblade)
    ease_background_colour({ new_colour = G.C.BLUE, special_colour = G.C.JOKER_GREY, contrast = 2 })
  end,
})

SMODS.Booster({
  key = 'keyblade_mega_1',

  atlas = 'KHBoosters',
  pos = { x = 2, y = 1 },
  config = { extra = 5, choose = 2 },

  weight = 0.25,
  cost = 8,

  kind = "kh_Keyblade",
  group_key = 'kh_keyblade_pack',
  discovered = false,

  create_card = function(self, card)
    return {
      set = "kh_keyblade",
      area = G.pack_cards,
      skip_materialize = true,
      soulable = true,
      key_append = "kh_keyblade_cards"
    }
  end,

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.choose, card.ability.extra }, key = self.key:sub(1, -3), }
  end,

  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SET.kh_keyblade)
    ease_background_colour({ new_colour = G.C.BLUE, special_colour = G.C.JOKER_GREY, contrast = 2 })
  end,
})

SMODS.Booster({
  key = 'keyblade_mega_2',

  atlas = 'KHBoosters',
  pos = { x = 3, y = 1 },
  config = { extra = 5, choose = 2 },

  weight = 0.25,
  cost = 8,

  kind = "kh_Keyblade",
  group_key = 'kh_keyblade_pack',
  discovered = false,

  create_card = function(self, card)
    return {
      set = "kh_keyblade",
      area = G.pack_cards,
      skip_materialize = true,
      soulable = true,
      key_append = "kh_keyblade_cards"
    }
  end,

  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.choose, card.ability.extra }, key = self.key:sub(1, -3), }
  end,

  ease_background_colour = function(self)
    ease_colour(G.C.DYN_UI.MAIN, G.C.SET.kh_keyblade)
    ease_background_colour({ new_colour = G.C.BLUE, special_colour = G.C.JOKER_GREY, contrast = 2 })
  end,
})
