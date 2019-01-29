local function get_tags_from_ingredients(ids)
    local ingredient_tags = {}

    local ingredients_list = am.parse_json(am.load_string("data/ingredients/index.json"))

    for _, id in ipairs(ids) do
        local name = ingredients_list[id]
        local filepath = string.format("data/ingredients/%s.json", name)
        local file = am.load_string(filepath)
        local config = am.parse_json(file)

        for tag, has_tag in pairs(config.tags) do
            if has_tag then
                ingredient_tags[tag] = true
            end
        end
    end

    return ingredient_tags
end

local function target_tags_are_satisfied(target, tags)
    for key, required in pairs(target) do
        if required and not tags[key] then
            return false
        end
    end

    return true
end

-------

return {
    set_customer = function(state, payload)
        state.current_customer = payload
    end,
    next_step = function(state)
        state.current_step = state.current_step + 1
    end,
    select_ingredient = function(state, payload)
        local selected_ingredients = state.selected_ingredients

        table.insert(selected_ingredients, payload)

        local current_customer, customer_tags
        if #selected_ingredients >= 2 then
            current_customer = state.current_customer
            customer_tags = current_customer.story[state.current_step].tags
            local tags = get_tags_from_ingredients(selected_ingredients)

            if customer_tags and target_tags_are_satisfied(customer_tags, tags) then
                --positive feedback
                state.current_step = state.current_step + 1
            else
                --negative feedback
            end

            table.clear(selected_ingredients)
        end
    end
}
