local state = require "state"

------

local food_counter = require "components.food_counter"
local customer = require "components.customer"
local grub = require "components.grub"
local speech_bubble = require "components.speech_bubble"
local clickable_speech_bubble = require "components.clickable_speech_bubble"
local touch_blocker = require "components.touch_blocker"

------

local function get_step_dialog(step)
    return state.current.current_customer.story[step].str
end

local function spawn_speech_bubble(node)
    local current_step = state.current.current_step

    node:remove("speech_bubble")

    if current_step % 2 == 0 then
        node("speech_bubble_area"):append(
            clickable_speech_bubble(
                get_step_dialog(current_step),
                function()
                    state:dispatch("next_step")
                end
            )
        )
        node("touch_blocker").allow_propagation = true
    elseif current_step == 7 then
        node("touch_blocker").allow_propagation = false
        local credits =
            am.group {
            am.rect(window.left, window.bottom, window.right, window.top, vec4(0, 0, 0, 0.5)),
            am.sprite("assets/ui/credits.png", vec4(1, 1, 1, 0))
        }

        node:append(credits)
        credits("rect"):action(
            am.tween(
                1,
                {
                    color = vec4(0, 0, 0, 1)
                }
            )
        )
        credits("sprite"):action(
            am.tween(
                1,
                {
                    color = vec4(1, 1, 1, 1)
                }
            )
        )
    else
        node("speech_bubble_area"):append(speech_bubble(get_step_dialog(current_step)))
        node("touch_blocker").allow_propagation = true
    end
end

------

local item_grid_offset = vec2(-430, -150)
local customer_offset = vec2(500, 250)
local speech_bubble_offset = vec2(-325, 300)

local function restaurant()
    local node =
        am.group {
        am.translate(0, 280) ^ am.sprite("assets/restaurant/background.png"):tag("background"),
        am.translate(customer_offset):tag("character_area"),
        am.translate(item_grid_offset) ^ food_counter(),
        am.translate(speech_bubble_offset):tag("speech_bubble_area"),
        touch_blocker(),
        grub()
    }

    node("character_area"):append(customer("mister_pig")) --this wouldn't be hardcoded for multi customers

    local current_step = state.current.current_step

    state:on(
        "next_step",
        node,
        function()
            current_step = state.current.current_step

            spawn_speech_bubble(node)
        end
    )

    state:on(
        "select_ingredient",
        node,
        function()
            if state.current.current_step ~= current_step then
                current_step = state.current.current_step
                spawn_speech_bubble(node)
            end

            if #state.current.selected_ingredients == 0 then
                for _, child in pairs(node:all("ingredient")) do
                    child.hidden = false
                    node("grub").hidden = true
                end
            else
                node("grub").hidden = false
            end
        end
    )

    return node
end

return restaurant
