--[[ Actions receive the current state and in some cases, a payload ]]
return {
    increment = function(state, payload)
        -- state.count = state.count + 1
    end,
    decrement = function(state)
        -- state.count = state.count - 1
    end
}
