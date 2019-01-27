local function speech_bubble(str)
    local node =
        am.scale(0, 0) ^
        am.group {
            am.sprite("assets/ui/speech_bubble.png"),
            am.scale(3, 3) ^ am.text(str, vec4(1, 1, 1, 1))
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

    node:tag("speech_bubble")

    return node
end

return speech_bubble
