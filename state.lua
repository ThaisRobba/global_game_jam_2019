--[[
I'd like to have warnings if an event was fired but there was no action registered

-- Sample as it would be from a main.lua:

local actions = require "actions"
local initial_state = require "initial_state"
local state = require "state"

--------------------------

window =
    am.window {
    width = 480,
    height = 640
}

window.scene = am.group {}

state:mount(window.scene, actions, initial_state)
state:dispatch("increment")
]]
local function create_action_string(action)
    return "action_" .. tostring(action)
end

return {
    queue = {},
    current = {},
    dispatch = function(self, action, payload)
        table.insert(self.queue, {action = action, payload = payload})
    end,
    mount = function(self, target_node, actions, initial_state)
        self.current = table.deep_copy(initial_state)

        target_node:late_action(
            "state_update",
            function()
                self:update(target_node, actions)
            end
        )
    end,
    update = function(self, target_node, actions)
        for _, event in ipairs(self.queue) do
            local action = event.action
            local action_str = create_action_string(action)

            -----------------

            if actions[action] then
                actions[action](self.current, event.payload)
            end

            -----------------

            local matches = target_node:all(action_str)
            for _, child in ipairs(matches) do
                child[action_str](child, self.current)
            end
        end

        table.clear(self.queue)
    end,
    on = function(self, action, target, callback)
        local action_str = create_action_string(action)
        target:tag(action_str)
        target[action_str] = callback
    end,
    off = function(self, action, target)
        local action_str = create_action_string(action)
        target:untag(action_str)
        target[action_str] = nil
    end
}
