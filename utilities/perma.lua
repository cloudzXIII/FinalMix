local add_multiboxes_ref = MIX.add_extra_multiboxes
---@diagnostic disable-next-line: duplicate-set-field
function MIX.add_extra_multiboxes(_c, card, info_queue, desc_nodes, specific_vars, full_UI_table, ability, ...)
  add_multiboxes_ref(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table, ability, ...)
  if G.jokers and _c.set == "Joker" then
    local joker_bonuses = {
      "kh_perma_bonus",
      "kh_perma_mult",
      "kh_perma_xmult",
      "kh_perma_xchips",
      "kh_perma_dollars",
      "kh_perma_rep",
    }

    local text = {}
    for _, perma_bonus in ipairs(joker_bonuses) do
      if ability[perma_bonus] and ability[perma_bonus] > 0 then
        text[#text + 1] = G.localization.misc.dictionary[perma_bonus]
      end
    end

    if #text > 0 then
      MIX.generate_ui_multiboxes({
        {
          localized_text = text,
          loc_vars = function(self, card, center)
            return {
              vars = {
                ability.kh_perma_bonus or 0,
                ability.kh_perma_mult or 0,
                ability.kh_perma_xmult or 0,
                ability.kh_perma_xchips or 0,
                ability.kh_perma_dollars or 0,
                ability.kh_perma_rep or 0
              }
            }
          end
        }
      })(_c, info_queue, card, desc_nodes, specific_vars, full_UI_table)
    end
  end
end
