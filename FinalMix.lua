KH = SMODS.current_mod

SMODS.Gradient {
  key = "badge",
  colours = {
    HEX('334362'),
    HEX('5973B2'),
    HEX('7A8CCF'),
    HEX('8A7FBF'),
    HEX('404D80'),
  },
  cycle = 10,
  interpolation = 'trig',
}

KH.badge_colour = SMODS.Gradients.kh_badge

KH.description_loc_vars = function()
  return { background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1.2, shadow = true }
end

SMODS.DynaTextEffect {
  key = "pulse",
  func = function(dynatext, index, letter)
    local t = G.TIMERS.REAL * 1.2 + index * 0.25
    letter.y = math.sin(t) * 2
    letter.r = math.sin(t * 0.5) * 0.2
  end
}

-- tailsman thingy
to_big = to_big or function(x) return x end

SMODS.current_mod.optional_features = {
  post_trigger = true,
}

-- Utility Functions
local cards = NFS.getDirectoryItems(SMODS.current_mod.path .. "utilities")
for _, filename in pairs(cards) do
  assert(SMODS.load_file("utilities/" .. filename))()
end

-- Blockbuster Support!
if Blockbuster then
  SMODS.load_file("content/crossmod/value_manipulation.lua")()
end

--#region mod config options
KH.save_config = function(self)
  SMODS.save_mod_config(self)
end

if KH.config.enable_jokers then
  local subdir = "content/cards"
  local cards = NFS.getDirectoryItems(SMODS.current_mod.path .. subdir)
  for _, filename in pairs(cards) do
    assert(SMODS.load_file(subdir .. "/" .. filename))()
  end
  SMODS.load_file("content/misc/challenges.lua")() -- Only loads Challenges if Jokers are enabled
end

if KH.config.enable_tarots then
  SMODS.load_file("content/consumables/tarots.lua")()
end

if KH.config.enable_spectrals then
  SMODS.load_file("content/consumables/spectrals.lua")()
end

if KH.config.enable_seal then
  SMODS.load_file("content/misc/seal.lua")()
end

if KH.config.enable_blind then
  SMODS.load_file("content/misc/blinds.lua")()
end

if KH.config.enable_vouchers then
  SMODS.load_file("content/misc/vouchers.lua")()
end
--#endregion

-- Joker Display Support!
if JokerDisplay then
  SMODS.load_file("content/crossmod/joker_display_definitions.lua")()
end

-- Partner API Support!
if Partner_API then
  SMODS.load_file("content/crossmod/partners.lua")()
end

-- CardSleeves Support!
if CardSleeves then
  SMODS.load_file("content/crossmod/cardsleeves.lua")()
end


SMODS.load_file("content/collabs/kingdomheartsxbalatro.lua")()
SMODS.load_file("content/misc/jimboquips.lua")()
SMODS.load_file("content/misc/decks.lua")()
SMODS.load_file("content/misc/boosters.lua")()
SMODS.load_file("content/consumables/drive_cards.lua")()
