--[[ Actions receive the current state and in some cases, a payload ]]
return {
    select_tag = function(state, payload)
        table.insert(state.selected_tags, payload)
    end
}
