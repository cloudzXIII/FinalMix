SMODS.Joker {
  attributes = { "reference", "FinalMix", "food", "enhancements", "seals", "editions" },
  key = "paopufruit",

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = {
        cae.hands_left
      }
    }
  end,

  rarity = 2,
  atlas = "KHJokers",
  pos = { x = 7, y = 0 },
  cost = 6,

  blueprint_compat = false,
  eternal_compat = false,

  config = {
    extra = {
      hands_left = 5
    }
  },

  calculate = function(self, card, context)
    if context.before and not context.blueprint then
      local first_card = context.scoring_hand[1]
      local edition = SMODS.poll_edition({
        guaranteed = true,
        options = { 'e_polychrome', 'e_holo', 'e_foil' },
        key = "kh_paopufruit"
      })
      local random_seal = SMODS.poll_seal { key = "kh_seed", guaranteed = true }
      local enhancement = SMODS.poll_enhancement { key = "kh_seed", guaranteed = true }
      first_card:set_edition(edition, true)
      first_card:set_seal(random_seal, true)
      first_card:set_ability(enhancement, true)
    end

    if context.after and not context.blueprint then
      if card.ability.extra.hands_left - 1 <= 0 then
        SMODS.destroy_cards(card)
        SMODS.calculate_effect({ message = localize('k_kh_riku_no'), colour = G.C.FILTER }, card)
      else
        card.ability.extra.hands_left = card.ability.extra.hands_left - 1
        return {
          message = card.ability.extra.hands_left .. "",
          colour = G.C.FILTER
        }
      end
    end
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "hands_left" },
        { text = ")" },
      },
    }
  end
}
