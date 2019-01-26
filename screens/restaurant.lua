local state = require "state"

------

local food_counter = require "components.food_counter"
local customer = require "components.customer"
local speech_bubble = require "components.speech_bubble"
local touch_blocker = require "components.touch_blocker"

------

local item_grid_offset = vec2(-430, -150)
local customer_offset = vec2(400, 160)
local speech_bubble_offset = vec2(-150, 200)

local function restaurant()
    local node =
        am.group {
        am.translate(0, 280) ^ am.sprite("assets/restaurant/background.png"):tag("background"),
        am.translate(customer_offset):tag("character_area"),
        am.translate(item_grid_offset) ^ food_counter(),
        am.translate(speech_bubble_offset):tag("speech_bubble_area")
        -- touch_blocker()
    }

    node("character_area"):append(customer("mister_pig")) --this wouldn't be hardcoded for multi customers

    local current_step = state.current.current_step

    state:on(
        "select_tag",
        node,
        function()
            if state.current.current_step ~= current_step then
                current_step = state.current.current_step
            -- we want to trigger the answer speech bubble and queue the other speech bubble
            -- How should we go about this?
            -- speech_bubble with caret
            -- on click, close, open new speech_bubble without caret
            -- speech_bubble with
            end
        end
    )

    return node
end

return restaurant
