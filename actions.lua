local function target_has_all_tags(target, tags)
    log(table.tostring(target))
    for key, required in pairs(target) do
        log("checking... %s, %s", key, required)
        if required and not tags[key] then
            return false
        end
    end

    return true
end

--[[ Actions receive the current state and in some cases, a payload ]]
return {
    set_customer = function(state, payload)
        state.current_customer = payload
    end,
    select_tag = function(state, payload)
        local selected_tags = state.selected_tags

        table.insert(selected_tags, payload)

        local current_customer, customer_tags
        if #selected_tags >= 2 then
            current_customer = state.current_customer
            customer_tags = current_customer.story[state.current_step].tags
        end

        if customer_tags and target_has_all_tags(customer_tags, selected_tags) then
            table.clear(selected_tags)

            state.current_step = state.current_step + 1
            log("New step!")

            if state.current_step > 3 then
                -- custcene or something
                state.day_completed = true
            end
        end
    end
}
