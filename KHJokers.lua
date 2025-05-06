SMODS.Atlas {
    key = "modicon",
    path = "mod_icon.png",
    px = 34,
    py = 34,
}

SMODS.Atlas {
    key = "KHJokers",
    path = "KHJokers.png",
    px = 71,
    py = 95,
}


-- load all individual jokers
local subdir = "content/cards"
local cards = NFS.getDirectoryItems(SMODS.current_mod.path .. subdir)
for _, filename in pairs(cards) do
    assert(SMODS.load_file(subdir .. "/" .. filename))()
end


-- load Friends of Jimbo
for _, file in ipairs{"kingdomheartsxbalatro.lua"} do -- can add anything else here if needed e.g.`` , "mickeyxbalatro.lua" ``
	assert(SMODS.load_file("content/collabs/"..file))()
end

-- consumables
for _, file in ipairs{"tarots.lua"} do -- can add anything else here if needed e.g. , "spectrals.lua"
	assert(SMODS.load_file("content/consumables/"..file))()
end




-- Decks
SMODS.Back {
	key = "KHDeck",
	loc_txt = {
		name = "Organisation XIII Deck",
		text = {
		"Start run with",
		"{C:attention}52{} {C:hearts}Hearts{} in deck",
		--"in deck",
		"Start with {T:j_kingdomhearts_nobody}Nobody{}",
		"{C:red}-2{} hand size",
			}
				},

	config = {hand_size = -2,},
	pos = { x = 1, y = 3},
	
	apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
			
				SMODS.add_card { key = 'j_kingdomhearts_nobody' }
				for _, card in ipairs(G.playing_cards) do
					
					if card:is_suit("Clubs") then
						assert(SMODS.change_base(card, "Hearts"))
					end
					if card:is_suit("Spades") then
						assert(SMODS.change_base(card, "Hearts"))
					end
					if card:is_suit("Diamonds") then
						assert(SMODS.change_base(card, "Hearts"))
				end
			end
			return true
			
			end
		}))
	end
}
