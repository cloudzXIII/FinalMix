-- value manipulation feat. Blockbuster API! thank you ice
Blockbuster.ValueManipulation.CompatStandard {
    key = "finalmix",

    -- The ID for the mod. This will make this the default for all objects in your mod, unless specified otherwise.
    -- the ID is the same as the one defined in your .json metadata
    source_mod = "kingdomhearts",
    -- Variable Conventions are naming conventions for the variables in your objects 'ability.extra' table
    -- If they match, they will NOT have their values changed
    variable_conventions = {
        -- Full vars must have the exact same name
        full_vars = {
            "pos_override", "level",
            -- for roxas
            "discards_remaining", "discards", "total_chips",
            -- for joker menu
            "pos",
            -- for everything
            "odds", "x_mult",
        },
        -- Ends on means there is a prefix that is checked
        ends_on = {
        },

        -- Starts with checks for suffixes to your variable names
        starts_with = {
        }
    },

    -- Variables that match these conventions WILL be manipulated
    -- However, they will always be rounded to the nearest integer.
    -- This is intended to be used for variables that do things like increase deck size, or generate cards, as they aren't able to generate 0.7 cards
    integer_only_variable_conventions = {
        full_vars = {
        },
        ends_on = {
        },
        starts_with = {
        },
    },

    -- Variable caps are for specific variables that you want to have a specific cap
    -- This is intended to be able to safeguard retriggers, for example. These caps are the max the value can be manipulated to
    -- NOT the maximum mult.
    variable_caps = {
        ["repetitions"] = 25, -- Alternate notation
    },

    -- These values are the extremities that can be reached. These show how far the values can be manipulated
    -- min is defaulted to 0 to prevent negative manipulation. Max = 25 means that value x 25, aka a boost of 2500% is the cap.
    min_max_values = { min = 0, max = 25 }, -- Min will be assumed to be 0 (to prevent negative values.) Max is equal to 25 by default

    -- Exempt jokers is a list of jokers that will not be compatible, and not checked at all. They must use this standard for that to matter. (Including vanilla jokers on your standard won't do anything, for example)
    -- This will not be checked if set to nil
    exempt_jokers = {
        j_kh_sealsalt = true,
        j_kh_riku = true,
        j_kh_keyblade = true,
        j_kh_donald = true,
        j_kh_gummiphone = true,
        j_kh_helpwanted = true,
        j_kh_kingdomhearts = true,
        j_kh_xehanort = true,
        j_kh_axel = true,
        j_kh_lethimcook = true,
    },

    -- redirect objects allow you to pass objects onto alternative standards. (These do not chain. You can not have a redirect object be redirected again)
    -- the first table key is the key of the compatStandard you want to go into. This contains a dictionary of objects keys
    redirect_objects = {
    },

}
