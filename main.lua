local screen = require "components.screen"

window =
    am.window {
    width = 1920 / 2,
    height = 1080 / 2
}

window.scene =
    am.group {
    screen("screens.main_menu")
}
