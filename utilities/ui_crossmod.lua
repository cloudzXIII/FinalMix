function MIX.button_with_tooltip(args)
  local button = UIBox_button(args)
  if args.tooltip then
    button.nodes[1].config.tooltip = {
      title = args.label and args.label[1] or "",
      text = { args.tooltip },
    }
  end
  return button
end

-- Crossmod Tab
KH.crossmod_tab = function()
  local title_text = DynaText({
    string = localize("k_kh_crossmod"),
    colours = { G.C.DARK_EDITION },
    shadow = true,
    float = true,
    silent = true,
    spacing = 5,
    scale = 1.3,
    rotate = true,
    pop_in = 0,
  })
  title_text.states.visible = false

  return {
    n = G.UIT.ROOT,
    config = {
      emboss = 0.05,
      r = 0.1,
      align = "tm",
      padding = 0.2,
      colour = G.C.BLACK
    },
    nodes = {
      {
        n = G.UIT.R,
        config = { r = 0.1, minw = 4, align = "tm", padding = 0.2, colour = G.C.BLACK },
        nodes = {
          {
            n = G.UIT.C,
            config = { align = "cm", padding = 0.5, colour = darken(G.C.BLACK, 0.2), emboss = 0.05, r = 0.1 },
            nodes = {
              {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                  { n = G.UIT.O, config = { object = title_text } },
                },
              },
              {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.2 },
                nodes = {
                  MIX.button_with_tooltip({
                    minw = 2.5,
                    colour = G.C.GREEN,
                    button = "kh_joker_display",
                    label = { localize("k_kh_jokerdisplay") },
                    tooltip = localize("k_kh_jokerdisplay_info"),
                    col = true,
                  }),
                  MIX.button_with_tooltip({
                    minw = 2.5,
                    colour = G.C.CHIPS,
                    button = "kh_card_sleeves",
                    label = { localize("k_kh_cardsleeves") },
                    tooltip = localize("k_kh_cardsleeves_info"),
                    col = true,
                  }),
                  MIX.button_with_tooltip({
                    minw = 2.5,
                    colour = HEX("366999"),
                    button = "kh_partner_api",
                    label = { localize("k_kh_partner") },
                    tooltip = localize("k_kh_partner_info"),
                    col = true,
                  }),
                },
              },
              {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.2 },
                nodes = {
                  MIX.button_with_tooltip({
                    minw = 2.5,
                    colour = HEX("9db95f"),
                    button = "kh_reverie",
                    label = { localize("k_kh_reverie") },
                    tooltip = localize("k_kh_reverie_info"),
                    col = true,
                  }),
                  MIX.button_with_tooltip({
                    minw = 2.5,
                    colour = HEX("5d5e8d"),
                    button = "kh_abandonia",
                    label = { localize("k_kh_abandonia") },
                    tooltip = localize("k_kh_abandonia_info"),
                    col = true,
                  }),
                  MIX.button_with_tooltip({
                    minw = 2.5,
                    colour = HEX("caebed"),
                    button = "kh_coldbeans",
                    label = { localize("k_kh_coldbeans") },
                    tooltip = localize("k_kh_coldbeans_info"),
                    col = true,
                  }),
                },
              },
            },
          },
        },
      },
    },
  }
end
KH.extra_tabs = function()
  return {
    label = localize("k_kh_crossmod"),
    tab_definition_function = KH.crossmod_tab,
  }
end

G.FUNCS.kh_joker_display = function(e)
  love.system.openURL("https://github.com/nh6574/JokerDisplay")
end

G.FUNCS.kh_card_sleeves = function(e)
  love.system.openURL("https://github.com/larswijn/CardSleeves")
end

G.FUNCS.kh_partner_api = function(e)
  love.system.openURL("https://github.com/Icecanno/Partner-API")
end

G.FUNCS.kh_coldbeans = function(e)
  love.system.openURL("https://github.com/Cdrvo/Cold-Beans")
end

G.FUNCS.kh_abandonia = function(e)
  love.system.openURL("https://github.com/cloudzXIII/Abandonia")
end

G.FUNCS.kh_reverie = function(e)
  love.system.openURL("https://github.com/jumbocarrot0/reverie")
end

--[[
-- One day... have art but need ideas first :p
G.FUNCS.kh_blindside = function(e)
  love.system.openURL("https://github.com/LunaAstraCassiopeia/Blindside")
end

MIX.button_with_tooltip({
  minw = 2.5,
  colour = HEX("3F6AA4"),
  button = "kh_blindside",
  label = { "Blindside" },
  tooltip = "3 Blinds + 1 Joker!",
  col = true,
}),
--]]
