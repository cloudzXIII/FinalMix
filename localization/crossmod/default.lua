return {
  misc = {
    dictionary = {
      -- crossmod
      k_kh_crossmod = "Crossmod",
      k_kh_jokerdisplay = "JokerDisplay",
      k_kh_jokerdisplay_info = "Full support!",

      k_kh_cardsleeves = "CardSleeves",
      k_kh_cardsleeves_info = "1 Sleeve!",

      k_kh_partner = "Partner API",
      k_kh_partner_info = "5 Partners!",

      k_kh_coldbeans = "Cold Beans",
      k_kh_coldbeans_info = "14 Side Quests!",

      k_kh_abandonia = "Abandonia",
      k_kh_abandonia_info = "New consumables!",

      k_kh_reverie = "Reverie",
      k_kh_reverie_info = "1 Cine Card!",
    },
    labels = {
      -- Joker Enhancement Stickers (Abandonia Crossmod)
      kh_stk_recard = "Re:Card",
      kh_stk_kingdomkey = "Kingdom Key",
    }
  },
  descriptions = {
    -- CardSleeves crossmod
    Sleeve = {
      sleeve_kh_rechain = {
        name = "Re:chain Sleeve",
        text = {
          "Start run with the",
          "{C:kh_keyblade,T:v_kh_inheritance_ceremony}#1#{} voucher",
          "",
          "{C:attention}+#2#{} consumable slot",
        },
      },
      sleeve_kh_rechain_alt = {
        name = "Re:chain Sleeve",
        text = {
          "Start run with the",
          "{C:kh_keyblade,T:v_kh_keyblade_mastery}#1#{} voucher",
        },
      },
    },

    Enhanced = {
      --Blindside Crossmod
      m_kh_crown = { name = "The Crown", text = { "{C:inactive}Does... nothing?", } },
      m_kh_kingdom_hearts = { name = "The Logo", text = { "{C:inactive}Does... nothing?", } },
      m_kh_keyhole = { name = "The Keyhole", text = { "{C:inactive}Does... nothing?", } },
    },

    Blind = {
      --Blindside crossmod
      bl_kh_sora = {
        name = "Sora",
        text = {
          "Gains X1.5 Mult if",
          "scoring hand contains",
          "a Red Blind",
        }
      }
    },

    -- Partner crossmod
    Partner = {
      pnr_kh_sora = {
        name = "Sora",
        text = {
          "Played cards with",
          "{C:hearts}Heart{} suit give",
          "permanently gain",
          "{X:mult,C:white}X#1#{} Mult when scored",
        },
      },

      pnr_kh_donald = {
        name = "Ducklings",
        text = {
          "Copies the ability of a",
          "random {C:attention}Joker{}",
          "every hand played",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive})",
        },
      },

      pnr_kh_mickey = {
        name = "Mickey",
        text = {
          "The first scoring card",
          "has a {C:green}#1# in #2#{} chance",
          "to become a {C:attention}King{}",
        },
      },

      pnr_kh_randompartner = {
        name = "Random Partner",
        text = {
          "Balances {C:purple}#1#%{} of",
          "{C:chips}Chips{} and {C:mult}Mult{}",
          "when a hand is played",
          "Click to pay {C:money}$#3#{} and",
          "increase by {C:purple}+#2#%{}",
        },
      },

      pnr_kh_nobody = {
        name = "Nobody",
        text = {
          "First and Last",
          "cards {C:attention}held in hand{}",
          "count in scoring",
        },
      },
    },

    -- Abandonia crossmod
    weather_report = {
      c_kh_munny_storm = {
        name = "Munny Storm",
        text = {
          "When {C:money}${} is earned during",
          "scoring, earn it {C:attention}again{}",
          "{C:inactive}(Destroyed at end of round)",
        }
      },
      c_kh_hp_shower = {
        name = "HP Shower",
        text = {
          "When a hand is played, creates",
          "the corresponding {C:tarot}Tarot{} card",
          "of first scoring {C:attention}Enhanced{} card",
          "{C:inactive}(Must have room)",
          "{C:inactive}(Destroyed at end of round)",
        }
      },
      c_kh_risky_winds = {
        name = "Risky Winds",
        text = {
          "Increases the {C:attention}rank{} of all",
          "played card's by {C:attention}1{} after",
          "scoring, {C:green}#1# in #2#{} chance to",
          "{C:attention}randomise ranks{} instead",
          "{C:inactive}(Destroyed at end of round)",
        }
      },
      c_kh_bargain_flurry = {
        name = "Bargain Flurry",
        text = {
          "Select a Joker, create a",
          "Joker of the same {C:attention}rarity{}",
          "when a {C:attention}Joker{} is sold",
          "{C:inactive}(Rarity: {V:1}#1#{C:inactive}, {C:attention}#2#{C:inactive} sells left)",
          "{C:inactive}(Destroyed at end of round)",
        }
      },
      c_kh_overcast = {
        name = "Overcast",
        text = {
          "{C:white,X:blind}X#1#{} Blind Size,",
          "Scoring cards give an extra",
          "{C:chips}#2#%{} of their total {C:chips}chips{}",
          "{C:inactive}(Destroyed at end of round)",
        }
      },
      c_kh_ordinary_day = {
        name = "Ordinary Day",
        text = {
          "{C:attention}+#1#{} hand size",
          "{C:inactive}(Destroyed at end of round)",
        }
      },
      c_kh_treasure_front = {
        name = "Treasure Front",
        text = {
          "Discarded cards have a",
          "{C:green}#1# in #2#{} chance to be",
          "{C:attention}enhanced{} into {C:attention}Gold Cards{}",
          "{C:inactive}(Destroyed at end of round)",
        }
      },
    },

    -- Abandonia Crossmod
    glyphs = {
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

    -- Abandonia Crossmod
    crimson = {
      c_kh_chained = {
        name = "Chained",
        text = {
          "Enhance the {C:attention}leftmost{}",
          "Joker to {C:enhanced}#1#{}"
        }
      },
      c_kh_intertwined = {
        name = "Intertwined",
        text = {
          "Enhance the {C:attention}rightmost{}",
          "Joker to {C:enhanced}#1#{}"
        }
      },
    },

    Other = {
      -- Joker Enhancement Stickers (Abandonia crossmod)
      kh_stk_recard = {
        name = "Re:Card",
        text = {
          "Retrigger {C:attention}adjacent{} Jokers",
          "on {C:attention}final hand{} of round",
        }
      },
      kh_stk_kingdomkey = {
        name = "Kingdom Key",
        text = {
          "Gains {X:mult,C:white}X#2#{} Mult when {C:attention}triggered{},",
          "Resets if played hand",
          "contains {C:attention}3{} unscoring cards",
          "{C:inactive}(Currently {C:white,X:mult}X#1#{C:inactive})",
        }
      },
    },

    -- Reverie crossmod
    Cine = {
      c_kh_firethunderfreeze_quest = {
        name = "Exchange Coupon",
        text = {
          "Converts to {C:cine}Fire Thunder Freeze!{}",
          "after using {C:attention}2{} {C:kh_keyblade}Keyblade{} cards",
          "{C:inactive}(Currently {C:attention}#2#{C:inactive}/#1#)"
        }
      },
      c_kh_firethunderfreeze = {
        name = "Fire Thunder Freeze!",
        text = {
          "During this shop, only",
          "{C:attention}Jokers{} with {C:attention}Keychains{} appear",
          "{s:0.8}Rerolls cards"
        }
      },
    },

    -- Cold Beans crossmod (yes, actually)
    yma_quest = {

      q_kh_sora = {
        name = {
          "Sora",
          "{C:dark_edition,s:0.7}Side Quest{}",
        },
        text = {
          "Play {C:attention}#1#{} {C:inactive}(#2#){} {C:hearts}Heart{} cards",
          "to create {C:attention}Sora{}",
        },
      },

      q_kh_mickey = {
        name = {
          "Meeska Mooska",
          "{C:dark_edition,s:0.7}Side Quest{}",
        },
        text = {
          "Play a hand containing {C:attention}#1#{} {C:attention}#2#s{}",
          "to create {C:attention}Meeska Mooska{}",
        },
      },

      q_kh_paopufruit = {
        name = {
          "Paopu Fruit",
          "{C:dark_edition,s:0.7}Side Quest{}",
        },
        text = {
          "Enhance {C:attention}#1#{} {C:inactive}(#2#){} {C:attention}playing cards{}",
          "to create {C:attention}Paopu Fruit{}",
        },
      },

      q_kh_sealsalt = {
        name = {
          "Seal Salt Ice Cream",
          "{C:dark_edition,s:0.7}Side Quest{}",
        },
        text = {
          "Add a {C:attention}Seal{} to a {C:attention}playing card{}",
          "to create {C:attention}Seal Salt Ice Cream{}",
        },
      },

      q_kh_nobody = {
        name = {
          "Nobody",
          "{C:dark_edition,s:0.7}Side Quest{}",
        },
        text = {
          "Win a round with at least",
          "{C:attention}#1#{} cards {C:attention}held in hand",
          "to create {C:attention}Nobody{}",
        },
      },

      q_kh_mooglevoucher = {
        name = {
          "Moogle Voucher",
          "{C:dark_edition,s:0.7}Side Quest{}",
        },
        text = {
          "Skip {C:attention}#1#{} {C:inactive}(#2#){} {C:attention}Blinds{}",
          "to redeem {C:attention}Moogle Skip{}",
        },
      },

      q_kh_helpwanted = {
        name = {
          "Help Wanted",
          "{C:dark_edition,s:0.7}Side Quest{}",
        },
        text = {
          "Complete the following {C:attention}tasks{}:",
          "{C:inactive,s:0.9}- Sell a {C:attention,s:0.9}Joker{} {V:1,s:0.9}[#1#]",
          "{C:inactive,s:0.9}- Use a {C:tarot,s:0.9}Tarot{}{s:0.9,c:inactive} card {V:2,s:0.9}[#2#]",
          "to create {C:attention}Help Wanted{}",
        },
      },

      q_kh_munny = {
        name = {
          "Munny Pouch",
          "{C:dark_edition,s:0.7}Side Quest{}",
        },
        text = {
          "Exit the {C:attention}shop{}",
          "with {C:money}$#1#{} or less",
          "to create {C:attention}Munny Pouch{}",
        },
      },

      q_kh_tamagotchi = {
        name = {
          "Tamagotchi",
          "{C:dark_edition,s:0.7}Side Quest{}",
        },
        text = {
          "Use {C:attention}#1#{} {C:inactive}(#2#){} {C:tarot}Tarot{} cards",
          "to create {C:attention}Tamagotchi{}",
        },
      },

      q_kh_com = {
        name = {
          "Chain of Memories",
          "{C:dark_edition,s:0.7}Side Quest{}",
        },
        text = {
          "Play the same {C:attention}hand type{}",
          "{C:attention}#1#{} {C:inactive}(#2#){} times in a row",
          "to create {C:attention}Chain of Memories{}",
        },
      },

      q_kh_keyblade = {
        name = {
          "Keyblade",
          "{C:dark_edition,s:0.7}Side Quest{}",
        },
        text = {
          "Destroy a single {C:attention}playing card{}",
          "to create {C:attention}Keyblade{}",
        },
      },

      q_kh_gummiphone = {
        name = {
          "Gummiphone",
          "{C:dark_edition,s:0.7}Side Quest{}",
        },
        text = {
          "Score at least {C:purple}10,000{} Chips",
          "in a single hand",
          "to create {C:attention}Gummiphone{}",
        },
      },

      q_kh_randomquest = {
        name = {
          "Random Joker",
          "{C:dark_edition,s:0.7}Side Quest{}",
        },
        text = {
          "{C:green}#1# in #2#{} chance",
          "to create {C:attention}Random Joker{}",
          "at end of round",
        },
      },

      q_kh_khbox = {
        name = {
          "Preorder Bonus",
          "{C:dark_edition,s:0.7}Side Quest{}",
        },
        text = {
          "Discard {C:attention}#1#{} {C:inactive}(#2#){} cards",
          "to create {C:attention}Preorder Bonus{}",
        },
      },
    },
  }
}
