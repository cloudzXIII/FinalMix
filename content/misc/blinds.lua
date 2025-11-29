--[[SMODS.Blind {
  key = 'shuffled',
  loc_txt = {
    name = 'Shuffled',
    text = {
      'Shuffles Jokers',
      'When hand is played',
    }
  },
  discovered = true,
  vars = {},
  dollars = 5,
  mult = 2,
  debuff = {},
  boss = { min = 0, max = 10 },
  boss_colour = HEX('c88465'),
  pos = { x = 0, y = 0 },
  atlas = 'KHBlind',
  press_play = function(self)
  end,
  calculate = function(self, blind, context)
    if context.after and context.main_eval and not context.blueprint then
      for i, card in ipairs(G.play.cards) do
        if not card.shattered then
          draw_card(G.play, G.deck, i * 100 / #G.play.cards, 'down', true, card, nil, true)
        end
      end
    end
    if context.discard and not context.blueprint then
      draw_card(G.discard, G.deck, 10, 'down', true, context.other_card, nil, true)
    end
  end
}
--]]
