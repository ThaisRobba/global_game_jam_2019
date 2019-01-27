local state = require "state"

-------

local function customer(customer_name)
    local filepath = string.format("data/customers/%s.json", customer_name)
    local file = am.load_string(filepath)
    local config = am.parse_json(file)

    local node = am.translate(0, 0) ^ am.scale(0.8) ^ am.sprite(config.sprite, vec4(0, 0, 0, 1))

    node("translate"):action(
        am.series {
            am.delay(0.3),
            am.tween(0.6, {y = -20}, am.ease.quadratic),
            am.tween(0.5, {y = 0}, am.ease.quadratic),
            am.tween(0.6, {y = -15}, am.ease.quadratic),
            am.tween(0.2, {y = 0}, am.ease.quadratic),
            am.delay(0.3),
            function()
                state:dispatch("next_step")
                return true
            end
        }
    )

    node("sprite"):action(
        am.series {
            am.tween(
                1,
                {
                    color = vec4(0.2, 0.2, 0.2, 1)
                }
            ),
            am.tween(
                1.2,
                {
                    color = vec4(1)
                }
            )
        }
    )

    node("scale"):action(
        am.series {
            am.delay(0.3),
            am.tween(
                1.9,
                {
                    scale2d = vec2(1)
                }
            )
        }
    )

    state:dispatch("set_customer", config)

    return node
end

return customer
