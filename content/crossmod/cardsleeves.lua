---@diagnostic disable: undefined-global

CardSleeves.Sleeve {
  key = 'rechain',
  deck_buff = 'b_kh_rechain',
  atlas = 'KHSleeves',
  pos = { x = 0, y = 0 },
  config = { consumable_slot = 1 },

  loc_vars = function(self)
    local key, vars
    if self.get_current_deck_key() == "b_kh_rechain" then
      key = self.key .. "_alt"
      self.config = { vouchers = { "v_kh_keyblade_mastery" } }
      vars = { localize { type = 'name_text', key = self.config.vouchers[1], set = 'Voucher' } }
    else
      key = self.key
      self.config = { vouchers = { "v_kh_inheritance_ceremony", consumable_slot = 1 } }
      vars = { localize { type = 'name_text', key = self.config.vouchers[1], set = 'Voucher' }, 1 }
    end
    return { key = key, vars = vars }
  end,
}
