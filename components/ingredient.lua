local touch_area = require "components.touch_area"

local function ingredient(id, offset)
    local node = am.translate(offset.x, offset.y)

    -------

    local sprite_source = string.format("assets/ingredients/%02.0f.png", id)
    local sprite = am.sprite(sprite_source)
    node:append(sprite)

    local input_area = touch_area(-sprite.width / 2, -sprite.height / 2, sprite.width / 2, sprite.height / 2)
    input_area.released = function()
        print("I was clicked!", id)
    end

    node:append(input_area)

    node:append(am.rect(-sprite.width / 2, -sprite.height / 2, sprite.width / 2, sprite.height / 2))

    -------

    -- sprite asset
    -- touch_area
    -- on_release...
    --      check if ingredient is in current_ingredients
    --      if it is, play negative animation
    --      if it isn't, play positive animation, add ingredient to list (state change)
    return node
end

return ingredient
