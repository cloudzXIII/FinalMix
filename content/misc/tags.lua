SMODS.Tag {
  key = "kingdom",
  atlas = "KHTags",
  pos = { x = 0, y = 0 },
  config = {},
  apply = function(self, tag, context)
    if context.type == 'store_joker_create' then
      local card = SMODS.create_card {
        set = "Joker",
        attributes = { "FinalMix" },
        area = context.area,
      }
      create_shop_card_ui(card, 'Joker', context.area)
      card.states.visible = false

      tag:yep('+', G.C.PURPLE, function()
        play_sound('timpani')
        card:start_materialize()
        card.ability.couponed = true
        card:set_cost()
        return true
      end)
      tag.triggered = true
      return card
    end
  end
}

SMODS.Tag {
  key = "guiding",
  atlas = "KHTags",
  pos = { x = 1, y = 0 },
  config = {},
  loc_vars = function(self, info_queue, tag)
    info_queue[#info_queue + 1] = G.P_CENTERS.p_kh_keyblade_mega_1
  end,
  apply = function(self, tag, context)
    if context.type == 'new_blind_choice' then
      local lock = tag.ID
      G.CONTROLLER.locks[lock] = true
      tag:yep('+', G.C.PURPLE, function()
        local booster = SMODS.create_card { key = 'p_kh_keyblade_mega_1', area = G.play }
        booster.T.x = G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2
        booster.T.y = G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2
        booster.T.w = G.CARD_W * 1.27
        booster.T.h = G.CARD_H * 1.27
        booster.cost = 0
        booster.from_tag = true
        G.FUNCS.use_card({ config = { ref_table = booster } })
        booster:start_materialize()
        G.CONTROLLER.locks[lock] = nil
        return true
      end)
      tag.triggered = true
      return true
    end
  end
}

SMODS.Tag {
  key = "chained",
  atlas = "KHTags",
  pos = { x = 2, y = 0 },
  config = {},
  loc_vars = function(self, info_queue, tag)
  end,
  apply = function(self, tag, context)
    if context.type == 'store_joker_modify' then
      if not context.card.edition and not context.card.temp_edition and context.card.ability.set == 'Joker' then
        local lock = tag.ID
        G.CONTROLLER.locks[lock] = true
        context.card.temp_edition = true
        tag:yep('+', G.C.SET.kh_keyblade, function()
          local keychain = MIX.poll_keychain("tag_kh_chained", { card = context.card })
          context.card:kh_set_keychain(keychain)
          context.card:juice_up(0.3, 0.5)
          context.card.ability.couponed = true
          context.card:set_cost()
          G.CONTROLLER.locks[lock] = nil
          return true
        end)
        tag.triggered = true
        return true
      end
    end
  end
}
