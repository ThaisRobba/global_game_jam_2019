-- The touch area provides an axis-aligned bounding-box (AABB) with mouse detection.

-- ## Params
-- - x1
-- - y1
-- - x2
-- - y2

-- ## Properties
-- - released
-- - pressed
-- - hover
-- - down
-- - enter
-- - exit
-- - drag
-- - allow_propagation
--    - allows input to bubble up
-- - hovering
--    - if the touch_area is currently being hovered
-- - dragging
--    - if the touch_area is currently being dragged. Default is false.
-- - offset
--    - a vec2 with the offset between the click and the object center

-- ## Dependencies
-- None

-- ## Limitations
-- Won't work with rotated nodes and polygon shapes.

-- ## Example
--     local node = am.touch_area(-25, -25, 25, 25)
--     function node:released()
--         print("I was clicked!")
--     end

-----------------------------------

-- ## Internal utility functions

local function empty()
end

local function point_is_within_bounds(point, x1, y1, x2, y2)
    return point.x >= x1 and point.x <= x2 and point.y >= y1 and point.y <= y2
end

-----------------------------------

-- ## Internal functionality
local nodes = {}
local first = true

-- We must rebuild the nodes table to avoid removed children.
-- We only need to do it once.
local function action(node)
    if first then
        table.clear(nodes)
        first = false
    end

    table.insert(nodes, node)
end

local focused_areas = {}

-- After we are sure to have collected all unpaused nodes,
-- we check against the window to see the expected behavior.
local function late_action()
    if not first then
        first = true

        local mouse = window:mouse_position()
        local propagate = true

        -- Node actions are left-right, depth-first so we traverse in reverse
        for i = #nodes, 1, -1 do
            local area = nodes[i]

            if propagate and point_is_within_bounds(mouse, area:get_bounds()) then
                propagate = area.allow_propagation

                if not area.hovering then
                    area:enter()
                    area.hovering = true
                end

                if window:mouse_released("left") and focused_areas[area] then
                    area:released()
                    focused_areas[area] = nil
                elseif window:mouse_pressed("left") then
                    focused_areas[area] = true
                    area:pressed()
                    area.offset = mouse
                elseif window:mouse_down("left") and focused_areas[area] then
                    area:down()
                else
                    area:hover()
                end
            else
                if area.hovering and not area.dragging then
                    area.hovering = false
                    area:exit()
                    focused_areas[area] = nil
                end
            end

            if area.dragging then
                if not window:mouse_down("left") then
                    area:released()
                else
                    area:drag()
                end
            end
        end
    end
end

-----------------------------------

-- ## Node definition

local function touch_area(x1, y1, x2, y2)
    local node = am.read_uniform("MV")

    node.released = empty
    node.pressed = empty
    node.down = empty
    node.enter = empty
    node.hover = empty
    node.exit = empty
    node.drag = empty

    node.allow_propagation = true
    node.hovering = false
    node.dragging = false

    local w = math.abs(x2 - x1)
    function node:get_width()
        return w
    end

    local h = math.abs(y2 - y1)
    function node:get_height()
        return h
    end

    -- When a node is not being shown because a parent is hidden the read_uniform
    -- value will be zero, crashing when we access it as an array
    function node:get_bounds()
        if self.value == 0 then
            return 0, 0, 0, 0
        else
            local position = self.center
            local scale = self.scale

            return position.x + x1 * scale.x, position.y + y1 * scale.y, position.x + x2 * scale.x, position.y +
                y2 * scale.y
        end
    end

    function node:get_scale()
        if self.value == 0 then
            return vec2(1)
        else
            return vec2(self.value[1].x, self.value[2].y)
        end
    end

    function node:get_center()
        if self.value == 0 then
            return vec2(0)
        else
            return self.value[4].xy
        end
    end

    local offset = vec2(0)
    function node:set_offset(value)
        offset = value - self.center
    end

    function node:get_offset()
        return offset
    end

    node:tag("touch_area")

    node:action(action)
    node:late_action(late_action)

    return node
end

return touch_area
