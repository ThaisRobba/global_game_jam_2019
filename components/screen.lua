local function screen(initial_screen)
    local node = am.group {}

    local current_screen

    function node:set_screen(next_screen_path)
        local next_screen = require(next_screen_path)()

        node:append(next_screen)

        if current_screen then
            node:remove(current_screen)
        end

        current_screen = next_screen
        next_screen:tag("screen")
    end

    node.screen = initial_screen

    node:tag("screen_root")

    return node
end

return screen
