local function reset_tamagotchi(card)
  MIX.kh_juice_until(card, function(c) return not c.ability.extra.fed end, true)
  card.ability.extra.fed = false
  card.ability.extra.set = pseudorandom_element({ "Playing Card", "Joker", "Tarot", "Planet" },
    "kh_tamagotchi_seed")
  SMODS.calculate_effect({ message = localize("k_kh_hungry_ex"), colour = G.C.FILTER }, card)
end

SMODS.Joker {
  key = "tamagotchi",

  loc_vars = function(self, info_queue, card)
    local set = card.ability.extra.set
    return {
      key = (set == "Joker" or set == "Playing Card") and self.key .. "_normal" or self.key,
      vars = {
        card.ability.extra.chips,
        card.ability.extra.chips_gain,
        set,
        colours = { (set == "Joker" or set == "Playing Card") and G.C.FILTER or G.C.SECONDARY_SET[card.ability.extra.set] }
      }
    }
  end,

  rarity = 2,
  cost = 7,
  atlas = 'KHJokers',
  pos = { x = 0, y = 6 },

  discovered = true,
  blueprint_compat = true,

  config = {
    extra = {
      chips = 0,
      chips_gain = 20,
      set = "Tarot",
      fed = false
    }
  },

  add_to_deck = function(self, card, from_debuff)
    MIX.kh_juice_until(card, function(c) return not c.ability.extra.fed end, true)
  end,
  calculate = function(self, card, context)
    if context.setting_blind and not context.blueprint then
      reset_tamagotchi(card)
    end

    if context.ending_shop and not card.ability.extra.fed then
      card.ability.extra.chips = card.ability.extra.chips / 2
      SMODS.calculate_effect({ message = localize("k_kh_halved_ex"), colour = G.C.RED }, card)
    end

    if context.joker_main then
      return {
        chips = card.ability.extra.chips
      }
    end
  end,
}

MIX.tamagotchi_consumables = { Tarot = true, Planet = true }

local function get_area_for_set(set)
  if set == "Playing Card" then return G.hand end
  if set == "Joker" then return G.jokers end
  if MIX.tamagotchi_consumables[set] then return G.consumeables end
end

local function can_feed(card)
  local set = card.ability.extra.set
  local area = get_area_for_set(set)
  if not area then return false end

  if set == "Playing Card" then
    return #area.highlighted == 1
  elseif set == "Joker" then
    for _, joker in ipairs(area.highlighted) do
      if joker ~= card then
        return true
      end
    end
    return false
  else
    return #area.highlighted == 1 and area.highlighted[1].ability.set == set
  end
end

local function find_feed_card(card)
  local set = card.ability.extra.set
  local area = get_area_for_set(set)
  if not area then return nil end

  if set == "Joker" then
    for _, joker in ipairs(area.highlighted) do
      if joker ~= card then
        return joker
      end
    end
    return nil
  end

  return area.highlighted[1]
end

G.FUNCS.kh_feed = function(e)
  local card = e.config and e.config.ref_table
  local target = find_feed_card(card)
  if not target then return end
  SMODS.destroy_cards(target)

  SMODS.scale_card(card, {
    ref_table = card.ability.extra,
    ref_value = "chips",
    scalar_value = "chips_gain",
    operation = '+',
    scaling_message = { message = localize("k_kh_fed_ex"), colour = G.C.CHIPS },
  })
  card.ability.extra.fed = true
  card:highlight(false)
end

G.FUNCS.kh_can_feed = function(e)
  local card = e.config and e.config.ref_table
  if not can_feed(card) or card.ability.extra.fed then
    e.config.colour = G.C.UI.BACKGROUND_INACTIVE
    e.config.button = nil
  else
    e.config.colour = HEX('bec7d4')
    e.config.button = "kh_feed"
  end
end

--#region Button definition
SMODS.DrawStep {
  key = 'tamagotchi_button',
  order = -30,
  func = function(self)
    if self.children.kh_tamagotchi_button and self.highlighted then
      self.children.kh_tamagotchi_button:draw()
    end
  end,
}
SMODS.draw_ignore_keys.kh_tamagotchi_button = true

local highlight_ref = Card.highlight
function Card.highlight(self, is_highlighted)
  if is_highlighted and self.ability.set == "Joker" and self.config.center.key == "j_kh_tamagotchi" and self.area == G.jokers then
    if not self.children.kh_tamagotchi_button then
      self.children.kh_tamagotchi_button = UIBox {
        definition = kh_tamagotchi_def(self),
        config = { align = "bmi", offset = { x = 0, y = 0.7 }, parent = self }
      }
    end
  elseif self.children.kh_tamagotchi_button then
    self.children.kh_tamagotchi_button:remove()
    self.children.kh_tamagotchi_button = nil
  end

  return highlight_ref(self, is_highlighted)
end

function kh_tamagotchi_def(card)
  return {
    n = G.UIT.R,
    config = {
      ref_table = card,
      r = 0.08,
      padding = 0.1,
      align = "bm",
      minw = 0.5 * card.T.w - 0.15,
      maxw = 0.9 * card.T.w - 0.15,
      minh = 0.4 * card.T.h,
      hover = true,
      shadow = true,
      colour = G.C.DARK_EDITION,
      button = 'kh_feed',
      func = 'kh_can_feed'
    },
    nodes = {
      {
        n = G.UIT.R,
        config = { align = "cm" },
        nodes = {
          { n = G.UIT.T, config = { text = "FEED", colour = G.C.UI.TEXT_LIGHT, scale = 0.45, shadow = true } }
        }
      },
    }
  }
end

--#endregion
