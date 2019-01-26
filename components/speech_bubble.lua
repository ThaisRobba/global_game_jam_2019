local function speech_bubble(str)
    local node =
        am.scale(0, 0) ^
        am.group {
            am.rect(-300, -100, 300, 100),
            am.text(str, vec4(0, 0, 0, 1))
        }

    node("scale"):action(
        am.tween(
            0.8,
            {
                scale2d = vec2(1)
            },
            am.ease.elastic
        )
    )

    return node
end

return speech_bubble
