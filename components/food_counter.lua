local ingredient = require "components.ingredient"

local function food_counter()
    local node =
        am.group {
        am.translate(430, -70) ^ am.sprite("assets/restaurant/counter.png")
    }

    for i = 1, 10 do
        local row = i > 5 and 2 or 1
        local y_offset = (row - 1) * -188 - 16
        local x_offset = (row - 1) * -32 - 228
        local x_offset_multiplier = 224

        if i > 5 then
            x_offset = x_offset + (i - 6) * (x_offset_multiplier + 10)
        else
            x_offset = x_offset + (i - 1) * x_offset_multiplier
        end

        node:append(ingredient(i, vec2(x_offset, y_offset)))
    end

    return node
end

return food_counter
