-- Function to get a Joker by its unique key from a list of Jokers.
local function getJokerByKey(jokers, key)
    -- Iterate over all Jokers in the provided list
    for _, joker in ipairs(jokers) do
        -- Check if the current Joker's key matches the given key
        if joker.config.center.key == key then
            -- If found, return the Joker
            return joker
        end
    end
    -- Return nil if no matching Joker is found
    return nil
end

SMODS.Joker {
    key = 'donald',
    loc_txt = {
        name = 'Donald Duck',
        text = {
            "Copies the ability of a",
            "{C:attention}random Joker{} each round.",
            "{C:inactive}(Currently copying: {C:attention}#1#{C:inactive})",
			"{C:inactive,s:0.8} SORAAAAA"
        }
    },

    -- Function to get the localized variables to display on screen
    loc_vars = function(self, info_queue, card)
        -- Fetch the key of the Joker that this card is currently copying
        local copied_joker_key = card.ability.extra.copied_joker_key
        -- Default name in case no Joker is copied
        local copied_name = "None"
        
        -- If the global list of Jokers exists
        if G.jokers then
            -- Look for the Joker that matches the copied key
            local copied_joker = getJokerByKey(G.jokers.cards, copied_joker_key)
            -- If a match is found, update the copied_name
            if copied_joker then
                copied_name = copied_joker.config.center.name
            end
        end
        
        -- Return the name of the copied Joker (or "None" if not copied)
        return { vars = { copied_name } }
    end,

    rarity = 3,
    atlas = 'KHJokers',
    pos = { x = 4, y = 0 },
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,

    config = {
        extra = { copied_joker_key = nil }  -- No Joker is copied at the start
    },

    -- Function to update the state of the Joker during the game
    update = function(self, card, dt)
        -- Fetch the current copied Joker's key
        local copied_joker_key = card.ability.extra.copied_joker_key
        -- Variable to track if the copied Joker is compatible with the blueprint system
        local is_compatible = false
        
        -- If the global list of Jokers exists
        if G.jokers then
            -- Look for the Joker that matches the copied key
            local copied_joker = getJokerByKey(G.jokers.cards, copied_joker_key)
			
            -- If a match is found, check if it's compatible with the blueprint
            if copied_joker then
                is_compatible = copied_joker.config.center.blueprint_compat
            end
        end
        
        -- Update the card's ability to reflect whether the Joker is compatible or not
        card.ability.blueprint_compat = is_compatible and 'compatible' or 'incompatible'
    end,


    calculate = function(self, card, context)
        -- Checks if blind has started and there is more than 1 joker in slots
        if context.setting_blind and not context.blueprint and G.jokers and #G.jokers.cards > 1 then
            -- Create a list of jokers that can be copied (excluding the current card's Joker)
            local available_jokers = {}
            for _, joker in ipairs(G.jokers.cards) do
                if joker ~= card then
                    table.insert(available_jokers, joker)
                end
            end
            
            -- If there are available Jokers to choose from
            if #available_jokers > 0 then
                -- Randomly select one Joker from the available ones
                local random_joker = available_jokers[math.random(#available_jokers)]
                -- Set the selected Joker's key to be copied by the card
                card.ability.extra.copied_joker_key = random_joker.config.center.key
                -- Trigger an update to reflect this change
                card:update()
                -- Check if the selected Joker is compatible with the blueprint system
                local is_compatible = random_joker.config.center.blueprint_compat
                -- Return a message indicating whether the copied Joker is compatible or not
                return {
                    message = is_compatible and 'Copying!' or 'Incompatible!',
                    card = card,
                }
            else
                -- If no Jokers are available, reset the copied key to nil
                card.ability.extra.copied_joker_key = nil
            end
        end

        -- If a Joker is being copied and the card isn't debuffed, attempt to apply the copied Joker's effect
        if card.ability.extra.copied_joker_key and not card.debuff and G.jokers then
            -- Look for the Joker that matches the copied key
            local copied_joker = getJokerByKey(G.jokers.cards, card.ability.extra.copied_joker_key)
            -- If a match is found, attempt to apply its effect
            if copied_joker then
                -- Safely attempt to apply the Joker's blueprint effect using pcall to handle potential errors
                local success, result = pcall(SMODS.blueprint_effect, card, copied_joker, context)
                -- If successful, return the result (effect)
                if success and result then return result end
            end
        end
    end
}
