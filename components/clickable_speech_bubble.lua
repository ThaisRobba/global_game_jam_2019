local speech_bubble = require "components.speech_bubble"
local touch_area = require "components.touch_area"

local function clickable_speech_bubble(str, callback)
    local node = touch_area(window.left, window.bottom, window.right, window.top)
    node.released = callback

    node:append(speech_bubble(str))
    node:tag("speech_bubble")

    return node
end

return clickable_speech_bubble
