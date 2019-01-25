window =
    am.window {
    width = 920,
    height = 920,
    title = "Sprite Viewer"
}

local touch_area = require "components.touch_area"
local animated_sprite = require "components.animated_sprite"

local function get_animation_name(filepath)
    return string.match(filepath, "/(%a+).json")
end

local function create_button(dir, animation)
    local node =
        touch_area(-100, -14, 100, 14) ^
        am.group {
            am.rect(-100, -14, 100, 14, vec4(0.6, 0.2, 0.2, 1)),
            am.text(dir .. animation)
        }

    function node:released()
        window.scene:remove("animated_sprite")
        window.scene("title").text = "Playing: " .. dir .. animation
        window.scene:append(animated_sprite(dir))
        window.scene("animated_sprite"):play_animation(animation, true)
    end

    return node
end

local buttons = {}
for i, dir in ipairs(am.glob {"assets/*"}) do
    if dir ~= "." and dir ~= ".." then
        for j, animation_json in ipairs(am.glob {dir .. "*.json"}) do
            local animation = get_animation_name(animation_json)

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
