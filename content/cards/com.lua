SMODS.Joker {
  attributes = { "reference", "FinalMix", "hands", "mult", "chips" },
  key = "com",

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = {
        cae.last_played,
        cae.old_hand_chips,
        cae.old_hand_mult,
        " "
      }
    }
  end,

  rarity = 3,
  cost = 8,
  atlas = 'KHJokers',
  pos = { x = 2, y = 3 },

  blueprint_compat = false,

  config = {
    extra = {
      last_played = "None",
      old_hand_chips = 0,
      old_hand_mult = 0,
    }
  },
  calculate = function(self, card, context)
    if context.before and context.cardarea == G.play then
      card.ability.extra.last_played = context.scoring_name
    end
    if context.initial_scoring_step then
      card.ability.extra.last_played = context.scoring_name
      card.ability.extra.old_hand_chips = G.GAME.hands[G.GAME.last_hand_played].chips
      card.ability.extra.old_hand_mult = G.GAME.hands[G.GAME.last_hand_played].mult
    end
    if context.modify_hand then
      SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.FILTER }, card)
      hand_chips = mod_chips(hand_chips + card.ability.extra.old_hand_chips)
      mult = mod_mult(mult + card.ability.extra.old_hand_mult)
      update_hand_text({ sound = 'chips2', modded = true }, { chips = hand_chips, mult = mult })
    end
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        {
          border_nodes = {
            { ref_table = "card.ability.extra", ref_value = "old_hand_chips" }
          },
          border_colour = G.C.CHIPS
        },
        { text = " X " },
        {
          border_nodes = {
            { ref_table = "card.ability.extra", ref_value = "old_hand_mult" }
          },
        },
      },
      reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "last_played", colour = G.C.UI.TEXT_INACTIVE, },
        { text = ")" },
      },
      calc_function = function(card)
      end,
    }
  end
}
