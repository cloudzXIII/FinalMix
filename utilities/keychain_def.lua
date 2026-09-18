KH.Keychains = {}

G.P_KH_KEYCHAINS = G.P_KH_KEYCHAINS or {}
G.shared_kh_keychains = {}

MIX.Keychain = SMODS.GameObject:extend({
  obj_table = KH.Keychains,
  set = 'kh_keychain',
  obj_buffer = {},
  rng_buffer = {},
  atlas = 'kh_KHKeychains',
  discovered = true,
  badge_to_key = {},
  badge_colour = HEX('FFFFFF'),
  unlocked = true,
  pos = { x = 0, y = 0 },
  config = {},

  extra_cost = nil,

  required_params = {
    'key',
  },
  inject = function(self)
    G.P_KH_KEYCHAINS[self.key] = self
    G.shared_kh_keychains[self.key] = SMODS.create_sprite(0, 0, G.CARD_W, G.CARD_H,
      SMODS.get_atlas(self.atlas) or SMODS.get_atlas('centers'), self.pos)
    self.badge_to_key[self.key:lower() .. '_keychain'] = self.key
    SMODS.insert_pool(G.P_CENTER_POOLS[self.set], self)
    self.rng_buffer[#self.rng_buffer + 1] = self.key
  end,
  get_obj = function(self, key) return G.P_KH_KEYCHAINS[key] end,
  generate_ui = function(self, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    local target = {
      type = 'other',
      set = 'Other',
      key = self.key:lower() .. '_keychain',
      nodes = desc_nodes,
      vars = specific_vars or {},
    }
    local res = {}
    if self.loc_vars and type(self.loc_vars) == 'function' then
      res = self:loc_vars(info_queue, card) or {}
      target.vars = res.vars or target.vars
      target.key = res.key or target.key
      if res.set then
        target.type = 'descriptions'
        target.set = res.set
      end
      target.scale = res.scale
      target.text_colour = res.text_colour
    end
    if desc_nodes == full_UI_table.main and not full_UI_table.name then
      full_UI_table.name = localize { type = 'name', set = target.set, key = res.name_key or target.key, nodes = full_UI_table.name, vars = res.name_vars or target.vars or {} }
    elseif desc_nodes ~= full_UI_table.main and not desc_nodes.name then
      desc_nodes.name = localize { type = 'name_text', key = res.name_key or target.key, set = target.set }
    end
    if res.main_start then
      desc_nodes[#desc_nodes + 1] = res.main_start
    end
    localize(target)
    if res.main_end then
      desc_nodes[#desc_nodes + 1] = res.main_end
    end
    desc_nodes.background_colour = res.background_colour
  end,
})

SMODS.DrawStep {
  key = 'kh_keychain',
  order = 33,
  func = function(self, layer)
    if self.kh_keychain ~= nil and G.shared_kh_keychains[self.kh_keychain] then
      local x_offset = (self.T.w / 71) * -20 * self.T.scale
      G.shared_kh_keychains[self.kh_keychain].role.draw_major = self
      G.shared_kh_keychains[self.kh_keychain]:draw_shader('dissolve', nil, nil, nil, self.children.center, nil, nil,
        x_offset)
      G.shared_kh_keychains[self.kh_keychain]:draw_shader('voucher', nil, self.ARGS.send_to_shader, nil,
        self.children.center, nil, nil, x_offset)
    end
  end,
  conditions = { vortex = false, },
}

KH.custom_collection_tabs = function()
  return {
    UIBox_button({
      button = 'your_collection_kh_keychains',
      label = { localize("b_kh_keychains") },
      minw = 5,
      id = 'your_collection_kh_keychains',
    }),
  }
end

G.FUNCS.your_collection_kh_keychains = function()
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu {
    definition = create_UIBox_kh_keychains(),
  }
end

function create_UIBox_kh_keychains()
  return SMODS.card_collection_UIBox(G.P_CENTER_POOLS["kh_keychain"], { 4, 4 }, {
    snap_back = true,
    infotip = localize('ml_keyblade_explanation'),
    hide_single_page = true,
    collapse_single_page = true,
    no_materialize = true,
    center = 'c_base',
    h_mod = 1.18,
    back_func = 'your_collection_other_gameobjects',
    modify_card = function(card, center)
      card:kh_set_keychain(center.key)
      card.children.center.atlas = G.ASSET_ATLAS["Joker"]
      card.children.center:set_sprite_pos({ x = 0, y = 0 })
    end,
  })
end

function Card:kh_set_keychain(_keychain, silent)
  if not self.kh_keychain then self.kh_keychain = {} end
  if not self.ability.kh_keychain then self.ability.kh_keychain = {} end

  self.kh_keychain = _keychain

  for k, v in pairs(G.P_KH_KEYCHAINS[_keychain].config or {}) do
    self.ability.kh_keychain[k] = type(v) == 'table' and copy_table(v) or v
  end

  self:set_cost()
end

function Card:calculate_keychain(context)
  if self.debuff then return nil end
  if self.kh_keychain ~= nil then
    local obj = G.P_KH_KEYCHAINS[self.kh_keychain] or {}
    if obj.calculate and type(obj.calculate) == 'function' then
      local o = obj:calculate(self, context)
      if o then
        if not o.card then o.card = self end
        return o
      end
    end
  end
end
