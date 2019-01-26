local ingredient = require "components.ingredient"

local item_grid_offset = vec2(-430, -150)
--[[
    second row has different offset
    local second_row_offset = vec2(-430, -150)
]]
local function restaurant()
    local node =
        am.group {
        am.scale(1) ^ am.sprite("assets/restaurant/background.jpeg"),
        am.translate(item_grid_offset):tag("ingredients_area")
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

    return node
end

return restaurant
