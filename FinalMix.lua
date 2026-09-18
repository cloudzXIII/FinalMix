KH = SMODS.current_mod
MIX = MIX or {}

KH.save_config = function(self)
  SMODS.save_mod_config(self)
end

KH.optional_features = {
  quantum_enhancements = true,
  retrigger_joker = true
}

-- G.GAME variables
local init_game_object_ref = Game.init_game_object
---@diagnostic disable-next-line: duplicate-set-field
function Game:init_game_object(...)
  local ret = init_game_object_ref(self, ...)
  ret.kh = {
    -- Luxord Challenge
    luxord_sold = false,
    luxord_destroyed = false,
    -- Aqua
    any_drag = false,
    -- Data Sora (Unique Hand Types played this ante)
    unique_hands = {},
  }
  return ret
end

-- Colours
G.C.KH_PLASMA = { 0.8, 0.45, 0.85, 1 }

local loc_colour_ref = loc_colour
---@diagnostic disable-next-line: duplicate-set-field, lowercase-global
function loc_colour(_c, _default)
  if not G.ARGS.LOC_COLOURS then
    loc_colour_ref()
  end

  G.ARGS.LOC_COLOURS.finalmix = KH.badge_colour
  G.ARGS.LOC_COLOURS.kh_plasma = { 0.8, 0.45, 0.85, 1 }

  return loc_colour_ref(_c, _default)
end

-- Loads all files in a given directory
MIX.load_folder = function(dir)
  local items = NFS.getDirectoryItems(KH.path .. dir)
  for _, filename in pairs(items) do
    assert(SMODS.load_file(dir .. "/" .. filename))()
  end
end

-- Utility Functions
MIX.load_folder("utilities")


local order = {
  -- Page 1
  "sora",
  "riku",
  "kairi_and_namine",
  "roxas",
  "axel",
  "xion",
  "mickey",
  "donald",
  "goofy",
  "yensid",
  "aqua",
  "terra",
  "ventus",
  "vanitas",
  "xehanort",

  -- Page 2
  "xemnas",
  "xigbar",
  "demyx",
  "luxord",
  "larxene",
  "marluxia",
  "zexion",
  "vexen",
  "nobody",
  "heartless",
  "unversed",
  "master_of_masters",
  "strelitzia",
  "datasora",
  "timeless_river_sora",

  -- Page 3
  "kingdomhearts",
  "dtd",
  "traverse_town",
  "agrabah",
  "thtnw",
  "com",
  "corridor_of_darkness",
  "mark_of_mastery",
  "book_of_prophecies",
  "jiminy_journal",
  "khtrilogy",
  "wayfinder",
  "stained_glass",
  "struggle",
  "helpwanted",

  -- Page 4
  "moogle",
  "mog_card",
  "hayner",
  "pence",
  "olette",
  "cloudstrife",
  "bryce",
  "sparrow",
  "sketchbook",
  "soras_gloving",
  "lethimcook",
  "randomjoker",
  "tamagotchi",
  "preorder_bonus",
  "cloudzxiii",

  -- Page 5
  "keyblade",
  "spellbinder",
  "oblivion",
  "better_weapon",
  "paopufruit",
  "sealsalticecream",
  "munnypouch",
  "munny",
  "gummiphone",
  "gummiship",
  "gummi_garage",
  "commands",
  "magnet",
  "invitation",
  "jackpot",
}
for _, key in ipairs(order) do
  assert(SMODS.load_file("content/cards/" .. key .. ".lua"))()
end

-- Misc
MIX.load_folder("content/misc")

-- Consumables
MIX.load_folder("content/consumables")

-- Cold Beans Crossmod!
if next(SMODS.find_mod("ColdBeans")) then
  assert(SMODS.load_file("content/crossmod/coldbeans_sidequests.lua"))()
end

-- Abandonia Crossmod!
if next(SMODS.find_mod("abandonia")) then
  assert(SMODS.load_file("content/crossmod/abandonia.lua"))()
end

-- Partner API Crossmod!
---@diagnostic disable-next-line: undefined-global
if Partner_API then
  assert(SMODS.load_file("content/crossmod/partners.lua"))()
end

-- CardSleeves Crossmod!
---@diagnostic disable-next-line: undefined-global
if CardSleeves then
  assert(SMODS.load_file("content/crossmod/cardsleeves.lua"))()
end

-- Reverie Crossmod!
if next(SMODS.find_mod("Reverie")) then
  assert(SMODS.load_file("content/crossmod/cine_cards.lua"))()
end

--[[ WIP soon tm
if BLINDSIDE then
  --SMODS.load_file("content/crossmod/blindside_blinds.lua")()
  assert(SMODS.load_file("content/crossmod/blindside_jokers.lua"))()
end
--]]

-- Mod Calculate
KH.calculate = function(self, context)
  if context.other_joker then
    local ability = context.other_joker.ability

    ---@diagnostic disable: need-check-nil
    local has_chips = ability.kh_perma_bonus and ability.kh_perma_bonus ~= 0
    local has_mult = ability.kh_perma_mult and ability.kh_perma_mult ~= 0
    local has_x_mult = ability.kh_perma_xmult and ability.kh_perma_xmult ~= 1
    local has_x_chips = ability.kh_perma_xchips and ability.kh_perma_xchips ~= 1
    local has_dollars = ability.kh_perma_dollars and ability.kh_perma_dollars ~= 0

    if has_chips or has_mult or has_x_mult or has_x_chips or has_dollars then
      return {
        chips = has_chips and ability.kh_perma_bonus or nil,
        mult = has_mult and ability.kh_perma_mult or nil,
        x_mult = has_x_mult and ability.kh_perma_xmult or nil,
        x_chips = has_x_chips and ability.kh_perma_xchips or nil,
        dollars = has_dollars and ability.kh_perma_dollars or nil,
        card = context.other_joker,
        message_card = context.other_joker,
        no_juice = true,
      }
    end
  end

  -- Count Unique Hand Types played this ante (used for Data Sora)
  if context.before and not G.GAME.kh.unique_hands[context.scoring_name] then
    local already_played = false
    for _, hand in ipairs(G.GAME.kh.unique_hands) do
      if hand == context.scoring_name then
        already_played = true
        return
      end
    end
    if not already_played then
      G.GAME.kh.unique_hands[#G.GAME.kh.unique_hands + 1] = context.scoring_name
    end
  end
  if context.end_of_round and context.main_eval and context.beat_boss and not context.blueprint then
    G.GAME.kh.unique_hands = {}
  end
end

-- Global reset stuff
function KH.reset_game_globals(run_start)
  MIX.reset_kh_bryce_card()
  MIX.reset_keyblade_rank()
  MIX.reset_kh_heartless_card()
  MIX.reset_kh_mom_card()
  MIX.reset_xion_joker()
  MIX.reset_agrabah_world()
  MIX.reset_unversed_card()
end

KH.menu_cards = function()
  if KH.config.enable_custom_main_menu then
    return { { key = "j_kh_sora" }, }
  end
end
