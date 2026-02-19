KH.C = {
    PRIMARY = HEX('5973B2'),
    BACKGROUND = HEX('F2CC99'),
    TAB_BUTTON = HEX('334362'),
    OUTLINE = HEX('F8F8FA'),
    AUTHOR_TEXT = HEX('F2E6BF'),
    AUTHOR_BG = HEX('404D80'),
    AUTHOR_OUTLINE = HEX('E6D9B3'),
    COLLECTION_BACK = HEX('F2CC99'),
    COLLECTION_OUTLINE = HEX('F8F8FA'),
    COLLECTION_OPTION = HEX('334362'),
}

SMODS.current_mod.ui_config = {
    colour = KH.C.PRIMARY,
    back_colour = KH.C.BACKGROUND,
    tab_button_colour = KH.C.TAB_BUTTON,
    outline_colour = KH.C.OUTLINE,
    author_colour = KH.C.AUTHOR_TEXT,
    author_bg_colour = KH.C.AUTHOR_BG,
    author_outline_colour = KH.C.AUTHOR_OUTLINE,
    collection_back_colour = KH.C.COLLECTION_BACK,
    collection_outline_colour = KH.C.COLLECTION_OUTLINE,
    collection_option_cycle_colour = KH.C.COLLECTION_OPTION,
}

-- Adds cards to mod page, credits to N' who made JoyousSpring, check them out!
KH.custom_ui = function(modNodes)
    local logo = {

        n = G.UIT.R,
        config = {
            align = 'cm',
            colour = { 0, 0, 0, 0 },
            r = 0.3,
            padding = 0.25
        },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = 'cm' },
                nodes = {
                    {
                        n = G.UIT.O,
                        config = {
                            object = SMODS.create_sprite(
                                0, 0,
                                6.5, 4.5,
                                'kh_modlogo',
                                { x = 0, y = 0 }
                            )
                        }
                    }
                }
            }
        }
    }
    table.insert(modNodes, 2, logo)

    -- Wiki Link
    modNodes[#modNodes + 1] = {
        n = G.UIT.R,
        config = { align = "bm", padding = 0.05 },
        nodes = {
            {
                n = G.UIT.C,
                config = { align = "cm", padding = 0.05 },
                nodes = {
                    UIBox_button({
                        colour = G.C.RED,
                        button = "kh_wiki_page",
                        label = { localize("b_kh_wiki_page") },
                        minw = 4.75,
                    }),
                },
            },
            {
                n = G.UIT.C,
                config = { align = "cm", padding = 0.05 },
                nodes = {
                    UIBox_button({
                        colour = G.C.RED,
                        button = "kh_website_page",
                        label = { localize("b_kh_website_page") },
                        minw = 4.75,
                    }),
                },
            },
        },
    }
end

function G.FUNCS.kh_wiki_page(e)
    love.system.openURL("https://balatromods.miraheze.org/wiki/Final_Mix")
end

function G.FUNCS.kh_website_page(e)
    love.system.openURL("https://cloudzxiii.github.io/")
end

-- Config Tab
KH.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = { r = 0.1, minw = 7, align = "tm", padding = 0.1, colour = G.C.BLACK },
        nodes = {
            {
                n = G.UIT.R,
                config = { colour = G.C.BLACK, padding = 0.1, align = "cm", minw = 4, minh = 1, r = 0.1 },
                nodes = {
                    { n = G.UIT.T, config = { text = "FINAL MIX ", colour = G.C.UI_CHIPS, scale = 1, padding = 0.1, align = "cm" } },
                }
            },
            {
                n = G.UIT.R,
                config = { colour = G.C.BLACK, padding = 0.1, align = "cm", minw = 4, minh = 1, r = 0.1 },
                nodes = {
                    { n = G.UIT.T, config = { text = "CONFIG", colour = G.C.DARK_EDITION, scale = 1, padding = 0.1, align = "cm" } }
                }
            },
            {
                n = G.UIT.R,
                config = { r = 0.1, minw = 3, align = "tm", padding = 0.2, colour = G.C.BLACK },
                nodes = {
                    create_toggle({
                        id = "menu_toggle",
                        ref_table = KH.config,
                        ref_value = "menu_toggle",
                        label = localize("k_finalmix_config_menu_toggle"),
                    }),
                }
            },
            {
                n = G.UIT.R,
                config = { padding = 0.1, align = "cm" },
                nodes = {
                    { n = G.UIT.T, config = { text = "(requires restart to apply changes)", colour = G.C.UI.TEXT_INACTIVE, scale = 0.4, padding = 0.1, align = "cm" } }
                }
            }
        }
    }
end
-- Crossmod Tab
KH.crossmod_tab = function()
    return {
        n = G.UIT.ROOT,
        config = {
            r = 0.1,
            minw = 7,
            align = "cm",
            padding = 0.2,
            colour = G.C.BLACK
        },
        nodes = {
            {
                n = G.UIT.R,
                config = { colour = G.C.BLACK, padding = 0.1, align = "cm", minw = 4, minh = 1, r = 0.1 },
                nodes = {
                    { n = G.UIT.T, config = { text = "FINAL MIX", colour = G.C.UI_CHIPS, scale = 1, padding = 0.1, align = "cm" } }
                }
            },
            {
                n = G.UIT.C,
                config = {
                    align = "cm",
                    padding = 0.2
                },
                nodes = {
                    UIBox_button({
                        minw = 3.85,
                        colour = G.C.GREEN,
                        button = "kh_joker_display",
                        label = { "JokerDisplay" }
                    }),
                    UIBox_button({
                        minw = 3.85,
                        colour = G.C.CHIPS,
                        button = "kh_card_sleeves",
                        label = { "CardSleeves" }
                    }),
                }
            },
            {
                n = G.UIT.R,
                config = { colour = G.C.BLACK, padding = 0.1, align = "cm", minw = 4, minh = 1, r = 0.1 },
                nodes = {
                    { n = G.UIT.T, config = { text = "CROSSMOD", colour = G.C.DARK_EDITION, scale = 1, padding = 0.1, align = "cm" } }
                }
            },
            {
                n = G.UIT.R,
                config = {
                    align = "cm",
                    padding = 0.2
                },
                nodes = {
                    UIBox_button({
                        minw = 3.85,
                        colour = G.C.PURPLE,
                        button = "kh_partner_api",
                        label = { "Partner API" }
                    }),
                    UIBox_button({
                        minw = 3.85,
                        colour = HEX("3F6AA4"),
                        button = "kh_blindside",
                        label = { "Blindside (coming soon)" }
                    }),
                }
            },
        }
    }
end

KH.extra_tabs = function()
    return {
        label = "Crossmod",
        tab_definition_function = KH.crossmod_tab,
    };
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

G.FUNCS.kh_blindside = function(e)
    love.system.openURL("https://github.com/LunaAstraCassiopeia/Blindside")
end
