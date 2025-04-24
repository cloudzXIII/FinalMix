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
for _, file in ipairs{"kingdomheartsxbalatro.lua"} do -- can add anything else here if needed e.g. , "mickeyxbalatro.lua"
	assert(SMODS.load_file("content/collabs/"..file))()
end

-- Decks
SMODS.Back {
	key = "KHDeck",
	loc_txt = {
		name = "Organisation XIII Deck",
		text = {
		"Start run with",
		"{C:attention}26{} {C:hearts}Hearts{} and",
		"{C:attention}26{} {C:diamonds}Diamonds{} in deck",
		"Start with {T:j_kingdomhearts_nobody}Nobody{}",
		"{C:red}+1{} hand size {C:red}+1{} discard",
			}
				},

	config = {discards = 2,  hand_size = 1,},
	pos = { x = 1, y = 3},
	
	apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
			
				SMODS.add_card { key = 'j_kingdomhearts_nobody' }
			--[[	for _, card in ipairs(G.playing_cards) do
					
					if card:is_suit("Clubs") then
						assert(SMODS.change_base(card, "Hearts"))
					end
					if card:is_suit("Spades") then
						assert(SMODS.change_base(card, "Diamonds"))
					end
				end
			]]
			return true
		   end
		}))
	end
}
