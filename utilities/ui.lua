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

-- Credits to N' in JoyousSpring! Check them out! Adds cards to mod page
KH.custom_ui = function(modNodes)
    modNodes[1].nodes[1].config.colour = G.C.BLUE

    G.kh_desc_area = CardArea(
        G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2, G.ROOM.T.h,
        4.25 * G.CARD_W,
        0.95 * G.CARD_H,
        { card_limit = 5, type = 'title', highlight_limit = 0, collection = true }
    )
    for i, key in ipairs({ "j_kh_sealsalt", "j_kh_roxas", "j_kh_sora", "j_kh_riku", "j_kh_paopufruit", }) do
        local card = Card(G.kh_desc_area.T.x + G.kh_desc_area.T.w / 2, G.kh_desc_area.T.y,
            G.CARD_W, G.CARD_H, G.P_CARDS.empty,
            G.P_CENTERS[key])
        G.kh_desc_area:emplace(card)
        card:juice_up()
    end

    modNodes[#modNodes + 1] = {
        n = G.UIT.R,
        config = { align = "cm", padding = 0.07, no_fill = true },
        nodes = {
            { n = G.UIT.O, config = { object = G.kh_desc_area } }
        }
    }
end

-- Config Tab
KH.config_tab = function()
    -- Title box
    local title_box = {
        n = G.UIT.R,
        config = { colour = G.C.BLACK, padding = 0.1, align = "cm", minw = 4, minh = 1, r = 0.1 },
        nodes = {
            { n = G.UIT.T, config = { text = "KINGDOM HEARTS CONFIG", colour = G.C.UI.TEXT_DARK, scale = 1, padding = 0.1, align = "cm" } }
        }
    }

    -- Left toggles
    local left_box = {
        n = G.UIT.C,
        config = { r = 0.1, minw = 3, align = "tm", padding = 0.2, colour = G.C.BLACK },
        nodes = {
            create_toggle({
                id = "enable_jokers",
                label = localize("k_finalmix_config_jokers"),
                info = { localize('k_finalmix_config_restart') },
                ref_table = KH.config,
                ref_value = "enable_jokers",
                callback = function() KH:save_config() end
            }),
            create_toggle({
                id = "enable_tarots",
                label = localize("k_finalmix_config_tarots"),
                info = { localize('k_finalmix_config_restart') },
                ref_table = KH.config,
                ref_value = "enable_tarots",
                callback = function() KH:save_config() end
            }),
            create_toggle({
                id = "enable_spectrals",
                label = localize("k_finalmix_config_spectrals"),
                info = { localize('k_finalmix_config_restart') },
                ref_table = KH.config,
                ref_value = "enable_spectrals",
                callback = function() KH:save_config() end
            }),
            create_toggle({
                id = "enable_vouchers",
                label = localize("k_finalmix_config_vouchers"),
                info = { localize('k_finalmix_config_restart') },
                ref_table = KH.config,
                ref_value = "enable_vouchers",
                callback = function() KH:save_config() end
            }),
        }
    }

    -- Right toggles
    local right_box = {
        n = G.UIT.C,
        config = { r = 0.1, minw = 3, align = "tm", padding = 0.2, colour = G.C.BLACK },
        nodes = {
            create_toggle({
                id = "enable_seal",
                label = localize("k_finalmix_config_seal"),
                info = { localize('k_finalmix_config_restart') },
                ref_table = KH.config,
                ref_value = "enable_seal",
                callback = function() KH:save_config() end
            }),
            create_toggle({
                id = "enable_blind",
                label = localize("k_finalmix_config_blind"),
                info = { localize('k_finalmix_config_restart') },
                ref_table = KH.config,
                ref_value = "enable_blind",
                callback = function() KH:save_config() end
            }),
            create_toggle({
                id = "menu_toggle",
                ref_table = KH.config,
                ref_value = "menu_toggle",
                label = localize("k_finalmix_config_menu_toggle"),
                callback = menu_refresh
            }),
        }
    }

    local toggles_row = {
        n = G.UIT.R,
        config = { r = 0.1, minw = 7, align = "cm", padding = 0.2, colour = G.C.BLACK },
        nodes = { left_box, right_box }
    }

    return {
        n = G.UIT.ROOT,
        config = { r = 0.1, minw = 7, align = "tm", padding = 0.1, colour = G.C.BLACK },
        nodes = {
            {
                n = G.UIT.R,
                config = { r = 0.1, minw = 7, align = "cm", padding = 0.1, colour = G.C.BLACK },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { r = 0.1, minw = 7, minh = 5, align = "tm", padding = 0.2, colour = G.C.BLACK },
                        nodes = {
                            title_box,
                            toggles_row,
                        }
                    }
                }
            }
        }
    }
end
-- Crossmod Tab
G.UIDEF.kh_crossmod_tab = function()
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
                config = {
                    align = "cm",
                    padding = 0.2
                },
                nodes = {
                    UIBox_button({
                        minw = 3.85,
                        button = "kh_github",
                        colour = G.C.GOLD,
                        label = { "Final Mix Github" }
                    }),
                    UIBox_button({
                        minw = 3.85,
                        colour = G.C.ORANGE,
                        button = "kh_blockbuster_api",
                        label = { "Blockbuster API (Value Manipulation)" }
                    }),
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
                    UIBox_button({
                        minw = 3.85,
                        colour = G.C.PURPLE,
                        button = "kh_partner_api",
                        label = { "Partner API" }
                    }),
                }
            }
        }
    }
end

KH.extra_tabs = function()
    return {
        label = "Crossmod",
        tab_definition_function = G.UIDEF.kh_crossmod_tab,
    };
end


G.FUNCS.kh_github = function(e)
    love.system.openURL("https://github.com/cloudzXIII/KHJokers")
end

G.FUNCS.kh_blockbuster_api = function(e)
    love.system.openURL("https://github.com/icyethics/Blockbuster-ValueManipulation")
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
