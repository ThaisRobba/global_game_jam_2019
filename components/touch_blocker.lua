local touch_area = require "components.touch_area"

local function touch_blocker(x1, y1, x2, y2)
    local node = touch_area(x1 or window.left, y1 or window.bottom, x2 or window.right, y2 or window.top)
    node.allow_propagation = false
    node:tag("touch_blocker")

    return node
end

return touch_blocker
