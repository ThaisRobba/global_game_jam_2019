local speech_bubble = require "components.speech_bubble"
local touch_area = require "components.touch_area"

local function clickable_speech_bubble(str, callback)
    local node = touch_area(window.left * 2, window.bottom * 2, window.right * 2, window.top * 2)
    node.released = callback
    node.allow_propagation = false

    node:append(speech_bubble(str))
    node("speech_bubble"):append(am.translate(400, -100):tag("arrow") ^ am.sprite("assets/ui/arrow.png"))
    node("arrow"):action(
        am.series {
            am.tween(
                1,
                {
                    x = 410
                }
            ),
            am.tween(
                1,
                {
                    x = 400
                }
            ),
            am.tween(
                1,
                {
                    x = 410
                }
            ),
            am.tween(
                1,
                {
                    x = 400
                }
            )
        }
    )
    node:tag("speech_bubble")

    return node
end

return clickable_speech_bubble
