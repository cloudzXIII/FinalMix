YMA = YMA or {}
if YMA and YMA.SideQuests and ColdBeans then
  --#region Also show side quest crossmod in my mod"s additions tab (should"ve put this in actual cold beans but like)
  local function get_quest_pool(mod_id)
    local quests = {}
    for _, quest in pairs(G.P_CENTER_POOLS["yma_quest"]) do
      if quest.mod.id == mod_id or mod_id == nil then
        quests[#quests + 1] = quest
      end
    end
    return quests
  end

  local function get_quest_tally_of(mod_id)
    local tally, of = 0, 0
    for _, quest in pairs(get_quest_pool(mod_id)) do
      of = of + 1
      if quest.discovered or (G.PROFILES[G.SETTINGS.profile] and G.PROFILES[G.SETTINGS.profile].all_unlocked) then
        tally = tally + 1
      end
    end
    return { tally = tally, of = of }
  end

  local old_smods_create_UIBox_Other_GameObjects = create_UIBox_Other_GameObjects
  function create_UIBox_Other_GameObjects()
    local mod_has_quests = false
    local old_mod_custom_collection_tabs

    if G.ACTIVE_MOD_UI then
      local mod_id = G.ACTIVE_MOD_UI.id
      local mod_quest_count = get_quest_tally_of(mod_id)

      mod_has_quests = mod_id ~= ColdBeans.id and mod_quest_count.of > 0

      if mod_has_quests then
        old_mod_custom_collection_tabs = G.ACTIVE_MOD_UI.custom_collection_tabs
        G.ACTIVE_MOD_UI.custom_collection_tabs = function()
          local res = old_mod_custom_collection_tabs and old_mod_custom_collection_tabs() or {}

          res[#res + 1] = UIBox_button({
            button = "your_collection_quests",
            label = { "Side Quests" },
            count = { tally = mod_quest_count.tally, of = mod_quest_count.of },
            minw = 5,
            minh = 1,
            id = "your_collection_quests",
            focus_args = { snap_to = true }
          })

          return res
        end
      end
    end

    local res = old_smods_create_UIBox_Other_GameObjects()

    if mod_has_quests then
      G.ACTIVE_MOD_UI.custom_collection_tabs = old_mod_custom_collection_tabs
    end

    return res
  end

  --#endregion

  -- Side Quests
  YMA.SideQuests.quest {
    key = "sora",
    rarity = 3,

    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS.j_kh_sora
      return {
        vars = {
          card.ability.extra.hearts,
          card.ability.extra.hearts_remaining
        }
      }
    end,

    atlas = "KHSideQuests",
    pos = { x = 0, y = 0 },
    display_size = { w = 65, h = 65 },
    pixel_size = { w = 65, h = 65 },

    config = {
      extra = {
        hearts = 20,
        hearts_remaining = 20
      }
    },

    calculate = function(self, card, context)
      if context.individual and context.cardarea == G.play then
        if context.other_card:is_suit("Hearts") then
          card.ability.extra.hearts_remaining = card.ability.extra.hearts_remaining - 1
          SMODS.calculate_effect({ message = localize("k_upgrade_ex") }, card)
        end
      end

      if card.ability.extra.hearts_remaining <= 0 then
        card.ability.extra.hearts_remaining = card.ability.extra.hearts
        YMA.complete_quest(card, "Joker", "j_kh_sora")
      end
    end,
  }

  YMA.SideQuests.quest {
    key = "mickey",
    rarity = 3,

    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS.j_kh_mickey
      return {
        vars = {
          card.ability.extra.kings,
          localize("King", "ranks") or "King"
        }
      }
    end,

    atlas = "KHSideQuests",
    pos = { x = 1, y = 0 },
    display_size = { w = 65, h = 65 },
    pixel_size = { w = 65, h = 65 },

    config = {
      extra = {
        kings = 3,
      }
    },

    calculate = function(self, card, context)
      if context.after and context.main_eval and not context.blueprint then
        local count = 0
        for _, v in ipairs(context.scoring_hand) do
          if v:is_face() then
            count = count + 1
          end
        end
        if count >= card.ability.extra.kings then
          YMA.complete_quest(card, "Joker", "j_kh_mickey")
        end
      end
    end,
  }

  YMA.SideQuests.quest {
    key = "paopufruit",
    rarity = 2,

    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS.j_kh_paopufruit
      return {
        vars = {
          card.ability.extra.enhance,
          card.ability.extra.enhance_remaining
        }
      }
    end,

    atlas = "KHSideQuests",
    pos = { x = 2, y = 0 },
    display_size = { w = 65, h = 65 },
    pixel_size = { w = 65, h = 65 },

    config = {
      extra = {
        enhance = 4,
        enhance_remaining = 4
      }
    },

    calculate = function(self, card, context)
      if context.setting_ability and not context.unchanged and not context.check_enhancement and G.P_CENTERS[context.new].set == "Enhanced" then
        card.ability.extra.enhance_remaining = card.ability.extra.enhance_remaining - 1
        SMODS.calculate_effect({ message = localize("k_upgrade_ex") }, card)
      end

      if card.ability.extra.enhance_remaining <= 0 then
        card.ability.extra.enhance_remaining = card.ability.extra.enhance
        YMA.complete_quest(card, "Joker", "j_kh_paopufruit")
      end
    end,
  }

  --#region hook card:set_seal() to add a context
  local set_seal_ref = Card.set_seal
  function Card:set_seal(_seal, silent, immediate)
    if _seal then
      SMODS.calculate_context({ kh_seal_set = true, card = self })
    end
    return set_seal_ref(self, _seal, silent, immediate)
  end

  --#endregion
  YMA.SideQuests.quest {
    key = "sealsalt",
    rarity = 2,

    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS.j_kh_sealsalt
      return {
        vars = {
        }
      }
    end,

    atlas = "KHSideQuests",
    pos = { x = 3, y = 0 },
    display_size = { w = 65, h = 65 },
    pixel_size = { w = 65, h = 65 },

    config = {
      extra = {
      }
    },

    calculate = function(self, card, context)
      if context.kh_seal_set then
        YMA.complete_quest(card, "Joker", "j_kh_paopufruit")
      end
    end,
  }

  YMA.SideQuests.quest {
    key = "nobody",
    rarity = 4,

    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS.j_kh_nobody
      return {
        vars = {
          card.ability.extra.cards,
        }
      }
    end,

    atlas = "KHSideQuests",
    pos = { x = 4, y = 0 },
    display_size = { w = 65, h = 65 },
    pixel_size = { w = 65, h = 65 },

    config = {
      extra = {
        cards = 5
      }
    },

    calculate = function(self, card, context)
      if context.end_of_round and context.main_eval and not context.blueprint and #G.hand.cards >= card.ability.extra.cards then
        YMA.complete_quest(card, "Joker", "j_kh_nobody")
      end
    end,
  }

  YMA.SideQuests.quest {
    key = "mooglevoucher",
    rarity = 1,

    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS.v_kh_moogleskip
      return {
        vars = {
          card.ability.extra.skips,
          card.ability.extra.skips_remaining
        }
      }
    end,

    atlas = "KHSideQuests",
    pos = { x = 0, y = 1 },
    display_size = { w = 65, h = 65 },
    pixel_size = { w = 65, h = 65 },

    config = {
      extra = {
        skips = 4,
        skips_remaining = 4
      }
    },

    calculate = function(self, card, context)
      if context.skip_blind and not context.blueprint then
        card.ability.extra.skips_remaining = card.ability.extra.skips_remaining - 1
        SMODS.calculate_effect({ message = localize("k_upgrade_ex") }, card)
      end

      if card.ability.extra.skips_remaining <= 0 and G.STATE ~= G.STATES.SMODS_BOOSTER_OPENED then
        card.ability.extra.skips_remaining = card.ability.extra.skips
        local voucher_key = "v_kh_moogleskip"

        local new_card = create_card("Voucher", G.play, nil, nil, nil, nil, voucher_key, nil)
        new_card:start_materialize()
        new_card.cost = 0
        new_card.from_tag = true
        new_card:redeem()
        G.E_MANAGER:add_event(Event({
          trigger = "after",
          delay = 0.2,
          func = (function()
            new_card:start_dissolve()
            return true
          end
          )
        }))
        YMA.complete_quest(card, nil, nil, false)
      end
    end,
  }

  YMA.SideQuests.quest {
    key = "helpwanted",
    rarity = 3,

    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS.j_kh_helpwanted
      local joker_complete = card.ability.extra.complete["joker"] or false
      local tarot_complete = card.ability.extra.complete["tarot"] or false

      return {
        vars = {
          joker_complete and "X" or "",
          tarot_complete and "X" or "",
          colours = { joker_complete and G.C.GREEN or G.C.RED, tarot_complete and G.C.GREEN or G.C.RED }
        }
      }
    end,

    atlas = "KHSideQuests",
    pos = { x = 1, y = 1 },
    display_size = { w = 65, h = 65 },
    pixel_size = { w = 65, h = 65 },

    config = {
      extra = {
        complete = { ["joker"] = false, ["tarot"] = false }
      }
    },

    calculate = function(self, card, context)
      if context.selling_card and context.card.ability.set == "Joker" then
        card.ability.extra.complete["joker"] = true
        SMODS.calculate_effect({ message = localize("k_upgrade_ex") }, card)
      end

      if context.using_consumeable and context.consumeable.ability.set == "Tarot" then
        card.ability.extra.complete["tarot"] = true
        SMODS.calculate_effect({ message = localize("k_upgrade_ex") }, card)
      end
      if card.ability.extra.complete["tarot"] and card.ability.extra.complete["joker"] then
        card.ability.extra.complete["joker"] = false
        card.ability.extra.complete["tarot"] = false
        YMA.complete_quest(card, "Joker", "j_kh_helpwanted")
      end
    end,
  }
  YMA.SideQuests.quest {
    key = "munny",
    rarity = 1,

    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS.j_kh_munnypouch
      return {
        vars = {
          card.ability.extra.money,
        }
      }
    end,

    atlas = "KHSideQuests",
    pos = { x = 2, y = 1 },
    display_size = { w = 65, h = 65 },
    pixel_size = { w = 65, h = 65 },

    config = {
      extra = {
        money = 4,
      }
    },

    calculate = function(self, card, context)
      if context.ending_shop and G.GAME.dollars <= card.ability.extra.money then
        YMA.complete_quest(card, "Joker", "j_kh_munnypouch")
      end
    end,
  }

  YMA.SideQuests.quest {
    key = "tamagotchi",
    rarity = 2,

    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS.j_kh_tamagotchi
      return {
        vars = {
          card.ability.extra.uses,
          card.ability.extra.uses_remaining
        }
      }
    end,

    atlas = "KHSideQuests",
    pos = { x = 3, y = 1 },
    display_size = { w = 65, h = 65 },
    pixel_size = { w = 65, h = 65 },

    config = {
      extra = {
        uses = 3,
        uses_remaining = 3
      }
    },

    calculate = function(self, card, context)
      if context.using_consumeable and context.consumeable.ability.set == "Tarot" then
        card.ability.extra.uses_remaining = card.ability.extra.uses_remaining - 1
        SMODS.calculate_effect({ message = localize("k_upgrade_ex") }, card)
      end

      if card.ability.extra.uses_remaining <= 0 then
        card.ability.extra.uses_remaining = card.ability.extra.uses
        YMA.complete_quest(card, "Joker", "j_kh_tamagotchi")
      end
    end,
  }

  YMA.SideQuests.quest {
    key = "com",
    rarity = 2,

    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS.j_kh_com
      return {
        vars = {
          card.ability.extra.streak,
          card.ability.extra.streak_remaining
        }
      }
    end,

    atlas = "KHSideQuests",
    pos = { x = 4, y = 1 },
    display_size = { w = 65, h = 65 },
    pixel_size = { w = 65, h = 65 },

    config = {
      extra = {
        streak = 3,
        streak_remaining = 3
      }
    },

    calculate = function(self, card, context)
      if context.press_play then
        card.ability.extra.last_played = G.GAME.last_hand_played
      end
      if context.joker_main then
        if card.ability.extra.last_played == context.scoring_name then
          card.ability.extra.streak_remaining = card.ability.extra.streak_remaining - 1
          SMODS.calculate_effect({ message = localize('k_upgrade_ex'), colour = G.C.FILTER }, card)
        else
          if card.ability.extra.streak_remaining < card.ability.extra.streak then
            card.ability.extra.streak_remaining = card.ability.extra.streak
            SMODS.calculate_effect({ message = localize('k_reset'), colour = G.C.FILTER }, card)
          end
        end
      end

      if card.ability.extra.streak <= 0 then
        card.ability.extra.streak = card.ability.extra.streak
        YMA.complete_quest(card, "Joker", "j_kh_com")
      end
    end,
  }
  YMA.SideQuests.quest {
    key = "keyblade",
    rarity = 1,

    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS.j_kh_keyblade
      return {
        vars = {
        }
      }
    end,

    atlas = "KHSideQuests",
    pos = { x = 0, y = 2 },
    display_size = { w = 65, h = 65 },
    pixel_size = { w = 65, h = 65 },

    config = {
      extra = {
      }
    },

    calculate = function(self, card, context)
      if context.remove_playing_cards and not context.blueprint then
        if #context.removed > 0 then
          YMA.complete_quest(card, "Joker", "j_kh_keyblade")
        end
      end
    end,
  }

  YMA.SideQuests.quest {
    key = "gummiphone",
    rarity = 1,

    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS.j_kh_gummiphone
      return {
        vars = {
        }
      }
    end,

    atlas = "KHSideQuests",
    pos = { x = 1, y = 2 },
    display_size = { w = 65, h = 65 },
    pixel_size = { w = 65, h = 65 },

    config = {
      extra = {
      }
    },

    calculate = function(self, card, context)
      if context.after and context.main_eval and not context.blueprint then
        local score = hand_chips * mult
        if score >= 10000 then
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.15,
            func = function()
              YMA.complete_quest(card, "Joker", "j_kh_gummiphone")
              return true
            end
          }))
        end
      end
    end,
  }

  YMA.SideQuests.quest {
    key = "randomquest",
    rarity = 1,

    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS.j_kh_randomjoker
      local numerator, denominator = SMODS.get_probability_vars(card, card.ability.extra.base, card.ability.extra.odds,
        'randomquest')
      return {
        vars = {
          numerator,
          denominator
        }
      }
    end,

    atlas = "KHSideQuests",
    pos = { x = 2, y = 2 },
    display_size = { w = 65, h = 65 },
    pixel_size = { w = 65, h = 65 },

    config = {
      extra = {
        base = 1,
        odds = 4
      }
    },

    calculate = function(self, card, context)
      if context.end_of_round and not context.blueprint and context.main_eval then
        if SMODS.pseudorandom_probability(card, 'kh_random', card.ability.extra.base, card.ability.extra.odds, 'randomquest') then
          YMA.complete_quest(card, "Joker", "j_kh_randomjoker")
        else
          G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
              attention_text({
                text = localize('k_nope_ex'),
                scale = 1.3,
                hold = 1.4,
                major = card,
                backdrop_colour = G.C.SECONDARY_SET.Tarot,
                align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                    'tm' or 'cm',
                offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                silent = true
              })
              G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.06 * G.SETTINGS.GAMESPEED,
                blockable = false,
                blocking = false,
                func = function()
                  play_sound('tarot2', 0.76, 0.4)
                  return true
                end
              }))
              play_sound('tarot2', 1, 0.4)
              card:juice_up(0.3, 0.5)
              return true
            end
          }))
        end
      end
    end
  }

  YMA.SideQuests.quest {
    key = "khbox",
    rarity = 2,

    loc_vars = function(self, info_queue, card)
      info_queue[#info_queue + 1] = G.P_CENTERS.j_kh_khtrilogy
      return {
        vars = {
          card.ability.extra.discards,
          card.ability.extra.discards_remaining
        }
      }
    end,

    atlas = "KHSideQuests",
    pos = { x = 3, y = 2 },
    display_size = { w = 65, h = 65 },
    pixel_size = { w = 65, h = 65 },

    config = {
      extra = {
        discards = 32,
        discards_remaining = 32
      }
    },

    calculate = function(self, card, context)
      if context.discard and not context.blueprint then
        if card.ability.extra.discards_remaining <= 1 then
          YMA.complete_quest(card, "Joker", "j_kh_khtrilogy")
        else
          card.ability.extra.discards_remaining = card.ability.extra.discards_remaining - 1
          return nil, true
        end
      end
    end,
  }
end
