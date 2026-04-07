KH.C = {
	BG_COLOUR = HEX("3e4960"),

	TAB_BUTTON = HEX("c8a237"),

	COLLECTION_OPTION = HEX("c8a237"),

	OUTLINE = HEX("EAF4FF"),
}

KH.ui_config = {
	colour = KH.C.BG_COLOUR,

	tab_button_colour = KH.C.TAB_BUTTON,
	back_colour = KH.C.TAB_BUTTON,
	collection_back_colour = KH.C.TAB_BUTTON,

	collection_option_cycle_colour = KH.C.COLLECTION_OPTION,

	outline_colour = KH.C.OUTLINE,
	collection_outline_colour = KH.C.OUTLINE,
}

local function button_with_tooltip(args)
	local button = UIBox_button(args)
	if args.tooltip then
		button.nodes[1].config.tooltip = {
			title = args.label and args.label[1] or "",
			text = { args.tooltip },
		}
	end
	return button
end

KH.custom_ui = function(modNodes)
	table.remove(modNodes, 1)
	table.remove(modNodes, 1)

	-- Title
	local title_text = DynaText({
		string = "Final Mix",
		colours = { SMODS.Gradients.kh_title },
		shadow = true,
		float = true,
		silent = true,
		spacing = 5,
		scale = 1.3,
		rotate = true,
		pop_in = 0,
		text_effect = "kh_pulse",
	})
	title_text.states.visible = false

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
							object = title_text,
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

	local kh_jokers = MIX.get_resource_with_prefix("j_kh")
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
	modNodes[#modNodes + 1] = {
		n = G.UIT.R,
		config = { align = "cm", padding = 0.05 },
		nodes = {
			button_with_tooltip({
				colour = KH.C.TAB_BUTTON,
				button = "kh_wiki_page",
				label = { localize("b_kh_wiki_page") },
				minw = 4.75,
				col = true,
				tooltip = ":D",
			}),
			button_with_tooltip({
				colour = KH.C.TAB_BUTTON,
				button = "kh_website_page",
				label = { localize("b_kh_website_page") },
				minw = 4.75,
				col = true,
				tooltip = "Check out my stuff!",
			}),
		},
	}
end

function G.FUNCS.kh_wiki_page(e)
	love.system.openURL("https://balatromods.miraheze.org/wiki/Final_Mix")
end

function G.FUNCS.kh_website_page(e)
	love.system.openURL("https://cloudzxiii.github.io/")
end

local function add_new_config_option(args)
	args.type = args.type or "R"
	return {
		n = G.UIT[args.type],
		config = { r = 0.1, minw = 4, align = "tm", padding = 0.2, colour = G.C.BLACK },
		nodes = {
			{
				n = G.UIT.R,
				config = {
					align = "cm",
					r = 0.1,
					emboss = 0.1,
					outline = 1,
					padding = 0.14,
				},
				nodes = {
					create_toggle({
						id = args.id,
						ref_table = KH.config,
						ref_value = args.id,
						label = localize(args.label),
						info = {
							G.localization.misc.dictionary[args.info],
						},
					}),
				},
			},
		},
	}
end
-- Config Tab
KH.config_tab = function()
	return {
		n = G.UIT.ROOT,
		config = { r = 0.1, minw = 4, align = "tm", padding = 0.2, colour = G.C.BLACK },
		nodes = {
			{
				n = G.UIT.R,
				config = { colour = G.C.BLACK, padding = 0.1, align = "cm", minw = 4, minh = 1, r = 0.1 },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = "CONFIG OPTIONS",
							colour = G.C.DARK_EDITION,
							scale = 1,
							padding = 0.1,
							align = "cm",
						},
					},
				},
			},
			add_new_config_option({ id = "menu_toggle", label = "k_kh_config_menu_toggle", info = "k_kh_menu_toggle" }),
			{
				n = G.UIT.R,
				config = { padding = 0.1, align = "cm" },
				nodes = {
					{
						n = G.UIT.T,
						config = {
							text = "(requires restart to apply changes)",
							colour = G.C.UI.TEXT_INACTIVE,
							scale = 0.4,
							padding = 0.1,
							align = "cm",
						},
					},
				},
			},
		},
	}
end

-- Crossmod Tab
KH.crossmod_tab = function()
	local title_text = DynaText({
		string = "Final Mix",
		colours = { SMODS.Gradients.kh_title },
		shadow = true,
		float = true,
		silent = true,
		spacing = 5,
		scale = 1.3,
		rotate = true,
		pop_in = 0,
		text_effect = "kh_pulse",
	})
	local title_text_2 = DynaText({
		string = "CROSSMOD",
		colours = { G.C.DARK_EDITION },
		shadow = true,
		float = true,
		silent = true,
		spacing = 5,
		scale = 1.3,
		rotate = true,
		pop_in = 0,
		text_effect = "kh_pulse",
	})
	return {
		n = G.UIT.ROOT,
		config = {
			r = 0.1,
			minw = 7,
			align = "cm",
			padding = 0.2,
			colour = G.C.BLACK,
		},
		nodes = {
			{
				n = G.UIT.R,
				config = {
					align = "cm",
					padding = 0.2,
				},
				nodes = {
					button_with_tooltip({
						minw = 3.85,
						colour = G.C.GREEN,
						button = "kh_joker_display",
						label = { "JokerDisplay" },
						tooltip = ":D",
						col = true,
					}),
					button_with_tooltip({
						minw = 3.85,
						colour = G.C.CHIPS,
						button = "kh_card_sleeves",
						label = { "CardSleeves" },
						tooltip = "1 new Sleeve!",
						col = true,
					}),
					button_with_tooltip({
						minw = 3.85,
						colour = HEX("990000"),
						button = "kh_ortalab",
						label = { "Ortalab" },
						tooltip = "1 new Joker!",
						col = true,
					}),
				},
			},
			{
				n = G.UIT.R,
				config = { padding = 0.1, align = "cm" },
				nodes = {
					{
						n = G.UIT.O,
						config = {
							align = "cm",
							object = title_text,
						},
					},
				},
			},
			{
				n = G.UIT.R,
				config = { padding = 0.1, align = "cm" },
				nodes = {
					{
						n = G.UIT.O,
						config = {
							align = "cm",
							object = title_text_2,
						},
					},
				},
			},
			{
				n = G.UIT.R,
				config = {
					align = "cm",
					padding = 0.2,
				},
				nodes = {
					button_with_tooltip({
						minw = 3.85,
						colour = G.C.PURPLE,
						button = "kh_partner_api",
						label = { "Partner API" },
						tooltip = "5 new Partners!",
						col = true,
					}),
					button_with_tooltip({
						minw = 3.85,
						colour = HEX("3F6AA4"),
						button = "kh_blindside",
						label = { "Blindside (coming soon)" },
						tooltip = "3 Blinds + 1 Joker!",
						col = true,
					}),
				},
			},
		},
	}
end

KH.extra_tabs = function()
	return {
		label = "Crossmod",
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

G.FUNCS.kh_blindside = function(e)
	love.system.openURL("https://github.com/LunaAstraCassiopeia/Blindside")
end

G.FUNCS.kh_ortalab = function(e)
	love.system.openURL("https://github.com/EremelMods/Ortalab")
end
