window =
    am.window {
    width = 920,
    height = 920
}

local touch_area = require "src.components.touch_area"

local function animated_sprite(path)
    local file = am.load_string(path)
    local config = am.parse_json(file)

    if not config[1].source then
        return am.text("Missing source field for the sprite.\nBe sure to check the .json file! :)")
    end

    local node = am.sprite(config[1].source .. ".png"):tag("animated_sprite")

    local dt = 0
    local current_frame = 1
    local frames = #config

    node:action(
        "animation",
        function()
        end
    )

    return node
end

local function create_button(path)
    local node =
        touch_area(-100, -14, 100, 14) ^
        am.group {
            am.rect(-100, -14, 100, 14, vec4(0.6, 0.2, 0.2, 1)),
            am.text(path)
        }
    function node:released()
        window.scene:remove("animated_sprite")
        window.scene("title").text = "Current animation: " .. path
        window.scene:append(animated_sprite(path))
    end

    return node
end

local buttons = {}
for i, path in ipairs(am.glob {"*.json"}) do
    table.insert(buttons, am.translate(window.left + 100, window.top - i * 32) ^ create_button(path))
end

window.scene =
    am.group {
    am.group(buttons),
    am.translate(0, window.top - 12) ^ am.text("Current animation: sample.json"):tag("title"),
    animated_sprite("sample.json")
}
