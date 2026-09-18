MIX.reroll_tag = function(blind_type)
  if G.GAME.round_resets.blind_states[blind_type] ~= 'Skipped' then
    G.GAME.round_resets.blind_tags[blind_type] = get_next_tag_key()

    local tag = G.blind_select:get_UIE_by_ID(blind_type).UIBox:get_UIE_by_ID('tag_container').config.ref_table

    local new_tag = G.P_TAGS[G.GAME.round_resets.blind_tags[blind_type]]

    tag.key = new_tag.key
    tag.name = new_tag.name
    tag.config = copy_table(new_tag.config)
    tag.pos = new_tag.pos
    tag.ability = new_tag.ability

    local new_atlas = new_tag.atlas or "tags"
    tag.tag_sprite.atlas = SMODS.get_atlas(new_atlas)

    tag.tag_sprite.sprite_pos = new_tag.pos

    tag:juice_up()
  end
end


SMODS.Joker {
  attributes = { "reference", "FinalMix", "economy", "tag" },
  key = 'book_of_prophecies',

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    return {
      vars = { cae.cost }
    }
  end,

  atlas = "KHJokers",
  pos = { x = 4, y = 5 },
  rarity = 1,
  cost = 4,
  blueprint_compat = true,

  config = {
    extra = {
      cost = 3
    }
  },

  calculate = function(self, card, context)
  end,

  can_use = function(self, card)
    return
        G.STATE == G.STATES.BLIND_SELECT and G.blind_select and
        G.GAME.round_resets.blind_states["Small"] ~= 'Skipped' and
        G.GAME.round_resets.blind_states["Big"] ~= 'Skipped' and
        G.GAME.dollars - G.GAME.bankrupt_at >= card.ability.extra.cost
  end,

  kh_use_config = {
    colour = G.C.GREEN,
    text = localize("k_reroll"):upper(),
    cost = 3,
  },

  use = function(self, card, area, copier)
    stop_use()
    ease_dollars(-card.ability.extra.cost)

    MIX.reroll_tag("Small")
    MIX.reroll_tag("Big")

    SMODS.calculate_effect({ message = localize("k_kh_rerolled_ex") }, card)

    save_run()
  end,
}
