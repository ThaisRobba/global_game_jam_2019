local function animated_sprite(dir)
    local node = am.translate(0, 0)
    local sprite

    function node:play_animation(animation, loop)
        local file = am.load_string(dir .. animation .. ".json")
        local config = am.parse_json(file)
        local frames = config.frames

        if not frames then
            return am.text("Missing the list of frames for the sprite.\nBe sure to check the .json file! :)")
        end

        if not frames[1].source then
            return am.text("Missing source field for the sprite.\nBe sure to check the .json file! :)")
        end

        ------------------

        local dt = 0
        local current_frame = 1
        local current_time = frames[current_frame].time or 1

        loop = config.loop or loop

        ------------------

        if not sprite then
            print(table.tostring(frames))
            sprite = am.sprite(dir .. frames[current_frame].source .. ".png")
            node:append(sprite)
        end

        ------------------

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
                    end

                    sprite.source = dir .. frames[current_frame].source .. ".png"
                    current_time = frames[current_frame].time
                end
            end
        )
    end

    node:tag("animated_sprite")

    return node
end

return animated_sprite
