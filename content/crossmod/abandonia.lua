---@diagnostic disable: undefined-global

SMODS.Atlas({
  key = "KHWeatherReport",
  path = "weather_report.png",
  px = 67,
  py = 75,
})

-- Weather Reports

ABN.WeatherReport {
  key = "munny_storm",
  atlas = "kh_KHWeatherReport",
  pos = { x = 0, y = 0 },

  config = { extra = {} },
  calculate = function(self, card, context)
    if context.money_altered and context.amount > 0 and context.kh_card then
      if context.kh_card ~= card then
        return {
          dollars = context.amount
        }
      end
    end
    self:destroy_at_end_of_round(card, context)
  end,
  dependencies = { "abandonia" },
  abn_artist_credits = {
    artist = "cloudzXIII",
    colour = G.C.GOLD
  },
  set_card_type_badge = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('k_kh_forecast'),
      get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.weather_report.text_colour,
      1.2)
  end,
}

ABN.WeatherReport {
  key = "hp_shower",
  atlas = "kh_KHWeatherReport",
  pos = { x = 1, y = 0 },

  config = { extra = {} },
  calculate = function(self, card, context)
    if context.individual and context.cardarea == G.play and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
      local is_first_enh = false
      for i, v in ipairs(context.scoring_hand) do
        if v.ability.set == "Enhanced" then
          is_first_enh = context.scoring_hand[i] == context.other_card
          break
        end
      end
      if is_first_enh then
        local tarot_key = nil
        for _, v in ipairs(G.P_CENTER_POOLS.Tarot) do
          if v and v.config and v.config.mod_conv then
            if SMODS.has_enhancement(context.other_card, v.config.mod_conv) then
              tarot_key = v.key
              break
            end
          end
        end

        if tarot_key then
          G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
          return {
            extra = {
              message = localize('k_plus_tarot'),
              colour = G.C.SECONDARY_SET.Tarot,
              message_card = card,
              func = function()
                G.E_MANAGER:add_event(Event({
                  func = (function()
                    SMODS.add_card {
                      set = 'Tarot',
                      key = tarot_key,
                      key_append = 'kh_hpshower'
                    }
                    G.GAME.consumeable_buffer = 0
                    return true
                  end)
                }))
              end
            },
          }
        end
      end
    end
    self:destroy_at_end_of_round(card, context)
  end,
  dependencies = { "abandonia" },
  abn_artist_credits = {
    artist = "cloudzXIII",
    colour = G.C.GOLD
  },
  set_card_type_badge = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('k_kh_forecast'),
      get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.weather_report.text_colour,
      1.2)
  end,
}

ABN.WeatherReport {
  key = "risky_winds",
  atlas = "kh_KHWeatherReport",
  pos = { x = 2, y = 0 },

  config = { extra = { odds = 4 } },

  loc_vars = function(self, info_queue, card)
    local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
    return {
      vars = {
        numerator,
        denominator,
      }
    }
  end,
  calculate = function(self, card, context)
    if context.after and not context.blueprint then
      if SMODS.pseudorandom_probability(card, 'kh_risky_winds', 1, card.ability.extra.odds) then
        return {
          func = function()
            local cards = G.play.cards

            for i, _card in ipairs(cards) do
              G.E_MANAGER:add_event(Event {
                trigger = 'after',
                delay = (i - 1) * 0.5,
                func = function()
                  play_sound('card1')
                  _card:juice_up(0.3, 0.3)
                  _card:flip()
                  return true
                end
              })
            end

            delay(1, "base")

            for i, _card in ipairs(cards) do
              G.E_MANAGER:add_event(Event {
                trigger = 'after',
                delay = 0.5,
                func = function()
                  local _rank = nil
                  local _suit = nil
                  while _rank == nil or _suit == nil do
                    _rank = pseudorandom_element(SMODS.Ranks, pseudoseed('akyrs2far'))
                    _suit = pseudorandom_element(SMODS.Suits, pseudoseed('akyrs2fas'))
                  end
                  assert(SMODS.change_base(_card, _suit.key, _rank.key))

                  play_sound("card1", math.abs(1.15 - (i - 0.999) / (#cards - 0.998) * 0.3))
                  _card:juice_up(0.3, 0.3)
                  _card:flip()

                  if _card.highlighted and _card.area then
                    _card.area:remove_from_highlighted(_card)
                  end
                  return true
                end
              }, "base")
            end

            delay(2.0)
          end,
          message = localize("k_kh_randomised_ex"),
        }
      else
        return {
          func = function()
            local cards = G.play.cards

            for i, _card in ipairs(cards) do
              G.E_MANAGER:add_event(Event {
                trigger = 'after',
                delay = (i - 1) * 0.5,
                func = function()
                  play_sound('card1')
                  _card:juice_up(0.3, 0.3)
                  _card:flip()
                  return true
                end
              })
            end

            delay(1, "base")

            for i, _card in ipairs(cards) do
              G.E_MANAGER:add_event(Event {
                trigger = 'after',
                delay = 0.5,
                func = function()
                  assert(SMODS.modify_rank(_card, 1))

                  play_sound("card1", math.abs(1.15 - (i - 0.999) / (#cards - 0.998) * 0.3))
                  _card:juice_up(0.3, 0.3)
                  _card:flip()

                  if _card.highlighted and _card.area then
                    _card.area:remove_from_highlighted(_card)
                  end
                  return true
                end
              }, "base")
            end

            delay(2.0)
          end,
          message = localize("k_kh_increased_ex"),
        }
      end
    end
    self:destroy_at_end_of_round(card, context)
  end,
  dependencies = { "abandonia" },
  abn_artist_credits = {
    artist = "cloudzXIII",
    colour = G.C.GOLD
  },
  set_card_type_badge = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('k_kh_forecast'),
      get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.weather_report.text_colour,
      1.2)
  end,
}

local function get_rarity_key(rarity)
  local rarities = { "Common", "Uncommon", "Rare", "Legendary" }
  if type(rarity) == "number" then
    return rarities[rarity]
  end
  return rarity
end

ABN.WeatherReport {
  key = "bargain_flurry",
  atlas = "kh_KHWeatherReport",
  pos = { x = 3, y = 0 },

  config = { extra = { rarity = nil, sells = 4 } },

  loc_vars = function(self, info_queue, card)
    local rarity = card.ability.extra.rarity and SMODS.Rarity:get_rarity_badge(card.ability.extra.rarity) or
        localize("k_none")
    return {
      vars = {
        rarity,
        card.ability.extra.sells,
        colours = { G.C.RARITY[rarity] or G.C.FILTER }
      }
    }
  end,

  can_use = function(self, card)
    return G.GAME.blind and G.GAME.blind.in_blind and G.jokers and G.jokers.highlighted[1] and #G.jokers.highlighted == 1
  end,

  use = function(self, card, area, copier)
    local joker = G.jokers.highlighted[1]
    G.E_MANAGER:add_event(Event({
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        card.ability.extra.rarity = get_rarity_key(joker.config.center.rarity)
        SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.FILTER }, card)
        return true
      end
    }))
    G.jokers:unhighlight_all()
    delay(0.4)
  end,

  calculate = function(self, card, context)
    if context.selling_card and card.ability.extra.rarity then
      card.ability.extra.sells = card.ability.extra.sells - 1

      SMODS.calculate_effect({ message = localize("k_plus_joker"), colour = G.C.RARITY[card.ability.extra.rarity] }, card)

      SMODS.add_card { area = G.jokers, set = "Joker", rarity = card.ability.extra.rarity }

      card.ability.extra.rarity = nil

      if card.ability.extra.sells <= 0 then
        SMODS.calculate_effect({ message = localize("k_extinct_ex") }, card)
        SMODS.destroy_cards(card, nil, nil, true)
      end
    end
    self:destroy_at_end_of_round(card, context)
  end,
  dependencies = { "abandonia" },
  abn_artist_credits = {
    artist = "cloudzXIII",
    colour = G.C.GOLD
  },
  set_card_type_badge = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('k_kh_forecast'),
      get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.weather_report.text_colour,
      1.2)
  end,
}

ABN.WeatherReport {
  key = "overcast",
  atlas = "kh_KHWeatherReport",
  pos = { x = 0, y = 1 },

  config = { extra = { x_blind_size = 1.25, chips_percent = 50 } },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.x_blind_size,
        card.ability.extra.chips_percent,
      }
    }
  end,

  calculate = function(self, card, context)
    if context.setting_blind then
      return {
        x_blind_size = card.ability.extra.x_blind_size
      }
    end
    if context.individual and context.cardarea == G.play then
      local total_chips = context.other_card:get_chip_bonus()
      return {
        chips = total_chips * (card.ability.extra.chips_percent / 100)
      }
    end
    self:destroy_at_end_of_round(card, context)
  end,
  dependencies = { "abandonia" },
  abn_artist_credits = {
    artist = "cloudzXIII",
    colour = G.C.GOLD
  },
  set_card_type_badge = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('k_kh_forecast'),
      get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.weather_report.text_colour,
      1.2)
  end,
}

ABN.WeatherReport {
  key = "ordinary_day",
  atlas = "kh_KHWeatherReport",
  pos = { x = 1, y = 1 },

  config = { extra = { h_size = 1 } },

  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.h_size,
      }
    }
  end,

  add_to_deck = function(self, card)
    G.E_MANAGER:add_event(Event({
      func = function()
        G.hand:change_size(card.ability.extra.h_size)
        return true
      end
    }))
  end,
  remove_from_deck = function(self, card)
    G.E_MANAGER:add_event(Event({
      func = function()
        G.hand:change_size(-card.ability.extra.h_size)
        return true
      end
    }))
  end,

  calculate = function(self, card, context)
    self:destroy_at_end_of_round(card, context)
  end,
  dependencies = { "abandonia" },
  abn_artist_credits = {
    artist = "cloudzXIII",
    colour = G.C.GOLD
  },
  set_card_type_badge = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('k_kh_forecast'),
      get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.weather_report.text_colour,
      1.2)
  end,
}

ABN.WeatherReport {
  key = "treasure_front",
  atlas = "kh_KHWeatherReport",
  pos = { x = 2, y = 1 },

  config = { extra = { odds = 4 } },

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_CENTERS.m_gold
    local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
    return {
      vars = {
        numerator,
        denominator,
      }
    }
  end,
  calculate = function(self, card, context)
    if context.pre_discard then
      local cards_to_enhance = {}
      for _, v in ipairs(context.full_hand) do
        if SMODS.pseudorandom_probability(card, 'kh_treasure_front', 1, card.ability.extra.odds) then
          cards_to_enhance[#cards_to_enhance + 1] = v
        end
      end
      if #cards_to_enhance > 0 then
        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.4,
          func = function()
            play_sound('tarot1')
            card:juice_up(0.3, 0.5)
            return true
          end
        }))
        for i = 1, #cards_to_enhance do
          local percent = 1.15 - (i - 0.999) / (#cards_to_enhance - 0.998) * 0.3
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
              cards_to_enhance[i]:flip()
              play_sound('card1', percent)
              cards_to_enhance[i]:juice_up(0.3, 0.3)
              return true
            end
          }))
        end
        delay(0.2)
        for i = 1, #cards_to_enhance do
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.1,
            func = function()
              cards_to_enhance[i]:set_ability("m_gold")
              return true
            end
          }))
        end
        for i = 1, #cards_to_enhance do
          local percent = 0.85 + (i - 0.999) / (#cards_to_enhance - 0.998) * 0.3
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
              cards_to_enhance[i]:flip()
              play_sound('tarot2', percent, 0.6)
              cards_to_enhance[i]:juice_up(0.3, 0.3)
              return true
            end
          }))
        end
        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          delay = 0.2,
          func = function()
            G.hand:unhighlight_all()
            return true
          end
        }))
        delay(0.5)
      end
    end
    self:destroy_at_end_of_round(card, context)
  end,
  dependencies = { "abandonia" },
  abn_artist_credits = {
    artist = "cloudzXIII",
    colour = G.C.GOLD
  },
  set_card_type_badge = function(self, card, badges)
    badges[#badges + 1] = create_badge(localize('k_kh_forecast'),
      get_type_colour(card.config.center or card.config, card), SMODS.ConsumableTypes.weather_report.text_colour,
      1.2)
  end,
}

-- Enhancement Stickers

SMODS.Atlas({
  key = "KHJokerStickers",
  path = "joker_stickers.png",
  px = 71,
  py = 95,
})

ABN.enh_stickers_list[#ABN.enh_stickers_list + 1] = "m_kh_recard"
ABN.enh_stickers_list[#ABN.enh_stickers_list + 1] = "m_kh_kingdomkey"

ABN.maps_enhancement_to_sticker["m_kh_recard"] = { mod = "Final Mix", sticker = "kh_stk_recard" }
ABN.maps_enhancement_to_sticker["m_kh_kingdomkey"] = { mod = "Final Mix", sticker = "kh_stk_kingdomkey" }

ABN.EnhSticker {
  key = 'stk_recard',
  atlas = "KHJokerStickers",
  pos = { x = 0, y = 0 },
  badge_colour = HEX("3982ad"),

  loc_vars = function(self, info_queue, card)
    return { vars = {} }
  end,
  config = {},

  calculate = function(self, card, context)
    if context.retrigger_joker_check and not context.retrigger_joker and G.GAME.current_round.hands_left == 0 then
      local pos = MIX.get_pos(card, G.jokers.cards)
      local left = G.jokers.cards[pos - 1]
      local right = G.jokers.cards[pos + 1]
      if (left and context.other_card == left) or (right and context.other_card == right) then
        return {
          message = localize("k_again_ex"),
          repetitions = 1,
          card = card,
        }
      end
    end
  end,
}

ABN.EnhSticker {
  key = 'stk_kingdomkey',
  atlas = "KHJokerStickers",
  pos = { x = 1, y = 0 },
  badge_colour = HEX("fc5f55"),

  loc_vars = function(self, info_queue, card)
    local cae = card and card.ability[self.key .. "_t"] or self.config.extra
    return { vars = { cae.x_mult, cae.x_mult_gain } }
  end,
  config = {
    extra = {
      x_mult = 1,
      x_mult_gain = 0.2
    }
  },

  apply = function(self, card, val)
    if val then
      for _, key in ipairs(ABN.enh_stickers_list) do
        card:remove_sticker(key)
      end
      card.ability[self.key .. "_t"] = {}

      for k, v in pairs(self.config.extra) do
        card.ability[self.key .. "_t"][k] = v
      end
    end
    card.ability[self.key] = val
  end,

  calculate = function(self, card, context)
    if context.post_trigger and context.other_card and context.other_card == card and not context.blueprint then
      local cae = card and card.ability[self.key .. "_t"] or self.config.extra
      cae.x_mult = cae.x_mult + cae.x_mult_gain
      return {
        message = localize("k_upgrade_ex"),
        colour = G.C.MULT
      }
    end

    if context.before and not context.blueprint then
      for _, v in ipairs(context.scoring_hand) do
        v.scoring = true
      end
      local count = 0
      for _, v in ipairs(context.full_hand) do
        if not v.scoring then
          count = count + 1
        end
      end
      if count == 3 then
        local cae = card and card.ability[self.key .. "_t"] or self.config.extra
        cae.x_mult = 1
        SMODS.calculate_effect({ message = localize("k_reset") }, card)
      end
    end

    if context.final_scoring_step then
      local cae = card and card.ability[self.key .. "_t"] or self.config.extra
      return {
        x_mult = cae.x_mult
      }
    end
  end,
}

ABN.CrimsonCard {
  key = "chained",

  atlas = "KHConsumables",
  pos = { x = 2, y = 2 },
  dependencies = { "abandonia" },
  config = { extra = { enh_key = "kh_stk_recard" } },

  loc_vars = function(self, info_queue, card)
    local sticker = card.ability.extra.enh_key

    if sticker then
      info_queue[#info_queue + 1] = { key = sticker, set = "Other", vars = SMODS.Stickers[sticker]:loc_vars()["vars"] }
    end
    return {
      vars = {
        localize { type = 'name_text', key = card.ability.extra.enh_key, set = 'Other' },
      }
    }
  end,

  use = function(self, card, area, copier)
    local c = G.jokers.cards[1]
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.15,
      func = function()
        c:flip()
        play_sound('card1', 1)
        c:juice_up(0.3, 0.3)
        return true
      end
    }))
    G.E_MANAGER:add_event(Event({
      func = function()
        c:add_sticker(card.ability.extra.enh_key, true)
        return true
      end
    }))
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.15,
      func = function()
        c:flip()
        play_sound('tarot2', 1, 0.6)
        c:juice_up(0.3, 0.3)
        return true
      end
    }))
    delay(0.5)
  end,

  abn_artist_credits = { artist = "cloudzXIII", colour = G.C.GOLD }
}

ABN.CrimsonCard {
  key = "intertwined",

  atlas = "KHConsumables",
  pos = { x = 3, y = 2 },
  dependencies = { "abandonia" },
  config = { extra = { enh_key = "kh_stk_kingdomkey" } },

  loc_vars = function(self, info_queue, card)
    local sticker = card.ability.extra.enh_key

    if sticker then
      info_queue[#info_queue + 1] = { key = sticker, set = "Other", vars = SMODS.Stickers[sticker]:loc_vars()["vars"] }
    end
    return {
      vars = {
        localize { type = 'name_text', key = card.ability.extra.enh_key, set = 'Other' },
      }
    }
  end,

  use = function(self, card, area, copier)
    local c = G.jokers.cards[#G.jokers.cards]
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.4,
      func = function()
        play_sound('tarot1')
        card:juice_up(0.3, 0.5)
        return true
      end
    }))
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.15,
      func = function()
        c:flip()
        play_sound('card1', 1)
        c:juice_up(0.3, 0.3)
        return true
      end
    }))
    G.E_MANAGER:add_event(Event({
      func = function()
        c:add_sticker(card.ability.extra.enh_key, true)
        return true
      end
    }))
    G.E_MANAGER:add_event(Event({
      trigger = 'after',
      delay = 0.15,
      func = function()
        c:flip()
        play_sound('tarot2', 1, 0.6)
        c:juice_up(0.3, 0.3)
        return true
      end
    }))
    delay(0.5)
  end,

  abn_artist_credits = { artist = "cloudzXIII", colour = G.C.GOLD }
}
