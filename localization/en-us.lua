local flavour = "{C:money,s:0.7,E:1}"
return {
  descriptions = {
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
          "Apply a {C:attention}Seal{} to {C:attention}1{} {C:attention}playing card{}",
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
          "to create {C:attention}Moogle Voucher{}",
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
          "Leave the {C:attention}shop{}",
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
          "Kingdom Hearts: Deluxe Edition",
          "{C:dark_edition,s:0.7}Side Quest{}",
        },
        text = {
          "Discard {C:attention}#1#{} {C:inactive}(#2#){} cards",
          "to create {C:attention}Disc 1{}",
        },
      },
    },
    --Blindside Crossmod
    Enhanced = {
      m_kh_crown = {
        name = 'The Crown',
        text = {
          "Does something",
        }
      },
      m_kh_kingdom_hearts = {
        name = 'Kingdom Hearts',
        text = {
          "Does something",
        }
      },
      m_kh_keyhole = {
        name = 'Keyhole',
        text = {
          "Does something",
        }
      },
    },
    Partner = {
      pnr_kh_sora = {
        name = "{E:kh_pulse}Sora",
        text = {
          "Played cards with",
          "{C:hearts}Heart{} suit give",
          "permanently gain",
          "{X:mult,C:white}X#1#{} Mult when scored.",
        },
      },

      pnr_kh_donald = {
        name = "{E:kh_pulse}Ducklings",
        text = {
          "Copies the ability of a",
          "random {C:attention}Joker{}",
          "every hand played",
          "{C:inactive}(Currently: {C:attention}#1#{C:inactive})",
        },
      },

      pnr_kh_mickey = {
        name = "{E:kh_pulse}Mickey",
        text = {
          "The first scoring card",
          "has a {C:green}#1# in #2#{} chance",
          "to become a {C:attention}King{}",
        },
      },

      pnr_kh_randompartner = {
        name = '{E:kh_pulse}Random Partner',
        text = {
          "Balances {C:purple}#1#%{} of",
          "{C:chips}Chips{} and {C:mult}Mult{}",
          "when a hand is played",
          "Click to pay {C:money}$#3#{} and",
          "increase by {C:purple}+#2#%{}",
        },
      },

      pnr_kh_nobody = {
        name = '{E:kh_pulse}Nobody',
        text = {
          "First and Last",
          "cards {C:attention}held in hand{}",
          "count in scoring",
        },
      },
    },

    Sleeve = {
      sleeve_kh_rechain = {
        name = "{E:kh_pulse}Re:Chain Sleeve",
        text = {
          "{C:green}Reroll{} costs reset every {C:attention}Ante{}",
          "Start run with the",
          "{C:attention,T:v_kh_moogleskip}Moogle Skip{} voucher",
        },
      },
      sleeve_kh_rechain_alt = {
        name = "{E:kh_pulse}Re:Chain Sleeve",
        text = {
          "{C:green}Reroll{} costs reset every {C:attention}Ante{}",
          "Start run with {C:attention,T:v_kh_moogleskip}Moogle Skip{}",
          "and {C:attention,T:v_reroll_surplus}Reroll Surplus{}",
        },
      },
    },
    Blind = {
      bl_kh_kingdom_hearts = {
        name = 'Kingdom Hearts',
        text = {
          'Played cards are',
          'reshuffled into the deck',
        }
      },

      bl_kh_crown = {
        name = 'The Crown',
        text = {
          "Played hand must contain",
          "a face card"
        }
      },

      bl_kh_keyhole = {
        name = 'Keyhole',
        text = {
          '-1 hand size',
          'every hand played',
        }
      },

      --CROSSMOD
      bl_kh_sora = {
        name = "Sora",
        text = {
          "Gains X1.5 Mult if",
          "scoring hand contains",
          "a Red Blind",
        }
      }
    },
    Joker = {
      j_kh_timeless_sora = {
        name = "{E:kh_pulse}Timeless River Sora",
        text = {
          "Retrigger {C:attention}first{} played",
          "card used in scoring",
          "once for each {C:hearts}Heart{}",
          "in scoring hand"
        }
      },
      j_kh_sora = {
        name = '{E:kh_pulse}Sora',
        text = {
          "This Joker gains {X:mult,C:white}X#2#{} Mult",
          "for each scored card",
          "with a {C:hearts}Heart{} suit, resets",
          "when {C:attention}Boss Blind{} is defeated.{}",
          "{C:inactive}(Currently {X:mult,C:white}X#1# {C:inactive} Mult)",
          flavour .. "My Friends are my Power!",
        },
      },

      j_kh_riku = {
        name = '{E:kh_pulse}Riku',
        text = {
          'Levels up {C:attention}most played{} hand',
          'by #2# every {C:attention}#4#{} {C:inactive}(#3#){} {C:green}rerolls',
          '{C:inactive}(Currently: {C:attention}#1#{}{C:inactive})',
          --flavour .. "I'm not afraid of the darkness!",
          flavour .. "I'm thinking RIKU RIKU oo ee oo",
        }

      },

      j_kh_kairi_a = {
        name = '{E:kh_pulse}Kairi',
        text = {
          "{C:chips}+#3#{} Chip per {C:diamonds}Light Suit{} scored",
          "{C:chips}-#4#{} Chip per {C:spades}Dark Suit{} scored",
          flavour .. "I know you will!",
        }
      },
      j_kh_kairi_b = {
        name = '{E:kh_pulse}Naminé',
        text = {
          "{C:mult}+#3#{} Mult per {C:spades}Dark Suit{} scored",
          "{C:mult}-#4#{} Mult per {C:diamonds}Light Suit{} scored",
          flavour .. "It's me, Naminé",

        }
      },

      j_kh_kairi_extra = {
        text = {
          "{C:inactive}(Currently {C:chips}+#1#{}{C:inactive} Chips, {C:mult}+#2#{}{C:inactive} Mult){}",
          '{C:inactive}Joker flips at end of round',
        }
      },

      j_kh_roxas = {
        name = '{E:kh_pulse}Roxas',
        text = {
          "This Joker gains {C:chips}+#2#{} Chips",
          "per unique {C:attention}suit{}",
          "in first played hand",
          "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
          flavour .. "looks like my summer vacation is... over",
        },
      },

      j_kh_brycethenobody = {
        name = "{E:kh_pulse}BryceTheNobody",
        text = {
          "Every played {V:1}#2#{} card",
          "permanently gain",
          "{C:mult}+#1#{} Mult when scored",
          "{s:0.8}suit changes at end of round",
          flavour .. "Glad i could help some people out"
        },
      },

      j_kh_axel = {
        name = '{E:kh_pulse}Axel',
        text = {
          "All {C:planet}Planet{} cards",
          "are {C:attention}flipped{} and",
          "retrigger when used",
          flavour .. "Got it Memorized?",

        },
      },

      j_kh_xigbar = {
        name = "{E:kh_pulse}Half Face",
        text = {
          "This Joker gains {X:mult,C:white}X#2#{} Mult",
          "if hand played contains",
          "a {C:attention}Face{} card",
          "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}",
          flavour .. "Me? I'm already half Xehanort"
        },
      },

      j_kh_mickey = {
        name = '{E:kh_pulse}Meeska Mooska',
        text = {
          "Played {C:attention}face{} cards",
          "become {C:attention}Kings{}",
          "when played",
          flavour .. "Did somebody mention",
          flavour .. "the Door to Darkness?"
        }
      },

      j_kh_donald = {
        name = '{E:kh_pulse}Donald Duck',
        text = {
          "When {C:attention}Blind{} is selected,",
          "copies the ability of a",
          "random {C:attention}Joker{}",
          "{C:inactive}(Currentlys: {C:attention}#1#{C:inactive})",
          flavour .. "The Snowstorm can't get us here."
        },
      },

      j_kh_goofy = {
        name = "{E:kh_pulse}Wild Goofy",
        text = {
          {
            "{C:attention}Wild Cards{} give",
            "a random bonus",
            "when scored:",
          },
          {
            "{s:0.8,X:mult,C:white}X#3#{} {s:0.8}Mult, {s:0.8,C:money}$#4#{}",
            "{s:0.8,C:mult}+#1#{} {s:0.8}Mult, {s:0.8,C:chips}+#2#{} {s:0.8}Chips",
            flavour .. "Gawrsh..."
          },
        },
      },

      j_kh_disney = {
        name = '{E:kh_pulse}Master Yen Sid',
        text = {
          "{C:green}#1# in #2#{} chance to",
          "upgrade level of a",
          "random {C:attention}poker hand{} when",
          "a {C:purple}Tarot{} card is used",
          flavour .. "Sora, do NOT dissappoint me.",
        },
      },

      j_kh_keyblade = {
        name = '{E:kh_pulse}Keyblade',
        text = {
          "If {C:attention}first hand{} of round is",
          "a single {C:attention}#1#{}, destroy it and",
          "create a {C:dark_edition}random {}{C:attention}Tag{}",
          "{s:0.8}Rank changes every round",
          flavour .. " May your heart be your guiding key",
        },
      },

      j_kh_paopufruit = {
        name = '{E:kh_pulse}Paopu Fruit',
        text = {
          "Add a random {C:dark_edition}Edition{},",
          "{C:dark_edition}Enhancement{}, and {C:attention}Seal{} to",
          "first scored card for",
          "the next {C:attention}#1#{} hands",
          flavour .. " the winner gets to share a Paopu with Kairi."
        },
      },

      j_kh_sealsalt = {
        name = "{E:kh_pulse}Seal Salt Ice Cream",
        text = {
          "If played hand contains",
          "a card with a {C:attention}seal{}, add a",
          "random {C:attention}seal{} to a random",
          "{C:attention} playing card{} held in hand",
          flavour .. " man, this is some good ice cream, huh?",
        },
      },

      j_kh_nobody = {
        name = '{E:kh_pulse}Nobody',
        text = {
          "All cards {C:attention}held in hand{}",
          "count in scoring",
          "with a {C:green}#1# in #2#{} chance",
          "to retrigger",
          flavour .. " Nobody? Who's Nobody?",
        },
      },

      j_kh_moogle = {
        name = '{E:kh_pulse}Moogle',
        text = {
          "Earn {C:money}$#1#{} at end of round",
          "for each {C:attention}Joker{} card",
          "{C:inactive}(Currently {C:money}$#2#{}{C:inactive})",
          flavour .. "Greetings"
        },
      },

      j_kh_invitation = {
        name = "{E:kh_pulse}Invitation",
        text = {
          "Creates a random {C:blue}Common{} Joker",
          "with a random {C:dark_edition}Non-Negative{} edition",
          "when entering {C:attention}shop",
          flavour .. "A new challenger approaches...!",
        },
      },
      j_kh_gummiphone = {
        name = "{E:kh_pulse}Gummiphone",
        text = {
          "Add {C:attention}one tenth{} of the chips",
          "from final played {C:attention}hand{}",
          "of round to this {C:red}Mult",
          "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
          flavour .. "*ring* *ring* *ring*",
        },
      },
      j_kh_luxord = {
        name = '{E:kh_pulse}Luxord',
        text = {
          {
            '{C:chips}-#3#{} Chips for every',
            '{C:attention}second{} passed this round,',

          },
          {
            'Chips increase by {X:chips,C:white}X1.5{}',
            'when {C:attention}Boss Blind{} is defeated.',
            flavour .. "I'd rather we just skip the formalities",
          },

        },
      },

      j_kh_khtrilogy_kh1 = {
        name = "{E:kh_pulse}Disc 1",
        text = {
          {
            "{C:chips}+#5#{} Chips",
            "Win a blind in one",
            "hand to {C:legendary,E:1}level up{}",
          },
          {
            "{C:inactive}(Next level: {C:mult}+#1#{C:inactive} Mult)",
            flavour .. "A true classic",
          },
        }
      },

      j_kh_khtrilogy_kh2 = {
        name = "{E:kh_pulse}Disc 2",
        text = {
          {
            "{C:mult}+#1#{} Mult",
            "Discard {C:attention}#7#{} {C:inactive}(#6#){}",
            "cards to {C:legendary,E:1}level up{}",
          },
          {
            "{C:inactive}(Next level: {X:mult,C:white}X#2#{C:inactive} Mult)",
            flavour .. "peak has arrived",
          },
        }
      },

      j_kh_khtrilogy_kh3 = {
        name = "{E:kh_pulse}Disc 3",
        text = {
          "{X:mult,C:white}X#2#{} Mult",
          flavour .. "KH4 when???",
        }
      },
      j_kh_helpwanted_default = {
        name = "{E:kh_pulse}Help Wanted!",
        text = {
          {
            "Complete a task to earn a prize!",
            "New task appears after completion",
            "{C:red,E:2,s:1}When no tasks remain,",
            "{C:red,E:2,s:1}Self Destructs",
            flavour .. "Maybe... today we'll finally hit the beach!"
          },
        }
      },
      j_kh_helpwanted_play_face = {
        name = { "{E:kh_pulse}Help Wanted!", "{C:attention,s:0.8}Grand Stander" },
        text = {
          {
            "Complete a task to earn a prize!",
            "New task appears after completion",
            "{C:red,E:2,s:1}When no tasks remain,",
            "{C:red,E:2,s:1}Self Destructs"
          },
          {
            "{C:attention}Task:{} Score {C:attention}7{} {C:inactive}(#2#){} {C:attention}Face{} cards",
            "{C:attention}Prize:{} {C:blue}+1{} Hand",
            flavour .. "Maybe... today we'll finally hit the beach!"
          },
        }
      },
      j_kh_helpwanted_shopping = {
        name = { "{E:kh_pulse}Help Wanted!", "{C:attention,s:0.8}Poster Duty" },
        text = {
          {
            "Complete a task to earn a prize!",
            "New task appears after completion",
            "{C:red,E:2,s:1}When no tasks remain,",
            "{C:red,E:2,s:1}Self Destructs"
          },
          {
            "{C:attention}Task:{} Spent {C:money}$20{} {C:inactive}(#3#){} in a single shop",
            "{C:attention}Prize:{} {C:attention}+1{} Shop Slot",
            flavour .. "Maybe... today we'll finally hit the beach!"
          },
        }
      },
      j_kh_helpwanted_wheel = {
        name = { "{E:kh_pulse}Help Wanted!", "{C:attention,s:0.8}Cargo Climb" },
        text = {
          {
            "Complete a task to earn a prize!",
            "New task appears after completion",
            "{C:red,E:2,s:1}When no tasks remain,",
            "{C:red,E:2,s:1}Self Destructs"
          },
          {
            "{C:attention}Task:{} {C:green}Successfully{} trigger {C:tarot}Wheel of Fortune{}",
            "{C:attention}Prize:{} Add {C:dark_edition}Negative{} to this Joker",
            flavour .. "Maybe... today we'll finally hit the beach!"
          },
        }
      },
      j_kh_helpwanted_discard = {
        name = { "{E:kh_pulse}Help Wanted!", "{C:attention,s:0.8}Junk Sweep" },
        text = {
          {
            "Complete a task to earn a prize!",
            "New task appears after completion",
            "{C:red,E:2,s:1}When no tasks remain,",
            "{C:red,E:2,s:1}Self Destructs"
          },
          {
            "{C:attention}Task:{} Discard {C:attention}30{} {C:inactive}(#4#){} cards",
            "{C:attention}Prize:{} {C:attention}+1{} Hand Size",
            flavour .. "Maybe... today we'll finally hit the beach!"
          },
        }
      },
      j_kh_munnypouch = {
        name = '{E:kh_pulse}Munny Pouch',
        text = {
          {
            "Gains {C:money}$#3#-$#4#{} of",
            "{C:money}sell value{} at",
            "end of round",
          },
          {
            "{C:green}#1# in #2#{} chance",
            "this Joker is {C:red}destroyed!{}",
          },
          {
            "Sell this Joker",
            "to create {C:attention,E:kh_pulse}Munny{}",
          }
        },
      },

      j_kh_munny = {
        name = '{E:kh_pulse}Munny',
        text = {
          "Earn {C:money}$#1#{} at",
          "end of round",
          "Payout decreases by {C:red}$1{}",
          "every round."
        },
      },

      j_kh_randomjoker = {
        name = '{E:kh_pulse}Random Joker',

        text = {
          "of {C:mult}Mult{} and {C:chips}Chips{}",
          "when a hand is played"
        },
      },

      j_kh_magnet = {
        name = '{E:kh_pulse}Munny Magnet',
        text = {
          {
            "{C:attention}Steel Cards{} are moved",
            "to the top of",
            "your {C:attention}full deck{}",
          },
          {
            "{C:attention}Steel Cards{} give",
            "{C:money}$#1#{} when held in hand",
          },
        },
      },

      j_kh_kingdomhearts = {
        name = '{E:kh_pulse}Kingdom Hearts',
        text = {
          "Unused {C:red}discards{}",
          "this ante carry over to",
          "the {C:attention}Boss Blind{}",
          "{C:inactive}(Currently {C:red}#1#{}{C:inactive} Discards)"

        },
      },

      j_kh_tamagotchi_normal = {
        name = '{E:kh_pulse}Tamagotchi',
        text = {
          {
            "When {C:attention}Blind{} is selected,",
            "this Joker gets {C:kh_hungry}Hungry{}!",
          },
          {
            "{C:attention}Feed{} me a {V:1}#3#{}",
            "to gain {C:chips}+#2#{} Chips",
            "{C:inactive,s:0.8}If not fed by end of shop,",
            "{C:inactive,s:0.8}Chips are halved",
            "{C:inactive}(Currently {C:chips}#1#{C:inactive} Chips)",
          },
        },
      },
      j_kh_tamagotchi = {
        name = '{E:kh_pulse}Tamagotchi',
        text = {
          {
            "When {C:attention}Blind{} is selected,",
            "this Joker gets {C:kh_hungry}Hungry{}!",
          },
          {
            "{C:attention}Feed{} me a {V:1}#3#{} card",
            "to gain {C:chips}+#2#{} Chips",
            "{C:inactive,s:0.8}If not fed by end of shop,",
            "{C:inactive,s:0.8}Chips are halved",
            "{C:inactive}(Currently {C:chips}#1#{C:inactive} Chips)",
          },
        },
      },
      j_kh_xehanort = {
        name = '{E:kh_pulse}Master Xehanort',
        text = {
          "This Joker gains {C:mult}+#1#{} Mult",
          "per {C:attention}consecutive{} hand played",
          "that isn't the same",
          "as previously played hand",
          "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
        },
      },
      j_kh_com = {
        name = '{E:kh_pulse}Chain of Memories',
        text = {
          "Adds {C:chips}Chips{} and {C:mult}Mult{}",
          "from previous poker hand",
          "to current hand",
          "{C:inactive}({C:attention}#1#{}{C:inactive}: {X:chips,C:white}#2#{} {C:mult}X{} {X:mult,C:white}#3#{}{C:inactive})",
        },
      },
      j_kh_lethimcook = {
        name = '{E:kh_pulse}Let Him Cook',
        text = {
          "If {C:attention}first hand{} of round",
          "exceeds {C:attention}blind requirement{},",
          "{C:attention}rescore{} full hand",
          "in a random order",
          flavour .. "Hollup... Let Him Cook",
        },
      },
      j_kh_commandmenu_kh0 = {
        name = {
          "{E:kh_pulse,C:dark_edition,s:1.0}Command Menu{}",
          "{C:attention,s:0.8}Attack{}",
        },
        text = {
          {
            "This Joker gains {C:white,X:mult}X#2#{} Mult",
            "per card scored",
          },
          {
            "{C:inactive}Cycles when discarded{}",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}",
            flavour .. "Take this!",
          },
        },
      },

      j_kh_commandmenu_kh1 = {
        name = {
          "{E:kh_pulse,C:dark_edition,s:1.0}Command Menu{}",
          "{C:attention,s:0.8}Magic{}",
        },
        text = {
          {
            "This Joker gains {C:white,X:mult}X#3#{} Mult",
            "when a card is {C:attention}Enhanced{}",
          },
          {
            "{C:inactive}Cycles when discarded{}",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}",
            flavour .. "Fire! Thunder! Freeze!",
          },
        },
      },

      j_kh_commandmenu_kh2 = {
        name = {
          "{E:kh_pulse,C:dark_edition,s:1.0}Command Menu{}",
          "{C:attention,s:0.8}Items{}",
        },
        text = {
          {
            "This Joker gains {C:white,X:mult}X#4#{} Mult",
            "every time a {C:attention}consumable{} is used",
          },
          {
            "{C:inactive}Cycles when discarded{}",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}",
            flavour .. "Heal!",
          },
        },
      },

      j_kh_commandmenu_kh3 = {
        name = {
          "{E:kh_pulse,C:dark_edition,s:1.0}Command Menu{}",
          "{C:attention,s:0.8}Drive{}",
        },
        text = {
          {
            "Played cards permanently gain",
            "{X:mult,C:white}X#5#{} Mult when scored.",
          },
          {
            "{C:inactive}Cycles when discarded{}",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}",
            flavour .. "Give me strength!",
          },
        },
      },
    },
    Back = {
      b_kh_rechain = {
        name = "{E:kh_pulse}Re:Chain Deck",
        text = {
          "{C:green}Reroll{} costs reset",
          "every {C:attention}Ante{}",
          "Start run with the",
          "{C:attention,T:v_kh_moogleskip}Moogle Skip{} voucher",
        },
      },
    },

    Tag = {
      tag_kh_kingdom = {
        name = "Kingdom Tag",
        text = {
          "Shop has a free",
          "{C:legendary}Final Mix Joker",
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
    },

    Other = {
      kh_shuffled = {
        name = "Shuffled",
        text = {
          "This Joker is shuffled",
          "before scoring"
        }
      },

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

      kh_perishable = {
        name = "Perishable",
        text = {
          "Debuffed after",
          "{C:attention}5{} rounds",
        }
      },

      kh_play_face = {
        name = "Grand Stander",
        text = {
          "Score {C:attention}7{} {C:attention{}Face{} cards",
          "to get {C:attention}+1{} {C:blue}Hand{}"
        }
      },

      kh_wheel = {
        name = "Cargo Climb",
        text = {
          "{C:green}Successfully{} trigger",
          "{C:tarot}Wheel of Fortune{}",
          "To add {C:dark_edition}Negative{} edition",
          "to this Joker",
        }
      },

      kh_shopping = {
        name = "Poster Duty",
        text = {
          "Spend {C:money}$20{} in one shop",
          "to get {C:attention}+1{} Shop Slot"
        }
      },

      kh_discard = {
        name = "Junk Sweep",
        text = {
          "Discard {C:attention}30{} cards",
          "to get {C:attention}+1{} Hand Size"
        }
      },

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
        name = 'Kingdom Seal',
        text = {
          "Cards held in hand",
          "permanently gain",
          "{C:chips}+#1#{} Chips",
          "when {C:attention}discarded",
        }
      },

      kh_attack = {
        name = 'Attack',
        text = {
          "This Joker gains",
          "{C:white,X:mult}X#2#{} Mult",
          "per card scored",
        }
      },

      kh_magic = {
        name = 'Magic',
        text = {
          "This Joker gains",
          "{C:white,X:mult}X#3#{} Mult",
          "when a card",
          "is {C:attention}Enhanced{}",
        }
      },

      kh_items = {
        name = 'Items',
        text = {
          "This Joker gains",
          "{C:white,X:mult}X#4#{} Mult",
          "every time a",
          "{C:attention}consumable{} is used",
        }
      },

      kh_drive = {
        name = 'Drive',
        text = {
          "Played cards",
          "permanently gain",
          "{X:mult,C:white}X#5#{} Mult",
          "when scored.",
        }
      },
    },

    Spectral = {
      c_kh_sorcerer = {
        name = "Sorcerer",
        text = {
          "Select {C:attention}#1#{} card to",
          "apply {C:attention}Lucky Seal{}"
        }
      },
      c_kh_kingdom = {
        name = "Hearts",
        text = {
          "Select {C:attention}#1#{} card to",
          "apply {C:attention}Kingdom Seal{}"
        }
      },
      c_kh_gummiship = {
        name = "Gummi Ship",
        text = {
          "Destroy a random {C:attention}Joker{}",
          "and create a new {C:attention}Joker{}",
          "of the same rarity",
        },
      },

    },

    Tarot = {
      c_kh_awakening = {
        name = "Awakening",
        text = {
          "Creates a random",
          "{C:legendary}Final Mix{} {C:attention}Joker{}",
          "{C:inactive}(Must have room)",
        },
      },
    },
  },
  misc = {
    quips = {

      kh_friendsmult = {
        "My friends are my multiplier!"
      },

      kh_simpleclean = {
        "Simple and Clean",
        "is the way that you're",
        "making me feel tonight!"
      },

      kh_walkaway = {
        "When you walk away…",
        "you don't hear me say,",
        "{C:attention}Fold{}!"
      },

      kh_kairiinside = {
        "Kairi... Kairi's inside me?"
      },

      kh_rikubugs = {
        "Mickey! It's Riku!",
        "They put bugs in him!",
      },

      kh_theyregone = {
        "They're gone! All our",
        "{E:kh_pulse}chips{} are gone!"
      },

      kh_icecream = {
        "No! Who else will I have ice cream with?"
      },

    },

    achievement_descriptions = {},
    achievement_names = {},
    blind_states = {},
    challenge_names = {},
    collabs = {},

    dictionary = {
      k_kingdomhearts_desc = "A Kingdom Hearts mod by cloudzXIII!",
      -- main tab
      b_kh_website_page = "About Me",
      b_kh_wiki_page = "Wiki",
      -- config
      k_kh_config_menu_toggle = "Toggle Custom Title Screen",

      k_kh_menu_toggle = "Shows the mod logo on the Title Screen",
      -- kairi/namine
      kh_a_side = 'Kairi',
      kh_b_side = 'Naminé',

      -- misc text
      k_kh_plus_consumeable = '+1 Consumable!',
      k_kh_king = 'Fellas!',
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
      k_kh_halved_ex = "Halved!"
    },

    high_scores = {},
    labels = {
      kh_luckyemblem_seal = "Lucky Emblem",
      kh_kingdom_seal = "Kingdom Seal",
      kh_shuffled = "Shuffled"
    },
    poker_hand_descriptions = {},
    poker_hands = {},
    ranks = {},
    suits_plural = {
      kh_com = "Kingdom Cards"
    },
    suits_singular = {
      kh_com = "Kingdom Card"
    },
    tutorial = {},
    v_dictionary = {},

    v_text = {
      ch_c_kh_got_it_memorized = { "All Blinds are {C:attention}Boss Blinds{}" },
      ch_c_no_skipping = { "Skipping is {C:attention}disabled{}" },
      ch_c_no_time = { "Game Over if {C:attention}Luxord{} gets {C:attention}Sold{} or {C:attention}Destroyed{}" },
      ch_c_chain_reaction = { "All {C:attention}Jokers{} become the {C:attention}last createed{} Joker" },
      ch_c_finalmix_only = { "Only {C:legendary}Final Mix{} {C:attention}Jokers{} can appear" },
    },
  },
}
