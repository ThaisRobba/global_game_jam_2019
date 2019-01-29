local touch_area = require "components.touch_area"
local state = require "state"

local function get_ingredient_config(id)
    local ingredients_list = am.parse_json(am.load_string("data/ingredients/index.json"))

    local ingredient_name = ingredients_list[id]

    return am.parse_json(am.load_string(string.format("data/ingredients/%s.json", ingredient_name)))
end

local function ingredient(id, offset)
    local node = am.translate(offset.x, offset.y)

    -------

    local config = get_ingredient_config(id)

    -------

    local sprite = am.sprite(config.sprite)
    node:append(sprite)

    local input_area = touch_area(-sprite.width / 2, -sprite.height / 2, sprite.width / 2, sprite.height / 2)

    input_area.released = function()
        if table.search(state.current.selected_ingredients, id) then
            -- TODO: play negative animation
        else
            -- TODO: play positive animation
            node.hidden = true
            state:dispatch("select_ingredient", id)
        end
    end

    node:append(input_area)
    node:tag("ingredient")

    return node
end

return ingredient
