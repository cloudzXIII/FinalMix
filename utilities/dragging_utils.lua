-- Borrowed/modified functions from Aikoyori's Shenanigans, (https://github.com/Aikoyori/Balatro-Aikoyoris-Shenanigans), go play it!

MIX.card_conf_any_drag = function(area, card)
  --for Aqua allowing you to drag playing cards to consumable slots
  if next(SMODS.find_card("j_kh_aqua")) then
    if card.area and (card.area == G.deck) then
      if (card.ability.set == "Default" or card.ability.set == "Enhanced" or card.ability.set == "Playing Card") and area == G.consumeables then
        return true
      end
    end

    if card.area == G.consumeables then
      if (card.ability.set == "Default" or card.ability.set == "Enhanced" or card.ability.set == "Playing Card") and (area == G.deck) then
        return true
      end
    end
  end
  -- for cloudzXIII allowing Jokers in consumable slots, and vice versa
  if next(SMODS.find_card("j_kh_cloudzxiii")) then
    -- Dragging from Jokers to Consumables
    if card.area == G.jokers then
      if (card.ability.set == "Joker" or card.ability.consumeable) and area == G.consumeables then
        return true
      end
    end

    -- Dragging from Consumables to Joker
    if card.area == G.consumeables then
      if (card.ability.set == "Joker" or card.ability.consumeable) and area == G.jokers then
        return true
      end
    end
  end
  return false
end

function MIX.remove_value_from_table(tbl, value)
  local index = MIX.get_pos(tbl, value)
  if index then
    table.remove(tbl, index)
    return true
  end
  return false
end

MIX.emplace_funcs = {}

MIX.emplace_funcs.always_placeable = function(ca, card) return G.OVERLAY_MENU and false or true end

MIX.edition_extend_card_limit = function(card)
  if card then
    if card.edition then
      if card.edition.key == "e_negative" then
        return 1
      end
    end
  end
  return 0
end

MIX.card_any_drag = function()
  return G and G.GAME and ((G.GAME.xiii_any_drag and not G.OVERLAY_MENU) or G.GAME.kh_drag_everything)
end

MIX.simple_event_add = function(func, delay, queue, config)
  config = config or {}
  G.E_MANAGER:add_event(Event {
    trigger = config.trigger or 'after',
    delay = delay or 0.1,
    func = func,
    blocking = config.blocking,
    blockable = config.blockable,
  }, queue, config.front)
end

--#region HOOKS
local cardReleaseRecalcHook = Card.stop_drag
function Card:stop_drag()
  local target_area = nil
  self.xiii_oldarea = self.area or self.xiii_oldarea

  for i, k in ipairs(G.CONTROLLER.collision_list) do
    if (k:is(CardArea)) then
      if (k.config.xiii_emplace_func and MIX.emplace_funcs[k.config.xiii_emplace_func] and MIX.emplace_funcs[k.config.xiii_emplace_func](k, self)) or MIX.card_conf_any_drag(k, self) or MIX.card_any_drag() then
        target_area = k
        break
      end
    end
  end

  if target_area and target_area ~= self.area then
    local old_area = self.area

    local can_place = false
    if G.GAME.kh_drag_everything then
      can_place = true
    else
      local card_limit = target_area.config.card_limit or 99
      can_place = (card_limit + MIX.edition_extend_card_limit(self) >= #target_area.cards + 1) or
          target_area == G.hand or
          target_area == G.deck
    end

    if can_place then
      if old_area == G.hand or old_area == G.deck then
        MIX.remove_value_from_table(G.playing_cards, self)
      end

      if old_area then
        old_area:remove_card(self)
      end

      if target_area == G.hand or target_area == G.deck then
        table.insert(G.playing_cards, self)
      end

      target_area:emplace(self)
      target_area:align_cards()
      if old_area then old_area:align_cards() end

      self:juice_up(0.2, 0.2)
      play_sound("cardSlide1")

      MIX.simple_event_add(
        function()
          self.xiii_oldarea = nil
          return true
        end, 0
      )

      return
    end
  end

  local c = cardReleaseRecalcHook(self)
  return c
end

local caSave = CardArea.save
---@diagnostic disable-next-line: duplicate-set-field
function CardArea:save(cardAreaTable)
  if G.GAME.xiii_any_drag and cardAreaTable then
    cardAreaTable.xiii_drag_to_target_save = self.states.collide.can
  end
  return caSave(self, cardAreaTable)
end

local caLoad = CardArea.load
---@diagnostic disable-next-line: duplicate-set-field
function CardArea:load(cardAreaTable)
  if G.GAME.xiii_any_drag and cardAreaTable then
    self.states.collide.can = cardAreaTable.xiii_drag_to_target_save
  end
  return caLoad(self, cardAreaTable)
end

local igo = Game.init_game_object
---@diagnostic disable-next-line: duplicate-set-field
function Game:init_game_object()
  local ret = igo(self)
  ret.xiii_any_drag = false
  ret.kh_drag_everything = false
  return ret
end

local cardAreaAlignHook = CardArea.align_cards
---@diagnostic disable-next-line: duplicate-set-field
function CardArea:align_cards()
  local r = cardAreaAlignHook(self)
  if G.GAME.kh_drag_everything and not self.states.collide.can then
    self.states.collide.can = true
  end
  if G.GAME.kh_drag_everything and self == G.play and self.states.collide.can then
    self.states.collide.can = false
  end
end

--#endregion
