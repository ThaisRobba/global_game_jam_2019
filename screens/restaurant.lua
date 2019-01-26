local state = require "state"

------

local ingredient = require "components.ingredient"
local customer = require "components.customer"
local speech_bubble = require "components.speech_bubble"

------

local item_grid_offset = vec2(-430, -150)
local customer_offset = vec2(400, 160)
local speech_bubble_offset = vec2(-150, 200)

local function restaurant()
    local node =
        am.group {
        am.sprite("assets/restaurant/background.jpeg"):tag("background"),
        am.translate(customer_offset):tag("character_area"),
        am.translate(item_grid_offset):tag("ingredients_area"),
        am.translate(speech_bubble_offset):tag("speech_bubble_area")
    }

    for i = 1, 10 do
        local row = i > 5 and 2 or 1
        local y_offset = (row - 1) * -125
        local x_offset = (row - 1) * -32
        local x_offset_multiplier = 146

        if i > 5 then
            x_offset = x_offset + (i - 6) * (x_offset_multiplier + 10)
        else
            x_offset = x_offset + (i - 1) * x_offset_multiplier
        end

        node("ingredients_area"):append(ingredient(i, vec2(x_offset, y_offset)))
    end

    node("character_area"):append(customer("mysterious_stranger")) --this wouldn't be hardcoded for multi customers

    local current_step = state.current.current_step

    state:on(
        "select_tag",
        node,
        function()
            if state.current.current_step ~= current_step then
                current_step = state.current.current_step
            -- we want to trigger the answer speech bubble and queue the other speech bubble
            end
        end
    )

    return node
end

return restaurant
