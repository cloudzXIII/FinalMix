KH.C = {
  BG_COLOUR = HEX("3e4960"),

  TAB_BUTTON = HEX("c8a237"),

  OUTLINE = HEX("EAF4FF"),
}

KH.ui_config = {
  colour = KH.C.BG_COLOUR,

  tab_button_colour = KH.C.TAB_BUTTON,
  back_colour = KH.C.TAB_BUTTON,
  collection_back_colour = KH.C.TAB_BUTTON,
  collection_option_cycle_colour = KH.C.TAB_BUTTON,

  outline_colour = KH.C.OUTLINE,
  collection_outline_colour = KH.C.OUTLINE,
}

KH.custom_ui = function(modNodes)
  table.remove(modNodes, 1)
  table.remove(modNodes, 1)

  -- Title
  local scale = 1.2

  local logo = Sprite(0, 0,
    6 * scale,
    6 * scale * (G.ASSET_ATLAS["kh_logo"].py / G.ASSET_ATLAS["kh_logo"].px),
    G.ASSET_ATLAS["kh_logo"], { x = 0, y = 0 }
  )

  modNodes[#modNodes + 1] = {
    n = G.UIT.R,
    config = { align = "cm", padding = 0.05 },
    nodes = {
      {
        n = G.UIT.R,
        config = { align = "cm" },
        nodes = {
          {
            n = G.UIT.O,
            config = {
              align = "cm",
              object = logo,
            },
          },
        },
      },
      {
        n = G.UIT.R,
        config = { align = "cm" },
        nodes = {
          { n = G.UIT.T, config = { text = KH.version, colour = G.C.GOLD, scale = 0.35, padding = 0.5 } },
        },
      },
    },
  }

  -- Jokers
  G.kh_desc_area = CardArea(
    G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2,
    G.ROOM.T.h,
    4.25 * G.CARD_W,
    0.95 * G.CARD_H,
    { card_limit = 5, type = "title", highlight_limit = 0, collection = true }
  )

  --print(G.kh_desc_area.config.card_limit)
  local kh_jokers = MIX.get_center_with_prefix({ "j_kh", "c_kh", "v_kh", "m_kh" })

  local random_jokers = {}

  pseudoshuffle(kh_jokers, pseudoseed("kh_ui_seed"))
  for i = 1, 5 do
    random_jokers[#random_jokers + 1] = kh_jokers[1]
    table.remove(kh_jokers, 1)
  end

  for i, key in ipairs(random_jokers) do
    local card = Card(
      G.kh_desc_area.T.x + G.kh_desc_area.T.w / 2,
      G.kh_desc_area.T.y,
      G.CARD_W,
      G.CARD_H,
      G.P_CARDS.empty,
      G.P_CENTERS[key]
    )
    card.no_ui = true
    G.kh_desc_area:emplace(card)
    card:juice_up()
  end

  modNodes[#modNodes + 1] = {
    n = G.UIT.R,
    config = { align = "cm", padding = 0.07, no_fill = true },
    nodes = {
      { n = G.UIT.O, config = { object = G.kh_desc_area } },
    },
  }

  -- Description
  modNodes[#modNodes + 1] = {
    n = G.UIT.R,
    config = { align = "cm", padding = 0.05 },
    nodes = {
      {
        n = G.UIT.C,
        config = { align = "cm" },
        nodes = {
          {
            n = G.UIT.T,
            config = {
              text = localize("k_kingdomhearts_desc"),
              colour = G.C.UI.TEXT_LIGHT,
              scale = 0.5,
            },
          },
        },
      },
    },
  }
  -- Buttons
  local buttons = {
    { pos = { x = 0, y = 0 }, button = "kh_github_page", tooltip = localize("b_kh_github") },
    { pos = { x = 1, y = 0 }, button = "kh_discord_page", tooltip = localize("b_kh_discord") },
    { pos = { x = 2, y = 0 }, button = "kh_wiki_page", tooltip = localize("b_kh_wiki") },
    { pos = { x = 0, y = 1 }, button = "kh_kofi_page", tooltip = localize("b_kh_kofi") },
  }

  local tag_nodes = {}
  for _, tag in ipairs(buttons) do
    local sprite = Sprite(0, 0, 1, 1, G.ASSET_ATLAS["kh_KHExternalTags"], tag.pos)

    sprite.states.collide.can = true

    function sprite:click()
      play_sound('button', 1, 0.3)
      G.FUNCS[tag.button]()
    end

    function sprite:hover()
      sprite:juice_up(0.05, 0.03)
      play_sound('paper1', math.random() * 0.2 + 0.9, 0.35)
      Node.hover(self)
    end

    function sprite:stop_hover()
      Node.stop_hover(self)
    end

    tag_nodes[#tag_nodes + 1] = {
      n = G.UIT.C,
      config = {
        align = "cm",
        padding = 0.05,
        colour = G.C.CLEAR,
        hover = true,
        shadow = true,
      },
      nodes = {
        {
          n = G.UIT.R,
          config = { align = "cm" },
          nodes = {
            {
              n = G.UIT.O,
              config = {
                object = sprite,
                tooltip = {
                  title = tag.tooltip,
                },
              },
            },
          },
        },
      },
    }
  end

  modNodes[#modNodes + 1] = {
    n = G.UIT.R,
    config = { align = "cm", padding = 0.05 },
    nodes = tag_nodes
  }
end
function G.FUNCS.kh_github_page(e)
  love.system.openURL("https://github.com/cloudzXIII/FinalMix")
end

function G.FUNCS.kh_wiki_page(e)
  love.system.openURL("https://balatromods.miraheze.org/wiki/Final_Mix")
end

function G.FUNCS.kh_discord_page(e)
  love.system.openURL("https://discord.com/channels/1116389027176787968/1402215484333756496")
end

function G.FUNCS.kh_kofi_page(e)
  love.system.openURL("https://ko-fi.com/cloudzxiii")
end

MIX.add_new_config_option = function(args)
  -- args.ref_table / args.ref_value for config option
  -- args.label for text

  return {
    n = G.UIT.R,
    config = { align = "cl", padding = 0 },
    nodes = {
      {
        n = G.UIT.C,
        config = { align = "cl", padding = 0.05 },
        nodes = {
          create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = args.ref_table or KH.config, ref_value = args.ref_value, id = args.ref_value },
        }
      },
      {
        n = G.UIT.C,
        config = { align = "c", padding = 0 },
        nodes = {
          { n = G.UIT.T, config = { text = args.label, scale = 0.45, colour = G.C.UI.TEXT_LIGHT } },
        }
      },
    }
  }
end

-- Config Tab
KH.config_tab = function()
  local title_text = DynaText({
    string = localize("k_kh_settings"),
    colours = { G.C.WHITE },
    shadow = true,
    float = true,
    silent = true,
    spacing = 5,
    scale = 1.2,
    rotate = true,
    pop_in = 0,
  })
  title_text.states.visible = false

  return {
    n = G.UIT.ROOT,
    config = { align = "m", r = 0.1, padding = 0.1, colour = G.C.BLACK, minw = 8, minh = 6 },
    nodes = {
      { n = G.UIT.R, config = { align = "cl", padding = 0, minh = 0.1 }, nodes = {} },

      {
        n = G.UIT.R,
        config = { align = "cm" },
        nodes = {
          { n = G.UIT.O, config = { object = title_text } },
          { n = G.UIT.B, config = { w = 0.1, h = 2.5 } },
        }
      },


      MIX.add_new_config_option {
        ref_value = "enable_custom_main_menu",
        label = localize("k_kh_config_enable_custom_main_menu")
      },
      MIX.add_new_config_option {
        ref_value = "menu_toggle",
        label = localize("k_kh_config_menu_toggle")
      },
      MIX.add_new_config_option {
        ref_value = "disable_flavour",
        label = localize("k_kh_config_disable_flavour")
      },
      MIX.add_new_config_option {
        ref_value = "artless_jokers",
        label = localize("k_kh_config_artless_jokers")
      },

      {
        n = G.UIT.R,
        config = { align = "cm", padding = 0.5 },
        nodes = {
          { n = G.UIT.T, config = { text = localize('kh_requires_restart'), scale = 0.40, colour = G.C.UI.TEXT_LIGHT } },
        }
      },

    }
  }
end
