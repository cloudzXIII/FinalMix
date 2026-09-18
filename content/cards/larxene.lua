SMODS.Joker {
  attributes = { "reference", "FinalMix", "reroll", "chance" },
  key = "larxene",

  loc_vars = function(self, info_queue, card)
    local cae = card.ability.extra
    local numerator, denominator = SMODS.get_probability_vars(card, cae.base, cae.odds,
      'larxene')
    return {
      vars = {
        numerator,
        denominator
      }
    }
  end,

  rarity = 2,
  cost = 6,
  atlas = 'KHJokers',
  pos = { x = 5, y = 4 },

  config = {
    extra = {
      base = 1,
      odds = 6
    }
  },
  calculate = function(self, card, context)
    if context.reroll_shop and SMODS.pseudorandom_probability(card, 'xiii', card.ability.extra.base, card.ability.extra.odds, 'larxene') then
      G.E_MANAGER:add_event(Event({
        trigger = 'immediate',
        func = function()
          for i = #G.shop_booster.cards, 1, -1 do
            local c = G.shop_booster:remove_card(G.shop_booster.cards[i])
            c:remove()
            c = nil
          end
          G.GAME.current_round.used_packs = {}
          for i = 1, G.GAME.starting_params.boosters_in_shop + (G.GAME.modifiers.extra_boosters or 0) do
            if not G.GAME.current_round.used_packs[i] then
              G.GAME.current_round.used_packs[i] = get_pack('shop_pack').key
            end
            local booster = Card(G.shop_booster.T.x + G.shop_booster.T.w / 2,
              G.shop_booster.T.y, G.CARD_W * 1.27, G.CARD_H * 1.27, G.P_CARDS.empty,
              G.P_CENTERS[G.GAME.current_round.used_packs[i]],
              { bypass_discovery_center = true, bypass_discovery_ui = true })
            create_shop_card_ui(booster, 'Booster', G.shop_booster)
            booster.ability.booster_pos = i
            booster:start_materialize()
            G.shop_booster:emplace(booster)
          end
          SMODS.calculate_effect({ message = localize("k_kh_rerolled_ex") }, card)
          return true
        end
      }))
    end
  end,
  joker_display_def = function(JokerDisplay)
    ---@type JDJokerDefinition
    return {
      text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "odds", colour = G.C.GREEN },
        { text = ")" }
      },
      reminder_text = {
        { text = "(" .. localize("k_reroll") .. ")" },
      },
      calc_function = function(card)
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { card.ability.extra.base, card.ability.extra.odds } }
      end,
    }
  end
}
