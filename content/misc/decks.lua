-- Decks
SMODS.Back {
  key = 'rechain',
  atlas = 'KHDecks',
  pos = { x = 0, y = 0 },
  config = { voucher = "v_kh_inheritance_ceremony", consumable_slot = 1 },

  loc_vars = function(self, info_queue, back)
    return {
      vars = {
        localize { type = 'name_text', key = self.config.voucher, set = 'Voucher' },
        self.config.consumable_slot
      }
    }
  end,
}
