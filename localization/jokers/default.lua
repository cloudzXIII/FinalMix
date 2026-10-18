return {
  descriptions = {
    Joker = {
      j_kh_dtd = {
        name = "Door to Darkness",
        text = {
          {
            "Once per shop, select",
            "a card to {C:attention}consume{}, this",
            "card will re-appear in the",
            "{C:attention}next{} {C:green}shop{} with an {C:dark_edition}Edition",
            "{C:inactive}(Currently{} {C:attention}#1#{C:inactive})"
          }
        }
      },
      j_kh_datasora = {
        name = "Data Sora",
        text = {
          "Gives {C:white,X:mult}X#2#{} Mult for",
          "each unique {C:attention}hand type{}",
          "played this {C:attention}Ante{}",
          "{C:inactive}(Currently {C:white,X:mult}X#1#{C:inactive} Mult)",
        }
      },

      j_kh_terra = {
        name = "Terra",
        text = {
          "Destroys a random",
          "card {C:attention}held{} in hand if",
          "played hand contains",
          "a {C:attention}#1#{}",
        },
        kh_flavour = {
          "\"Aqua, Ven... One day,",
          "I will set this right.\""
        }
      },

      j_kh_cloudstrife = {
        name = "Cloud Strife",
        text = {
          "This Joker gains {C:mult}+#1#{} Mult",
          "every round, {C:mult}Mult{} resets",
          "when it reaches {C:mult}+#2#{}",
          "{C:inactive}(Currently {C:mult}+#3#{C:inactive} Mult)",
        },
        kh_flavour = {
          "\"You owe me a pizza\""
        }
      },

      j_kh_gummiship = {
        name = "Gummi Ship",
        text = {
          "{C:red}Use{} to face a",
          "random {C:attention}Boss Blind{}",
          "and earn {C:money}2X{} the payout",
          "{C:inactive}(Once per Ante)",
        }
      },

      j_kh_xion = {
        name = "Xion",
        text = {
          "{C:attention}#1#s{} also ",
          "count as {C:attention}#2#s{}",
          "{s:0.8}Changes at end of round"
        },
        kh_flavour = {
          "\"Who else will I",
          "have ice cream with?\"",
        }
      },


      j_kh_ventus = {
        name = "Ventus",
        text = {
          "On {C:attention}first discard{} of round,",
          "draw {C:attention}#1#{} extra card for",
          "every {C:money}$#3#{} you have",
          "{C:inactive}(Currently {C:attention}#2#{}{C:inactive} extra cards)",
        },
      },

      j_kh_aqua = {
        name = "Aqua",
        text = {
          {
            "{C:attention}Playing Cards{} may be moved",
            "between your {C:attention}deck{} and",
            "{C:attention}consumable slots{}",
          },
          {
            "{C:attention}Playing Cards{} gain {C:chips}+#1#{} Chips",
            "if held in {C:attention}consumable slots{}",
            "at end of round"
          }
        },
        kh_flavour = {
          "\"I made us good luck charms\"",
        }
      },

      j_kh_luxord = {
        name = "Luxord",
        text = {
          {
            "{C:chips}-#3#{} Chips every {C:attention}second{}",
            "passed this round",

          },
          {
            "{C:attention}Values{} increase by {X:chips,C:white}X1.5{}",
            "when {C:attention}Boss Blind{} is defeated",
          },
        },
        kh_flavour = {
          "\"I'd rather we just skip",
          "the formalities\""
        }
      },

      j_kh_master_of_masters = {
        name = "Master of Masters",
        text = {
          "{C:white,X:mult}X#1#{} Mult for every",
          "{C:attention}#2#{} in your {C:attention}full deck{},",
          "{s:0.8}Rank changes every round",
          "{C:inactive}(Currently {C:white,X:mult}X#3#{}{C:inactive} Mult)"
        }
      },

      j_kh_preorder_bonus = {
        name = "Pre-order Bonus",
        text = {
          {
            "Create {C:tarot}The Fool{} when",
            "{C:attention}Boss Blind{} is defeated",
            "{C:inactive}(Must have room)"
          },
          {
            "{C:tarot}The Fool{} may now",
            "create any {C:attention}Consumable{}",
          }
        }
      },

      j_kh_heartless = {
        name = "Heartless",
        text = {
          "Scores every {C:attention}#1#",
          "of {V:1}#2#{} {C:attention}held in hand,",
          "{s:0.8}Card changes every hand",
        }
      },

      j_kh_timeless_sora = {
        name = "Timeless River Sora",
        text = {
          "Retrigger {C:attention}first{} played",
          "card used in scoring once",
          "per {C:hearts}Heart{} in played hand"
        }
      },

      j_kh_sora = {
        name = "Sora",
        text = {
          "This Joker gains {X:mult,C:white}X#2#{} Mult",
          "per {C:hearts}Heart{} scored, resets",
          "when {C:attention}Boss Blind{} is defeated",
          "{C:inactive}(Currently {X:mult,C:white}X#1# {C:inactive} Mult)",
        },
        kh_flavour = {
          "\"My Friends are my Power!\"",
        }
      },

      j_kh_riku = {
        name = "Riku",
        text = {
          "Every {C:attention}#4#{} {C:inactive}[#3#]{} {C:green}rerolls{},",
          "level up your {C:attention}most{}",
          "{C:attention}played{} poker hand",
          "{C:inactive}(Currently {C:attention}#1#{}{C:inactive})",
        },
        kh_flavour = {
          "\"I'm not afraid of",
          "the darkness!\"",
          --"I'm thinking RIKU RIKU oo ee oo",
        }
      },

      j_kh_kairi_kairi = {
        name = "Kairi",
        text = {
          "{C:chips}+#3#{} Chip per {C:hearts}Light Suit{} scored",
          "{C:chips}-#4#{} Chip per {C:spades}Dark Suit{} scored",
        },
        kh_flavour = {
          "\"I know you will!\""
        }
      },
      j_kh_kairi_namine = {
        name = "Naminé",
        text = {
          "{C:mult}+#3#{} Mult per {C:spades}Dark Suit{} scored",
          "{C:mult}-#4#{} Mult per {C:hearts}Light Suit{} scored",
        },
        kh_flavour = {
          "\"It's me, Naminé\""
        }
      },
      j_kh_kairi_extra = {
        text = {
          "{C:attention}Flips{} at end of round",
          "{C:inactive}(Currently {C:chips}+#1#{}{C:inactive}, {C:mult}+#2#{}{C:inactive}){}",
        },
      },

      j_kh_roxas = {
        name = "Roxas",
        text = {
          "When {C:attention}Blind{} is selected,",
          "copies the ability of",
          "a random {C:attention}Keychain{}"
        },
        kh_flavour = {
          "\"looks like my summer",
          "vacation is... over.\""
        }
      },

      j_kh_brycethenobody = {
        name = "BryceTheNobody",
        text = {
          "Every played {V:1}#2#{} card",
          "permanently gains",
          "{C:mult}+#1#{} Mult when scored",
          "{s:0.8}Suit changes every round"
        },
        kh_flavour = {
          "Glad i could help some people out"
        }
      },

      j_kh_axel = {
        name = "Axel",
        text = {
          "Cards in the shop have",
          "a {C:green}#1# in #2#{} chance to be",
          "{C:attention}flipped{} at {C:attention}half price{}",
        },
        kh_flavour = {
          "\"Got it Memorized?\""
        }
      },

      j_kh_xigbar = {
        name = "Half Face",
        text = {
          "If played hand contains",
          "only {C:attention}face{} cards, they",
          "each give {C:white,X:mult}X#1#{} Mult",
        },
        kh_flavour = {
          "\"Me? I'm already half Xehanort\""
        }
      },

      j_kh_mickey = {
        name = "Meeska Mooska",
        text = {
          "{C:attention}Kings{} permanently gain",
          "{C:mult}+#1#{} Mult when discarded",
        },
        kh_flavour = {
          "\"Did somebody mention",
          "the Door to Darkness?\""
        }
      },

      j_kh_donald = {
        name = "Donald",
        text = {
          "When {C:attention}Blind{} is selected,",
          "copies the ability",
          "of a random {C:attention}Joker{}",
          "{C:inactive}(Currently {C:attention}#1#{C:inactive})",
        },
        kh_flavour = {
          "\"The Snowstorm can't",
          "get us here.\""
        }
      },

      j_kh_goofy = {
        name = "Wild Goofy",
        text = {
          {
            "{C:attention}Wild Cards{} give",
            "a random effect",
            "when scored:",
          },
          {
            "{s:0.8,X:mult,C:white}X#3#{} {s:0.8}Mult, {s:0.8,C:money}$#4#{}",
            "{s:0.8,C:mult}+#1#{} {s:0.8}Mult, {s:0.8,C:chips}+#2#{} {s:0.8}Chips",
          },
        },
        kh_flavour = {
          "\"Gawrsh...\""
        }
      },

      j_kh_disney = {
        name = "Yen Sid",
        text = {
          "{C:green}#1# in #2#{} chance to",
          "level up a random",
          "{C:attention}poker hand{} when a",
          "{C:tarot}Tarot{} card is used",
        },
        kh_flavour = {
          "\"Sora, do NOT dissappoint me.\""
        }
      },

      j_kh_keyblade = {
        name = "Keyblade",
        text = {
          "If {C:attention}first hand{} of round is",
          "a single {C:attention}#1#{}, destroy it and",
          "create a random {C:attention}Tag{}",
          "{s:0.8}Rank changes every round",
        },
        kh_flavour = {
          "\"May your heart be",
          "your guiding key\""
        }
      },

      j_kh_paopufruit = {
        name = "Paopu Fruit",
        text = {
          "Add a random {C:dark_edition}Edition{},",
          "{C:attention}Enhancement{}, and {C:attention}Seal{} to",
          "first scored card for",
          "the next {C:attention}#1#{} hands",
        },
        kh_flavour = {
          "\"the winner gets to",
          "share a Paopu with Kairi.\""
        }
      },

      j_kh_sealsalt = {
        name = "Seal Salt Ice Cream",
        text = {
          "If played hand contains",
          "a card with a {C:attention}seal{}, add a",
          "random {C:attention}seal{} to a random",
          "{C:attention}playing card{} held in hand",
        },
        kh_flavour = {
          "\"man, this is some",
          "good ice cream, huh?\""
        }
      },

      j_kh_nobody = {
        name = "Nobody",
        text = {
          "All cards {C:attention}held in hand{}",
          "count in scoring",
        },
        kh_flavour = {
          "\"Nobody? Who's Nobody?\""
        },
        unlock = {
          "{E:1,s:1.3}?????",
        },
      },

      j_kh_moogle = {
        name = "Moogle",
        text = {
          "Earn {C:money}$#1#{} at end of round",
          "for each {C:attention}Joker{} card",
          "{C:inactive}(Currently {C:money}$#2#{}{C:inactive})",
        },
        kh_flavour = {
          "\"Greetings\""
        }
      },

      j_kh_invitation = {
        name = "Invitation",
        text = {
          "Creates a random",
          "{C:dark_edition}Editioned{} {C:blue}Common{} {C:attention}Joker{}",
          "when entering the shop",
          "{C:dark_edition,s:0.8}Negative{s:0.8} excluded",
          "{C:inactive}(Must have room)",
        },
        kh_flavour = {
          "\"A new challenger",
          "approaches...!\""
        }
      },

      j_kh_gummiphone = {
        name = "Gummiphone",
        text = {
          "Add {C:attention}one tenth{} of the chips",
          "from final played {C:attention}hand{}",
          "of round to this {C:red}Mult",
          "{C:inactive}(Currently {C:mult}+#1#{C:inactive} Mult)",
        },
        kh_flavour = {
          "*ring* *ring* *ring*"
        }
      },

      j_kh_larxene = {
        name = "Larxene",
        text = {
          "{C:green}#1# in #2#{} chance to",
          "reroll {C:attention}Booster Packs{}",
          "per {C:attention}reroll{} in the shop",
        }
      },

      --#region KH Disc
      j_kh_khtrilogy_kh1 = {
        name = "Disc 1",
        text = {
          "{C:chips}+#1#{} Chips",
          "{C:finalmix,E:1}Upgrades{} if score",
          "{C:attention}catches on fire{}",
        },
        kh_flavour = {
          "A true classic"
        }
      },

      j_kh_khtrilogy_kh2 = {
        name = "Disc 2",
        text = {
          "{C:mult}+#2#{} Mult",
          "Discard {C:attention}#5#{} {C:inactive}(#4#){}",
          "cards to {C:finalmix,E:1}Upgrade{}",
        },
        kh_flavour = {
          "peak has arrived"
        }
      },
      j_kh_khtrilogy_kh3 = {
        name = "Disc 3",
        text = {
          "{X:mult,C:white}X#3#{} Mult",
        },
        kh_flavour = {
          "KH4 soon?"
        }
      },
      --#endregion

      --#region Help Wanted
      j_kh_helpwanted_default = {
        name = "Help Wanted!",
        text = {
          "Play a {C:attention}#1#{}",
          "to earn {C:money}$#2#{}",
          "{s:0.8,C:attention}Task{s:0.8} changes upon completion",
        },
        kh_flavour = {
          "\"Maybe... today we'll",
          "finally hit the beach!\""
        }
      },
      j_kh_helpwanted_play = {
        name = "Help Wanted!",
        text = {
          "Play a {C:attention}#1#{}",
          "to earn {C:money}$#2#{}",
          "{s:0.8,C:attention}Task{s:0.8} changes upon completion",
        },
        kh_flavour = {
          "\"Maybe... today we'll",
          "finally hit the beach!\""
        }
      },
      j_kh_helpwanted_discard = {
        name = "Help Wanted!",
        text = {
          "Discard a {C:attention}#1#{}",
          "to earn {C:money}$#2#{}",
          "{s:0.8,C:attention}Task{s:0.8} changes upon completion",
        },
        kh_flavour = {
          "\"Maybe... today we'll",
          "finally hit the beach!\""
        }
      },
      j_kh_helpwanted_use_tarot = {
        name = "Help Wanted!",
        text = {
          "Use a {C:tarot}Tarot{} card",
          "to earn {C:money}$#2#{}",
          "{s:0.8,C:attention}Task{s:0.8} changes upon completion",
        },
        kh_flavour = {
          "\"Maybe... today we'll",
          "finally hit the beach!\""
        }
      },
      j_kh_helpwanted_use_planet = {
        name = "Help Wanted!",
        text = {
          "Use a {C:planet}Planet{} card",
          "to earn {C:money}$#2#{}",
          "{s:0.8,C:attention}Task{s:0.8} changes upon completion",
        },
        kh_flavour = {
          "\"Maybe... today we'll",
          "finally hit the beach!\""
        }
      },
      --#endregion

      j_kh_munnypouch = {
        name = "Munny Pouch",
        text = {
          {
            "Gains {C:money}$#3#-$#4#{} of",
            "{C:attention}sell value{} at",
            "end of round",
          },
          {
            "{C:green}#1# in #2#{} chance this",
            "Joker is {C:red}destroyed!{}",
          },
        },
        kh_flavour = {
          "\"Our ______ are gone!\"",
        }
      },

      j_kh_randomjoker = {
        name = "Random Joker",
        text = {
          "{C:chips}Chips{} and {C:mult}Mult{}",
        },
      },

      j_kh_magnet = {
        name = "Munny Magnet",
        text = {
          "{C:attention}Gold{} and {C:attention}Steel{} cards",
          "are drawn {C:attention}first{}",
        },
      },

      j_kh_kingdomhearts = {
        name = "Kingdom Hearts",
        text = {
          "Unused {C:red}discards{} this {C:attention}Ante{}",
          "carry over to the {C:attention}Boss Blind{}",
          "{C:inactive}(Currently {C:red}+#1#{}{C:inactive} Discards)"
        },
      },

      j_kh_tamagotchi = {
        name = "Tamagotchi",
        text = {
          "Drag a {C:attention}card{} onto this Joker to",
          "destroy it and gain {X:mult,C:white}X#2#{} Mult",
          "{s:0.8}Once per round{}",
          "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult)",
        },
      },

      j_kh_xehanort = {
        name = "Master Xehanort",
        text = {
          "This Joker gains {C:mult}+#1#{} Mult",
          "per {C:attention}consecutive{} hand played",
          "that isn't the same as",
          "last played {C:attention}poker hand{}",
          "{C:inactive}(Currently {C:mult}+#2#{C:inactive} Mult)",
        },
      },

      j_kh_com = {
        name = "Chain of Memories",
        text = {
          {
            "Adds {C:chips}Chips{} and {C:mult}Mult{}",
            "from {C:attention}previous{} poker hand",
            "to current hand",
          },
          {
            "{C:attention}#1#{}{C:inactive}:",
            "{C:white,X:chips,s:1.25}#4##2#{}{C:red,s:1.25} X {C:white,X:mult,s:1.25}#3##4#{}"
          },
        },
      },

      j_kh_lethimcook = {
        name = "Let Him Cook",
        text = {
          "If played hand does {C:attention}not",
          "set the score {C:attention}on fire{},",
          "{C:attention}rescore{} full hand",
          "in a random order",
        },
        kh_flavour = {
          "\"Hollup... Let Him Cook\""
        }
      },

      j_kh_commandmenu_kh0 = {
        name = {
          "Command Menu",
          "{X:red,s:0.8}Attack{}",
        },
        text = {
          {
            "This Joker gains {C:white,X:mult}X#2#{} Mult",
            "per card scored",
          },
          {
            "Cycles on {C:attention}discard{}",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}",
          },
        },
        kh_flavour = {
          "\"Take this!\""
        }
      },

      j_kh_commandmenu_kh1 = {
        name = {
          "Command Menu",
          "{X:purple,s:0.8}Magic{}",
        },
        text = {
          {
            "This Joker gains {C:white,X:mult}X#3#{} Mult",
            "when a card is {C:attention}Enhanced{}",
          },
          {
            "Cycles on {C:attention}discard{}",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}",
          },
        },
        kh_flavour = {
          "\"Fire! Thunder! Freeze!\""
        }
      },

      j_kh_commandmenu_kh2 = {
        name = {
          "Command Menu",
          "{X:green,s:0.8}Items{}",
        },
        text = {
          {
            "This Joker gains {C:white,X:mult}X#4#{} Mult",
            "every time a {C:attention}consumable{} is used",
          },
          {
            "Cycles on {C:attention}discard{}",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}",
          },
        },
        kh_flavour = {
          "\"Heal!\""
        }
      },

      j_kh_commandmenu_kh3 = {
        name = {
          "Command Menu",
          "{X:attention,s:0.8}Drive{}",
        },
        text = {
          {
            "Played cards permanently gain",
            "{X:mult,C:white}X#5#{} Mult when scored",
          },
          {
            "Cycles on {C:attention}discard{}",
            "{C:inactive}(Currently {X:mult,C:white}X#1#{} {C:inactive}Mult){}",
          },
        },
        kh_flavour = {
          "\"Give me strength!\""
        }
      },

      j_kh_stained_glass = {
        name = "Stained Glass",
        text = {
          "Add a {C:attention}Glass King{}",
          "of {C:hearts}Hearts{} to played",
          "hand before scoring"
        }
      },

      j_kh_spellbinder = {
        name = "Spellbinder",
        text = {
          "{C:attention}Flushes{} can be made with",
          "{C:attention}5{} cards of the same",
          "{C:attention}Enhancement"
        }
      },

      j_kh_hayner = {
        name = "Hayner",
        text = {
          "Earn {C:money}$#1#{} when",
          "a {C:attention}Joker{} is sold"
        }
      },

      j_kh_olette = {
        name = "Olette",
        text = {
          "{C:hearts}Hearts{} held in hand",
          "at end of round",
          "give {C:money}$#1#{} each"
        }
      },

      j_kh_sketchbook = {
        name = "Sketchbook",
        text = {
          "When a card is {C:attention}Enhanced{},",
          "convert {C:attention}adjacent{} cards",
          "into the same {C:attention}Enhancement",
        }
      },

      j_kh_pence = {
        name = "Pence",
        text = {
          "{C:attention}Enhance{} all {C:attention}unenhanced{}",
          "cards held in hand",
          "at end of round"
        }
      },

      j_kh_corridor_of_darkness = {
        name = "{s:0.8}Corridor of Darkness",
        text = {
          "{C:green}#1# in #2#{} chance to",
          "destroy discarded cards",
        }
      },

      j_kh_unversed = {
        name = "Unversed",
        text = {
          "{V:1}#1#{} count as",
          "any {C:attention}suit{}",
          "{s:0.8}Suit changes every round"
        }
      },

      j_kh_wayfinder = {
        name = "Wayfinder",
        text = {
          "{C:attention}Playing Cards{} permanently gain",
          "{C:white,X:mult}X#1#{} Mult when retriggered",
          "by {C:attention}Re:Cards{}"
        },
        kh_flavour = {
          "\"An unbreakable connection\"",
        }
      },

      j_kh_munny = {
        name = "Munny",
        text = {
          "{C:attention}Drag{} this Joker onto a card",
          "in the {C:green}shop{} to {C:enhanced}SWAP{} places",
          "with it and gain {C:white,X:mult}X#2#{} Mult",
          "{s:0.8}Gains {C:money,s:0.8}$1{} {s:0.8}of {C:attention,s:0.8}buy value{} {s:0.8}every {C:enhanced,s:0.8}SWAP{}",
          "{C:inactive}(Currently {C:white,X:mult}X#1#{}{C:inactive} Mult)"
        }
      },

      j_kh_jiminy_journal = {
        name = "Jiminy's Journal",
        text = {
          "{C:chips}+#1#{} Chips per {C:attention}round{}",
          "played this run",
          "{C:inactive}(Currently {C:chips}+#2#{C:inactive})",
        }
      },

      j_kh_thtnw = {
        name = "The Hand That Never Was",
        text = {
          "Played hands count as containing",
          "your {C:attention}most played{} poker hand",
          "{C:inactive}(Currently: {C:attention}#1#{C:inactive})"
        }
      },

      j_kh_gummi_garage = {
        name = "Gummi Garage",
        text = {
          "This Joker gains {C:white,X:mult}X#2#{} Mult",
          "per {C:money}${} spent in the shop,",
          "resets when money reaches {C:money}$0",
          "{C:inactive}(Currently {C:white,X:mult}X#1#{C:inactive} Mult)"
        }
      },

      j_kh_oblivion = {
        name = "Oblivion",
        text = {
          {
            "All {C:hearts}Heart{} cards are",
            "drawn {C:attention}face down{}",
          },
          {
            "Played {C:hearts}Hearts{} give {C:mult}+#1#{} Mult",
            "when played and not scored"
          }
        }
      },
      j_kh_book_of_prophecies = {
        name = "Book of Prophecies",
        text = {
          "Pay {C:money}$#1#{} to reroll",
          "{C:attention}Skip Tags{} in {C:attention}Blind Select"
        }
      },
      j_kh_agrabah = {
        name = "Agrabah",
        text = {
          "{C:attention}#1#s{} may",
          "appear in the shop",
          "{s:0.8}Enhancement changes every round"
        }
      },
      j_kh_traverse_town = {
        name = "Traverse Town",
        text = {
          "Skipping a {C:attention}Blind{} adds {C:attention}+#1#%",
          "discount to the next {C:attention}shop",
          "{C:inactive}(Currently {C:attention}#2#%{}{C:inactive} off)"
        }
      },
      j_kh_struggle = {
        name = "Struggle",
        text = {
          "Creates a random {C:attention}Tag{}",
          "if you leave the {C:attention}shop",
          "without {C:green}rerolling{}"
        }
      },
      j_kh_sparrow = {
        name = "Captain Sparrow",
        text = {
          "{C:attention}Jacks{} can be used as",
          "{C:attention}any rank{} in a {C:attention}Straight{}",
          "{C:inactive}(ex: {C:attention}8 7 6 J 4{C:inactive})",
        }
      },
      j_kh_mog_card = {
        name = "M.O.G Card",
        text = {
          "Every {C:attention}#1#{} {C:inactive}[#2#]{} items purchased,",
          "create a free {C:attention}#3#{}",
        }
      },
      j_kh_soras_gloving = {
        name = "Sora's Gloves",
        text = {
          "You may select {C:attention}1{} more",
          "card from {C:attention}Booster Packs{}"
        }
      },
      j_kh_jackpot = {
        name = "Jackpot",
        text = {
          "Doubles the next {C:green}probability{}",
          "when a {C:green}probability{} fails",
          "{C:inactive,s:0.8}(ex: {C:green,s:0.8}1 in 4{C:inactive,s:0.8} -> {C:green,s:0.8}2 in 4{C:inactive,s:0.8} -> {C:green,s:0.8}4 in 4{C:inactive,s:0.8})",
        }
      },
      j_kh_marluxia = {
        name = "Marluxia",
        text = {
          "Retrigger all",
          "card {C:attention}discarded",
          "effects",
        }
      },
      j_kh_vanitas = {
        name = "Vanitas",
        text = {
          "If {C:attention}first discard{} of round",
          "has only {C:attention}1{} card,",
          "discard your entire hand"
        }
      },

      j_kh_mark_of_mastery = {
        name = "Mark of Mastery",
        text = {
          "Played {C:attention}Enhanced{} cards",
          "give {C:mult}+#1#{} Mult when scored"
        }
      },
      j_kh_better_weapon = {
        name = "Better Weapon",
        text = {
          "When a {C:attention}consumable{} is used,",
          "{C:white,X:mult}X#1#{} Mult next hand",
        },
        kh_flavour = {
          "\"This gun i found.\""
        }
      },
      j_kh_cloudzxiii = {
        name = "cloudzXIII",
        text = {
          {
            "Consumable slots",
            "may hold {C:attention}Jokers{}",
          },
          {
            "Joker slots may",
            "hold {C:attention}Consumables{}",
          }
        },
        kh_flavour = {
          "\"um\""
        }
      },

      j_kh_strelitzia = {
        name = "Strelitzia",
        text = {
          "When {C:attention}Blind{} is selected,",
          "transfer {C:attention}Keychain{} from",
          "Joker to the {C:attention}left{} to",
          "Joker to the {C:attention}right{}"
        },
      },

      j_kh_demyx = {
        name = "Demyx",
        text = {
          "Every {C:attention}#3#th{} scored",
          "card gives {X:mult,C:white}X#1#{} Mult",
          "{C:inactive}[{C:attention}#2#{C:inactive}/#3#]",
        },
        kh_flavour = {
          "\"Dance Water, Dance!\""
        }
      },

      j_kh_zexion = {
        name = "Zexion",
        text = {
          "This Joker gains",
          "{C:chips}+#2#{} Chips per unique {C:attention}suit{}",
          "in {C:attention}first{} played hand",
          "{C:inactive}(Currently {C:chips}+#1#{C:inactive} Chips)",
        },
      },

      j_kh_vexen = {
        name = "Vexen",
        text = {
          "Scoring {C:attention}even{} cards permanently",
          "gain {C:chips}+#1#{} Chips for each",
          "remaining {C:attention}even{} card in {C:attention}deck{}",
          "{C:inactive}(Will gain {C:chips}+#2#{C:inactive} Chips)"
        },
        kh_flavour = {
          "\"And you will share that fate, Sora!\""
        }
      },

      j_kh_xemnas = {
        name = "Xemnas",
        text = {
          "This Joker gains {C:chips}+#2#{} Chips",
          "for {C:attention}every{} poker hand",
          "contained in played hand",
          "{C:inactive}(Currently {C:chips}+#1#{} {C:inactive}Chips)"
        },
      },
    },
  }
}
