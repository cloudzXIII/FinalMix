return {
  misc = {
    quips = {
      kh_friendsmult = { "My friends are my multiplier!" },
      kh_simpleclean = { "Simple and Clean", "is the way that you're", "making me feel tonight!" },
      kh_walkaway = { "When you walk away…", "you don't hear me say,", "{C:attention}Fold{}!" },
      kh_theyregone = { "They're gone! All our", "{C:chips}_____{} are gone!" },
      kh_icecream = { "No! Who else will I have ice cream with?" },
    },

    challenge_names = {
      c_kh_tick_tock = "Tick Tock",
      c_kh_chain_reaction = "Chain Reaction",
      c_kh_finalmix_only = "Balatro: Final Mix",
      c_kh_ink_spill = "Ink Spill",
    },
    v_text = {
      ch_c_no_skipping = { "Skipping is {C:attention}disabled{}" },
      ch_c_no_time = { "Game Over if {C:attention}Luxord{} is {C:attention}sold{} or {C:red}destroyed{}" },
      ch_c_chain_reaction = { "All {C:attention}Jokers{} become the {C:attention}last created{} Joker" },
      ch_c_finalmix_only = { "Only {C:finalmix}Final Mix{} {C:attention}Jokers{} can appear" },
    },

    dictionary = {
      -- main tab
      kh_finalmix = "Final Mix",
      k_kingdomhearts_desc = "A Kingdom Hearts mod by cloudzXIII!",
      b_kh_website_page = "About Me",
      b_kh_wiki_page = "Wiki",

      b_kh_github = "Github",
      b_kh_wiki = "Wiki Page",
      b_kh_kofi = "Support my work!",
      b_kh_discord = "Discord Thread!",

      -- config
      k_kh_settings = "Settings",
      k_kh_config_enable_custom_main_menu = "Show Sora on Title Screen*",
      k_kh_config_menu_toggle = "Enable Custom Title Screen*",
      k_kh_config_disable_flavour = "Hide Flavour Text",
      kh_requires_restart = "* = Requires Restart",

      -- kairi/namine
      kh_kairi_side = "Kairi",
      kh_namine_side = "Naminé",
      k_kh_dark = "Dark",
      k_kh_light = "Light",
      k_kh_mult = "Mult",
      k_kh_chips = "Chips",

      -- help wanted task types
      kh_play_a = "Play a",
      kh_discard_a = "Discard a",
      kh_use_a = "Use a",

      -- Random Joker
      k_kh_balance = "Balance",
      k_kh_of = "of",

      -- booster packs
      k_kh_keyblade_pack = "Keyblade Pack",

      -- misc text
      k_kh_king = "Fellas!",
      k_kh_destroyed = "Destroyed!",
      k_kh_copying = "Copying!",
      k_kh_riku_no = "RIKU NO!",
      k_kh_sealed = "Sealed!",
      k_kh_tasks_complete = "Tasks Complete!",
      k_kh_complete = "Complete!",
      k_kh_stolen = "Stolen!",
      k_kh_munny = "Munny!",
      k_kh_returned = "Returned!",
      k_kh_challenger = "Challenger!",
      k_kh_switched_ex = "Switched!",
      k_kh_rescore_ex = "Hollup!",
      k_kh_hungry_ex = "Hungry!",
      k_kh_fed_ex = "Fed!",
      k_kh_halved_ex = "Halved!",
      k_kh_value_down = "Value Down!",
      k_kh_plus_keyblade = "+1 Keyblade",
      k_kh_activated_ex = "Activated!",
      k_kh_discard = "Discard!",
      k_kh_consumed_ex = "Consumed!",
      k_kh_rerolled_ex = "Rerolled!",
      k_kh_plus_tag_ex = "+1 Tag!",
      k_kh_randomised_ex = "Randomised!",
      k_kh_increased_ex = "Increased!",
      k_kh_summoned = "Summoned!",
      k_kh_transferred_ex = "Transferred!",

      b_kh_keychains = "Keychains",
      ml_keyblade_explanation = { "Jokers may each have one Keychain", },

      -- Joker Perma Bonuses
      kh_perma_bonus = "{C:chips}+#1#{} extra Chips",
      kh_perma_mult = "{C:mult}+#2#{} extra Mult",
      kh_perma_xmult = "{C:white,X:mult}X#3#{} Mult",
      kh_perma_xchips = "{C:white,X:chips}X#4#{} Chips",
      kh_perma_dollars = "{C:money}$#5#{} extra Dollars",
      kh_perma_rep = "{C:attention}+#6#{} extra Repetitions",

      -- Consumables
      k_kh_forecast = "Forecast",

      b_kh_keyblade_cards = "Keyblade Cards",
      k_kh_keyblade = "Keyblade",
    },

    labels = {
      -- Seals
      kh_luckyemblem_seal = "Lucky Emblem",
      kh_kingdom_seal = "Kingdom Seal",

      -- Consumables
      kh_keyblade = "Keyblade",

      -- Keychains
      kh_kingdomkey_keychain = "Kingdom Key",
      kh_oathkeeper_keychain = "Oathkeeper",
      kh_oblivion_keychain = "Oblivion",
      kh_ultima_weapon_keychain = "Ultima Weapon",
      kh_olympia_keychain = "Olympia",
      kh_xblade_keychain = "X-Blade",
      kh_lady_luck_keychain = "Lady Luck",
      kh_mysterious_abyss_keychain = "Mysterious Abyss",
      kh_sweet_memories_keychain = "Sweet Memories",
      kh_flame_liberator_keychain = "Flame Liberator",
      kh_monochrome_keychain = "Monochrome",
      kh_follow_the_wind_keychain = "Follow the Wind",
      kh_star_seeker_keychain = "Star Seeker",
      kh_way_to_dawn_keychain = "Way to the Dawn",
      kh_kingdomkeyd_keychain = "Kingdom Key D"
    },
  },

  descriptions = {
    Other = {
      --#region Keychains
      kh_kingdomkey_keychain = {
        name = { "Kingdom Key", "{f:5,s:0.7}キングダムチェーン" },
        text = {
          "{C:mult}+#1#{} Mult",
        }
      },
      kh_oathkeeper_keychain = {
        name = { "Oathkeeper", "{f:5,s:0.7}約束のお守り" },
        text = {
          "{C:green}#1# in #2#{} chance for",
          "{C:attention}Joker{} to retrigger"
        }
      },
      kh_oblivion_keychain = {
        name = { "Oblivion", "{f:5,s:0.7}過ぎ去りし思い出" },
        text = {
          "{C:white,X:mult}X#1#{} Mult if",
          "Joker is {C:attention}leftmost{}",
        }
      },
      kh_ultima_weapon_keychain = {
        name = { "Ultima Weapon", "{f:5,s:0.7}アルテマウェポン" },
        text = {
          "This Joker permanently",
          "gains {C:chips}+#1#{} Chips",
          "when {C:attention}Blind{} is defeated",
        }
      },
      kh_olympia_keychain = {
        name = { "Olympia", "{f:5,s:0.7}パワーオブヒーロー" },
        text = {
          "{C:white,X:money}X2{} Sell Value"
        }
      },
      kh_lady_luck_keychain = {
        name = { "Lady Luck", "{f:5,s:0.7}ラストリゾート" },
        text = {
          "Doubles all {C:attention}listed",
          "{C:green,E:1,S:1.1}probabilities",
          "{C:inactive}(ex: {C:green}1 in 3{C:inactive} -> {C:green}2 in 3{C:inactive})",
        }
      },
      kh_sweet_memories_keychain = {
        name = { "Sweet Memories", "{f:5,s:0.7}スウィートメモリー" },
        text = {
          "This Joker may appear",
          "{C:attention}multiple{} times"
        }
      },
      kh_mysterious_abyss_keychain = {
        name = { "Mysterious Abyss", "{f:5,s:0.7}ワンダーオブアビス" },
        text = {
          "Retrigger this Joker",
          "per empty {C:attention}Joker{} slot",
          "{C:inactive}(Currently {C:attention}+#1#{C:inactive} Repetitions)"
        }
      },
      kh_flame_liberator_keychain = {
        name = { "Flame Liberator", "{f:5,s:0.7}フレイムリベレーター" },
        text = {
          "This Joker permanently",
          "gains {C:white,X:mult}X#1#{} Mult when",
          "{C:attention}Boss Blind{} is defeated",
        }
      },
      kh_monochrome_keychain = {
        name = { "Monochrome", "{f:5,s:0.7}モノクローム" },
        text = {
          "This Joker cannot be",
          "{C:red}debuffed{} or {C:red}destroyed{}",
        }
      },
      kh_follow_the_wind_keychain = {
        name = { "Follow the Wind", "{f:5,s:0.7}フォローザウィンド" },
        text = {
          "Gains {C:money}$#1#{} of",
          "{C:attention}sell value{} at",
          "end of round",
        }
      },
      kh_way_to_dawn_keychain = {
        name = { "Way to the Dawn", "{f:5,s:0.7}ウェイトゥザドーン" },
        text = {
          "{C:mult}+#1#{} Mult per {C:attention}Joker{} to the {C:attention}left{}",
          "{C:chips}+#2#{} Chips per {C:attention}Joker{} to the {C:attention}right{}",
          "{C:inactive}(Currently {C:mult}+#3#{C:inactive}, {C:chips}+#4#{C:inactive})"
        }
      },
      kh_kingdomkeyd_keychain = {
        name = { "Kingdom Key D", "{f:5,s:0.7}キングダムチェーンD" },
        text = {
          "{C:chips}+#1#{} Chips"
        }
      },
      kh_star_seeker_keychain = {
        name = { "Star Seeker", "{f:5,s:0.7}スターシーカー" },
        text = {
          "This Joker permanently",
          "gains {C:mult}+#1#{} Mult",
          "every {C:money}$#2#{} {C:inactive}[#3#]{} spent",
        }
      },
      kh_xblade_keychain = {
        name = { "X-Blade", "{f:5,s:0.7}Xブレード" },
        text = {
          "Copies ability of",
          "{C:attention}adjacent Jokers{}",
          "{B:1,C:white}#1#{} {B:2,C:white}#2#"
        }
      },
      --#endregion

      undiscovered_kh_keyblade = {
        name = "Not Discovered",
        text = {
          "Purchase or use",
          "this card in an",
          "unseeded run to",
          "learn what it does"
        }
      },

      --#region Booster Packs
      p_kh_keyblade_normal = {
        name = "Kingdom Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:kh_keyblade} Keyblade{} cards to",
          "be used immediately",
        },
      },
      p_kh_keyblade_jumbo = {
        name = "Jumbo Kingdom Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:kh_keyblade} Keyblade{} cards to",
          "be used immediately",
        },
      },
      p_kh_keyblade_mega = {
        name = "Mega Kingdom Pack",
        text = {
          "Choose {C:attention}#1#{} of up to",
          "{C:attention}#2#{C:kh_keyblade} Keyblade{} cards to",
          "be used immediately",
        },
      },
      --#endregion

      -- Light/Dark Suit Tooltips
      kh_lightsuit = {
        name = "Light Suit",
        text = {
          "{C:hearts}Hearts{} or {C:diamonds}Diamonds{}",
        }
      },

      kh_darksuit = {
        name = "Dark Suit",
        text = {
          "{C:spades}Spades{} or {C:clubs}Clubs{}",
        }
      },

      -- Seals
      kh_luckyemblem_seal = {
        name = "Lucky Emblem",
        text = {
          "When {C:attention}scored{}, convert",
          "a card {C:attention}held in hand{}",
          "into this card's {C:attention}rank{]}",
          "and {C:attention}suit{}"
        }
      },

      kh_kingdom_seal = {
        name = "Kingdom Seal",
        text = {
          "Creates a {C:kh_keyblade}Keyblade{} card",
          "when {C:attention}discarded",
          "{C:inactive}(Must have room)",
        },
      },

      -- Preorder Bonus dummy fool tooltip
      kh_preorder_fool = {
        name = "The Fool",
        text = {
          "Creates the last",
          "{C:attention}Consumable{} card",
          "used during this run",
          "{s:0.8,C:tarot}The Fool{s:0.8} and {s:0.8,C:spectral}The Soul{s:0.8} excluded",
        },
      },

      --#region Command Menu mode tooltips
      kh_attack = {
        name = "Attack",
        text = {
          "This Joker gains",
          "{C:white,X:mult}X#2#{} Mult",
          "per card scored",
        }
      },
      kh_magic = {
        name = "Magic",
        text = {
          "This Joker gains",
          "{C:white,X:mult}X#3#{} Mult",
          "when a card",
          "is {C:attention}Enhanced{}",
        }
      },
      kh_items = {
        name = "Items",
        text = {
          "This Joker gains",
          "{C:white,X:mult}X#4#{} Mult",
          "every time a",
          "{C:attention}consumable{} is used",
        }
      },
      kh_drive = {
        name = "Drive",
        text = {
          "Played cards",
          "permanently gain",
          "{X:mult,C:white}X#5#{} Mult",
          "when scored",
        }
      },
      --#endregion

      -- Tooltip for Tamagotchi
      kh_possible_tama_cards = {
        name = "Edible cards",
        text = {
          "{C:attention}Jokers{}, {C:attention}Consumables{},",
          "and {C:attention}Playing Cards{}"
        }
      },

      -- Kingdom Key Enhancement
      kingdomkey_enh = {
        text = {
          " {C:light_black}#1# ",
        },
      },
    },

    Enhanced = {
      m_kh_kingdomkey = {
        name = "Kingdom Key",
        text = {
          "Gains {X:mult,C:white}X#2#{} Mult when {C:attention}scored{},",
          "resets if card is played",
          "and {C:attention}unscored{}, no suit",
          "{C:inactive}(Currently {C:white,X:mult}X#1#{C:inactive})",
        }
      },
      m_kh_recard = {
        name = "Re:Card",
        text = {
          "{C:attention}Retrigger{} adjacent",
          "cards when scored",
        }
      },
    },

    Blind = {
      bl_kh_kingdom_hearts = {
        name = "The Logo",
        text = {
          "Played cards are",
          "shuffled into the deck",
        }
      },

      bl_kh_crown = {
        name = "The Crown",
        text = {
          "Played hand must",
          "contain a face card"
        }
      },

      bl_kh_keyhole = {
        name = "The Keyhole",
        text = {
          "-1 hand size",
          "every hand played",
        }
      },
    },

    Back = {
      b_kh_rechain = {
        name = "Re:Chain Deck",
        text = {
          "Start run with the",
          "{C:kh_keyblade,T:v_kh_inheritance_ceremony}#1#{} voucher",
          "",
          "{C:attention}+#2#{} consumable slot",
        },
      },
    },

    Tag = {
      tag_kh_kingdom = {
        name = "Kingdom Tag",
        text = {
          "Shop has a free",
          "{C:finalmix}Final Mix{} Joker",
        },
      },
      tag_kh_guiding = {
        name = "Guiding Tag",
        text = {
          "Gives a free",
          "{C:attention}Mega Kingdom Pack",
        },
      },
      tag_kh_chained = {
        name = "Chained Tag",
        text = {
          "Next base edition shop",
          "Joker is free and",
          "has a {C:attention}Keychain",
        },
      },
    },

    Spectral = {
      c_kh_sorcerer = {
        name = "Sorcerer",
        text = {
          "Add a {V:1}#2#{}",
          "to {C:attention}#1#{} selected",
          "card in your hand",
        }
      },
      c_kh_hearts = {
        name = "Hearts",
        text = {
          "Add a {V:1}#2#{}",
          "to {C:attention}#1#{} selected",
          "card in your hand",
        }
      },
    },

    Tarot = {
      c_kh_creation = {
        name = "Creation",
        text = {
          "Creates a random",
          "{C:finalmix}Final Mix{} {C:attention}Joker{}",
          "{C:inactive}(Must have room)",
        },
      },
      c_kh_awakening = {
        name = "Awakening",
        text = {
          "Enhances {C:attention}#1#",
          "selected cards to",
          "{C:attention}#2#s",
        },
      },
      c_kh_remind = {
        name = "Re:Mind",
        text = {
          "Enhances {C:attention}#1#{} selected",
          "card into a",
          "{C:attention}#2#",
        },
      },
    },

    Voucher = {
      v_kh_moogleskip = {
        name = "Moogle Skip",
        text = {
          "Create a random {C:attention}Tag{}",
          "when a {C:attention}Blind{} is skipped"
        },
      },
      v_kh_moogleshop = {
        name = "Moogle Shop",
        text = {
          "Enter the {C:attention}Shop{}",
          "when a {C:attention}Blind{} is skipped"
        },
      },

      v_kh_inheritance_ceremony = {
        name = "Inheritance Ceremony",
        text = {
          "Create a random {C:kh_keyblade}Keyblade{}",
          "when {C:attention}Boss Blind{} is defeated",
          "{C:inactive}Must have room{}"
        }
      },
      v_kh_keyblade_mastery = {
        name = "Keyblade Mastery",
        text = {
          "{C:attention}Jokers{} may appear in",
          "the shop with {C:attention}Keychains{}",
        }
      },
    },
  },
}
