---@diagnostic disable: undefined-global

Partner_API.Partner {
  key = "sora",
  pos = { x = 0, y = 0 },
  atlas = "KHPartner",
  config = { extra = { Xmult = 0.1 } },
  link_config = { j_kh_sora = 1 },
  loc_vars = function(self, info_queue, card)
    local link_level = self:get_link_level()
    local benefits = 1
    if link_level == 1 then benefits = 2 end
    return { vars = { card.ability.extra.Xmult * benefits } }
  end,
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play then
      if context.other_card:is_suit("Hearts") then
        local link_level = self:get_link_level()
        local benefits = 1
        if link_level == 1 then benefits = 2 end
        context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult or 0
        context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult +
            card.ability.extra.Xmult * benefits
        SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.FILTER }, card)
      end
    end
  end,
}

Partner_API.Partner { -- art is currently placeholder, will change eventually
  key = "donald",
  pos = { x = 1, y = 0 },
  atlas = "KHPartner",
  config = { extra = { copied_joker_key = nil } },
  link_config = { j_kh_donald = 1 },
  loc_vars = function(self, info_queue, card)
    local _key = card.ability.extra.copied_joker_key
    local copied_name = _key and localize({ type = 'name_text', set = "Joker", key = _key }) or
        localize("k_none")

    return {
      vars = {
        copied_name
      }
    }
  end,
  calculate = function(self, card, context)
    if context.after and not context.blueprint and G.jokers and #G.jokers.cards > 1 then
      local available_jokers = {}

      for _, joker in ipairs(G.jokers.cards) do
        if joker ~= card and joker.config.center.blueprint_compat then
          table.insert(available_jokers, joker)
        end
      end

      if #available_jokers > 0 then
        local random_joker = pseudorandom_element(available_jokers, pseudoseed("randompartner"))
        card.ability.extra.copied_joker_key = random_joker.config.center.key

        SMODS.calculate_effect({ message = localize('k_kh_copying'), colour = G.C.FILTER }, card)
      else
        card.ability.extra.copied_joker_key = nil
      end
    end

    if card.ability.extra.copied_joker_key and not card.debuff and G.jokers then
      local copied_joker = MIX.get_joker_by_key(G.jokers.cards, card.ability.extra.copied_joker_key)

      local copied_joker_ret = SMODS.blueprint_effect(card, copied_joker, context)
      if copied_joker_ret then
        return copied_joker_ret
      end
    end
  end,
}

Partner_API.Partner {
  key = "randompartner",
  pos = { x = 3, y = 0 },
  atlas = "KHPartner",
  config = {
    extra = {
      percent = 0,
      percent_plus = 1,
      cost = 1,
    }
  },
  link_config = { j_kh_randomjoker = 1 },
  loc_vars = function(self, info_queue, card)
    local link_level = self:get_link_level()
    local benefits = 1
    if link_level == 1 then benefits = 2 end
    return {
      vars = {
        card.ability.extra.percent,
        card.ability.extra.percent_plus * benefits,
        card.ability.extra.cost,
      }
    }
  end,

  calculate = function(self, card, context)
    if context.final_scoring_step and card.ability.extra.percent > 0 then
      return {
        kh_balance_percent = card.ability.extra.percent
      }
    end
    if context.partner_click and (G.GAME.dollars - G.GAME.bankrupt_at >= card.ability.extra.cost) then
      local link_level = self:get_link_level()
      local benefits = 1
      if link_level == 1 then benefits = 2 end
      card.ability.extra.percent = card.ability.extra.percent + card.ability.extra.percent_plus * benefits
      ease_dollars(-card.ability.extra.cost)
      card_eval_status_text(card, "dollars", -card.ability.extra.cost)
    end
  end
}

Partner_API.Partner {
  key = "nobody",
  atlas = "KHPartner",
  pos = { x = 0, y = 1 },
  soul_pos = { x = 1, y = 1 },
  config = {
    extra = {}
  },
  link_config = { j_kh_nobody = 1 },
  loc_vars = function(self, info_queue, card)
    return {
      vars = {}
    }
  end,
}

local old_smods_scorecard = SMODS.score_card
---@diagnostic disable-next-line: duplicate-set-field
function SMODS.score_card(card, context)
  local has_nobody_partner = false

  if G.GAME.selected_partner_card
  and G.GAME.selected_partner_card.config
  and G.GAME.selected_partner_card.config.center
  and G.GAME.selected_partner_card.config.center.key == "pnr_kh_nobody" then
    has_nobody_partner = true
  end

  if has_nobody_partner and context.cardarea == G.hand and not G.scorehand then
    local first_card = G.hand.cards[1]
    local last_card = G.hand.cards[#G.hand.cards]
    if card == first_card or card == last_card then
      G.scorehand = true
      context.cardarea = G.play
      SMODS.score_card(card, context)
      context.cardarea = G.hand
      G.scorehand = nil
    end
  end

  return old_smods_scorecard(card, context)
end
