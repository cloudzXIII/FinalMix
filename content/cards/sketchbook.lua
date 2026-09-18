SMODS.Joker {
  attributes = { "reference", "FinalMix", "modify_card" },
  key = 'sketchbook',

  loc_vars = function(self, info_queue, card)
    return {
      vars = {},
    }
  end,

  atlas = "KHJokers",
  pos = { x = 2, y = 6 },
  rarity = 3,
  cost = 5,
  blueprint_compat = false,

  config = {
    extra = {
    }
  },

  calculate = function(self, card, context)
    if context.setting_ability and not context.unchanged and not context.check_enhancement and G.P_CENTERS[context.new].set == 'Enhanced' then
      if not context.other_card.ability.kh_sketching then
        local pos = MIX.get_pos(context.other_card, G.hand.cards)
        local right = G.hand.cards[pos + 1]
        local left = G.hand.cards[pos - 1]

        G.E_MANAGER:add_event(Event({
          trigger = 'after',
          func = function()
            local should_trigger = false
            for _, adj in pairs({ left, right }) do
              if adj and adj.config.center.key ~= context.new then
                should_trigger = true
                break
              end
            end
            if should_trigger then
              play_sound('tarot1')
              card:juice_up(0.3, 0.5)
            end
            return true
          end
        }))
        for _, adj in pairs({ left, right }) do
          if adj then
            G.E_MANAGER:add_event(Event({
              trigger = 'after',
              delay = 0.15,
              func = function()
                if adj.config.center.key ~= context.new then
                  adj:flip()
                  play_sound('card1', 1)
                  adj:juice_up(0.3, 0.3)
                end
                return true
              end
            }))
          end
        end
        for _, adj in pairs({ left, right }) do
          if adj then
            G.E_MANAGER:add_event(Event({
              trigger = 'after',
              delay = 0.1,
              func = function()
                if adj.config.center.key ~= context.new then
                  adj.ability.kh_sketching = true
                  adj:set_ability(context.new)
                end
                return true
              end
            }))
          end
        end
        for _, adj in pairs({ left, right }) do
          if adj then
            G.E_MANAGER:add_event(Event({
              trigger = 'after',
              delay = 0.15,
              func = function()
                if adj.ability.kh_sketching then
                  adj:flip()
                  play_sound('tarot2', 1, 0.6)
                  adj:juice_up(0.3, 0.3)
                end
                return true
              end
            }))
          end
        end

        for _, hand_card in pairs(G.hand.cards) do
          hand_card.ability.kh_sketching = nil
        end
      end
    end
  end,
}
