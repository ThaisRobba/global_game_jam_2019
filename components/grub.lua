local function grub()
    local node = am.translate(690, -270):tag("grub") ^ am.sprite("assets/restaurant/grub.png")
    node.hidden = true
    return node
end

return grub
