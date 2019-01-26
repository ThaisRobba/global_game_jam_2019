local state = require "state"
local initial_state = require "initial_state"
local actions = require "actions"

local screen = require "components.screen"

window =
    am.window {
    width = 1280,
    height = 720
}

window.scene =
    am.group {
    screen("screens.restaurant")
}

state:mount(window.scene, actions, initial_state)
