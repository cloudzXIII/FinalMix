KH = SMODS.current_mod
MIX = MIX or {}

KH.save_config = function(self)
  SMODS.save_mod_config(self)
end

SMODS.DynaTextEffect {
  key = "pulse",
  func = function(dynatext, index, letter)
    local t = G.TIMERS.REAL * 1.2 + index * 0.25
    letter.y = math.sin(t) * 2
    letter.r = math.sin(t * 0.5) * 0.2
  end
}

SMODS.Gradient {
  key = "title",
  colours = {
    HEX('babcbf'),
    G.C.BLUE,
  },
  cycle = 5,
  interpolation = 'linear',
}

KH.optional_features = {
  post_trigger = true,
  retrigger_joker = true
}

-- Utility Functions
local cards = NFS.getDirectoryItems(KH.path .. "utilities")
for _, filename in pairs(cards) do
  assert(SMODS.load_file("utilities/" .. filename))()
end

-- Blockbuster Support!
if Blockbuster then
  SMODS.load_file("content/crossmod/value_manipulation.lua")()
end

-- Jokers
local subdir = "content/cards"
local cards = NFS.getDirectoryItems(KH.path .. subdir)
for _, filename in pairs(cards) do
  assert(SMODS.load_file(subdir .. "/" .. filename))()
end

-- Misc
local cards = NFS.getDirectoryItems(KH.path .. "content/misc")
for _, filename in pairs(cards) do
  assert(SMODS.load_file("content/misc/" .. filename))()
end

-- Consumables
SMODS.load_file("content/consumables/tarots.lua")()
SMODS.load_file("content/consumables/spectrals.lua")()

-- Ortalab Crossmod!
if next(SMODS.find_mod('ortalab')) then
  SMODS.load_file("content/crossmod/ortalab_jokers.lua")()
end

-- Cold Beans Crossmod!
-- ok for some reason cold beans ruins my atlas... (in fourth row of atlas my jokers have a fat line on it with this mod enabled)
if next(SMODS.find_mod('ColdBeans')) then
  SMODS.load_file("content/crossmod/coldbeans_sidequests.lua")()
end

-- Joker Display Support!
if JokerDisplay then
  SMODS.load_file("content/crossmod/joker_display_definitions.lua")()
end

-- Partner API Crossmod!
if Partner_API then
  SMODS.load_file("content/crossmod/partners.lua")()
end

-- CardSleeves Crossmod!
if CardSleeves then
  SMODS.load_file("content/crossmod/cardsleeves.lua")()
end

--[[ WIP soon tm
if BLINDSIDE then
  SMODS.load_file("content/crossmod/blindside_blinds.lua")()
  SMODS.load_file("content/crossmod/blindside_jokers.lua")()
end
--]]
