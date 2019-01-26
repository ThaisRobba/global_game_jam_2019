local state = require "state"

-------

local function customer(customer_name)
    local filepath = string.format("data/customers/%s.json", customer_name)
    local file = am.load_string(filepath)
    local config = am.parse_json(file)

    local node = am.translate(0, 0) ^ am.scale(0.8) ^ am.sprite(config.sprite, vec4(0, 0, 0, 1))

    node("translate"):action(
        am.series {
            am.tween(0.5, {y = -20}, am.ease.quadratic),
            am.tween(0.5, {y = 0}, am.ease.quadratic),
            am.tween(0.5, {y = -20}, am.ease.quadratic),
            am.tween(0.5, {y = 0}, am.ease.quadratic)
        }
    )

    node("sprite"):action(
        am.tween(
            1.9,
            {
                color = vec4(1)
            }
        )
    )

    node("scale"):action(
        am.tween(
            1.9,
            {
                scale2d = vec2(1)
            }
        )
    )

    state:dispatch("set_customer", config)

    return node
end

return customer
