-- Borrowed logic for this from the hit mod, Fish and Chips! Quite nifty innit (https://github.com/Balatro-Potato-Patch/Fish-and-Chips)

local g_uidef_card_h_popup_ref = G.UIDEF.card_h_popup
---@diagnostic disable-next-line: duplicate-set-field
function G.UIDEF.card_h_popup(card)
  if card.ability and card.ability.set == 'Joker' and not KH.config.disable_flavour then
    KH.tooltip_seed = (KH.tooltip_seed or 0) + 1
  end
  local ret = g_uidef_card_h_popup_ref(card)
  -- Flavour text addition
  if card.ability and card.ability.set == 'Joker' and not KH.config.disable_flavour and card.config.center.discovered then
    local name = SMODS.deepfind(ret, 'tooltip_id_' .. KH.tooltip_seed, nil, true)[1]
    local name_node = name and name.objtree or nil
    local flavour_node = {}
    local loc_vars = G.P_CENTERS[card.config.center_key] and G.P_CENTERS[card.config.center_key].loc_vars and
        G.P_CENTERS[card.config.center_key]:loc_vars({}, card) or {}
    local key = loc_vars.key or card.config.center_key
    if G.localization.descriptions.Joker[key] and G.localization.descriptions.Joker[key].kh_flavour_parsed then
      localize({
        type = 'flavour',
        nodes = flavour_node,
        loc_target = G.localization.descriptions.Joker[key],
        scale = 0.8,
        text_colour = G.C.JOKER_GREY,
        shadow = true,
        vars = loc_vars.vars
      })
      local final_flavour = { { n = G.UIT.R, config = { minh = 0.1 } } }
      for i, line in ipairs(flavour_node) do
        local node = { n = G.UIT.R, config = { align = 'cm' }, nodes = {} }
        for _, part in ipairs(line) do
          table.insert(node.nodes, part)
        end
        table.insert(final_flavour, i, node)
      end
      table.insert(name_node[#name_node - 3], name.tree[#name.tree - 2] + 1,
        { n = G.UIT.R, config = { align = 'cm' }, nodes = final_flavour })
    end
  end
  return ret
end

local name_from_hook = name_from_rows
---@diagnostic disable-next-line: duplicate-set-field, lowercase-global
function name_from_rows(name_nodes, background_colour)
  local ret = name_from_hook(name_nodes, background_colour)
  if ret then ret.config.id = 'tooltip_id_' .. (KH.tooltip_seed or 1) end
  return ret
end
