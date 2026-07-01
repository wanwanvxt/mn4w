hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })
hl.window_rule({ match = { class = ".*" }, immediate = true })
hl.window_rule({ match = { xwayland = true }, no_blur = true })

hl.window_rule({ float = true, match = { class = "^$" , title = "^Select what to share$" }})
hl.window_rule({ float = true, match = { class = "^xarchiver$", title = "^Extract files$" } })
hl.window_rule({ float = true, size = {800, 600}, match = { class = "^xdg-desktop-portal-gtk$" } })
hl.window_rule({ float = true, size = {800, 600}, match = { class = "^firefox$", title = "^(About Mozilla Firefox|Library)$" } })
hl.window_rule({
    float = true, pin = true, size = {640, 360}, move = {"(monitor_w-700)", "(monitor_h-400)"},
    match = { class = "^firefox$", title = "^Picture-in-Picture$" }
})
