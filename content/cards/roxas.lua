SMODS.Joker {
  attributes = { "reference", "FinalMix", },
  key = 'roxas',
  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return { vars = { cae.amount } }
  end,

  atlas = "KHJokers",
  pos = { x = 1, y = 0 },
  rarity = 2,
  cost = 6,
  blueprint_compat = false,

  config = {
    extra = {
      keychains = {},
      amount = 1
    },
    temp_kh_keychain = {}
  },

  calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint then
      local keychains = {}
      local exclude = {
        ["kh_lady_luck"] = true,
        ["kh_olympia"] = true, -- to remove once rework is done
        ["kh_sweet_memories"] = true,
      }

      for k, v in pairs(KH.Keychains) do
        if not exclude[k] and not MIX.table_contains(card.ability.extra.keychains, k) then
          keychains[#keychains + 1] = k
        elseif card:has_attribute("chance") and k == "kh_lady_luck" then
          keychains[#keychains + 1] = k
        end
      end

      card.ability.extra.keychains = {}
      card.ability.temp_kh_keychain = {}


      for i = 1, card.ability.extra.amount do
        local random_keychain = pseudorandom_element(keychains, "kh_keychains" .. i)
        card.ability.extra.keychains[#card.ability.extra.keychains + 1] = random_keychain
        MIX.remove_from_table(keychains, random_keychain)
      end

      for _, v in ipairs(card.ability.extra.keychains) do
        card.ability.temp_kh_keychain[v] = {}
        for kk, vv in pairs(G.P_KH_KEYCHAINS[v].config or {}) do
          card.ability.temp_kh_keychain[v][kk] = type(vv) == 'table' and copy_table(vv) or vv
        end
      end

      SMODS.calculate_effect({ message = localize('k_kh_copying'), colour = G.C.FILTER }, card)
    end
    if #card.ability.extra.keychains > 0 then
      for _, keychain in ipairs(card.ability.extra.keychains) do
        if KH.Keychains[keychain] then
          local obj = KH.Keychains[keychain]
          if obj.calculate and type(obj.calculate) == 'function' then
            --local o = obj.calculate(obj, card, context)
            local saved_config = obj.config
            obj.config = card.ability.temp_kh_keychain[keychain] or saved_config

            local o = obj.calculate(obj, card, context)

            -- Restore the original config
            obj.config = saved_config

            if o then
              return o
            end
          end
        end
      end
    end
  end,
}

local add_multiboxes_ref = MIX.add_extra_multiboxes
---@diagnostic disable-next-line: duplicate-set-field
function MIX.add_extra_multiboxes(_c, card, info_queue, desc_nodes, specific_vars, full_UI_table, ability, ...)
  add_multiboxes_ref(_c, card, info_queue, desc_nodes, specific_vars, full_UI_table, ability, ...)
  if G.jokers and _c.set == "Joker" and _c.key == "j_kh_roxas" then
    local cae = ability.extra
    if #cae.keychains > 0 then
      for _, keychain in ipairs(cae.keychains) do
        if KH.Keychains[keychain] and G.localization.descriptions.Other[keychain .. "_keychain"] then
          local loc = G.localization.descriptions.Other[keychain .. "_keychain"]
          local text = {}
          for i, v in ipairs(loc.name) do
            if i == 1 then
              text[#text + 1] = "{C:attention,s:0.8}" .. v
            elseif i == 2 then
              local modified = v:gsub("{f:5,s:0%.7}", "{C:green,f:5,s:0.65}")

              text[#text + 1] = modified or v
            end
          end
          for _, v in ipairs(loc.text) do
            text[#text + 1] = v
          end
          if #text > 0 then
            MIX.generate_ui_multiboxes({
              {
                localized_text = text,
                loc_vars = function(self, card, center)
                  local obj = KH.Keychains[keychain]
                  local saved_config = obj.config
                  obj.config = ability.temp_kh_keychain and ability.temp_kh_keychain[keychain] or saved_config

                  local loc_vars = obj.loc_vars(obj, card, center)

                  obj.config = saved_config

                  return loc_vars
                end
              }
            })(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table)
          end
        end
      end
    end
  end
end
