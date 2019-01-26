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
