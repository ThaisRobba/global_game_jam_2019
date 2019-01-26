local touch_area = require "components.touch_area"
local state = require "state"

local function ingredient(id, offset)
    local node = am.translate(offset.x, offset.y)

    -------

    local filepath = string.format("data/ingredients/%02.0f.json", id)
    local file = am.load_string(filepath)
    local config = am.parse_json(file)

    -------

    local sprite = am.sprite(config.sprite)
    node:append(sprite)

    local input_area = touch_area(-sprite.width / 2, -sprite.height / 2, sprite.width / 2, sprite.height / 2)
    input_area.released = function()
        if table.search(state.current.selected_tags, id) then
            -- play negative animation
            log("already added!")
        else
            -- play positive animation
            log("Added %d", id)
            state:dispatch("select_tag", id)
        end
    end

    node:append(input_area)
    node:append(am.rect(-sprite.width / 2, -sprite.height / 2, sprite.width / 2, sprite.height / 2))

    return node
end

return ingredient
