local state = require "state"
local initial_state = require "initial_state"
local actions = require "actions"

local screen = require "components.screen"

window =
    am.window {
    width = 1920,
    height = 1080
}

window.scene =
    am.group {
    screen("screens.restaurant")
}

window.scene:action("bgm", am.play("assets/sounds/trixie.ogg", true))

state:mount(window.scene, actions, initial_state)
