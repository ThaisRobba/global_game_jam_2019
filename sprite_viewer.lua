window =
    am.window {
    width = 920,
    height = 920,
    title = "Sprite Viewer"
}

local touch_area = require "components.touch_area"

local function animated_sprite(dir, animation, loop)
    local file = am.load_string(animation)
    local config = am.parse_json(file)
    local frames = config.frames

    if not frames then
        return am.text("Missing the list of frames for the sprite.\nBe sure to check the .json file! :)")
    end

    if not frames[1].source then
        return am.text("Missing source field for the sprite.\nBe sure to check the .json file! :)")
    end

    local node = am.sprite(dir .. frames[1].source .. ".png"):tag("animated_sprite")

    local dt = 0
    local current_frame = 1
    local current_time = frames[current_frame].time or 1
    local loop = config.loop or loop

    node:action(
        "animation",
        function()
            dt = dt + am.delta_time

            if dt >= current_time then
                current_frame = current_frame + 1
                dt = 0

                if current_frame > #frames then
                    if loop then
                        current_frame = 1
                    else
                        return true
                    end
                else
                    node.source = dir .. frames[current_frame].source .. ".png"
                    current_time = frames[current_frame].time
                end
            end
        end
    )

    return node
end

local function create_button(dir, animation)
    local node =
        touch_area(-100, -14, 100, 14) ^
        am.group {
            am.rect(-100, -14, 100, 14, vec4(0.6, 0.2, 0.2, 1)),
            am.text(string.sub(animation, 8))
        }

    function node:released()
        window.scene:remove("animated_sprite")
        window.scene("title").text = "Playing: " .. string.sub(animation, 8)
        window.scene:append(animated_sprite(dir, animation))
    end

    return node
end

local buttons = {}
for i, dir in ipairs(am.glob {"assets/*"}) do
    if dir ~= "." and dir ~= ".." then
        for j, animation in ipairs(am.glob {dir .. "*.json"}) do
            print(_, file)
            table.insert(
                buttons,
                am.translate(window.left + 100, window.top - (i + j - 1) * 32) ^ create_button(dir, animation)
            )
        end
    end
end

window.scene =
    am.group {
    am.group(buttons),
    am.translate(0, window.top - 12) ^ am.text("Select an animation"):tag("title")
}
