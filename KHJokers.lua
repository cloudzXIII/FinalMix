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
local subdir = "cards"
local cards = NFS.getDirectoryItems(SMODS.current_mod.path .. subdir)
for _, filename in pairs(cards) do
    assert(SMODS.load_file(subdir .. "/" .. filename))()
end


-- config

SMODS.current_mod.config_tab = function() --Config tab
    return {
      n = G.UIT.ROOT,
      config = {
        align = "cm",
        padding = 0.05,
        colour = G.C.CLEAR,
      },
      nodes = {
	  
        create_toggle({
            label = "Does Nothing!",
        }),
		
      },
    }
end