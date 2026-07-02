hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

hl.config({
    general = {
        border_size = 2,
        gaps_in = 5,
        gaps_out = 10,
        float_gaps = 0,
        gaps_workspaces = 0,

        ["col.active_border"] = "#00ff99",
        ["col.inactive_border"] = "#808080",

        layout = "scrolling",

        resize_on_border = true,
        extend_border_grab_area = 10,
        hover_icon_on_border = true,

        allow_tearing = true,
    },

    decoration = {
        rounding = 5,
        rounding_power = 2,

        active_opacity = 1,
        inactive_opacity = 1,
        fullscreen_opacity = 1,

        dim_modal = true,
        dim_inactive = true,
        dim_strength = 0,
        dim_special = 0.4,
        dim_around = 0.2,

        blur = {
            enabled = true,
            size = 2,
            passes = 2,
            ignore_opacity = true,
            new_optimizations = true,
            xray = false,
            special = true,
            popups = false,
            input_methods = false,
        },
        shadow = {
            enabled = true,
            range = 15,
            render_power = 4,
            sharp = false,
            color = "#222222",
            offset = {0, 0},
            scale = 1,
        },
    },

    animations = {
        enabled = true,
        workspace_wraparound = true,
    },

    input = {
        kb_layout = "us",
        numlock_by_default = true,
        resolve_binds_by_sym = false,
        repeat_rate = 25,
        repeat_delay = 250,

        sensitivity = 0,
        accel_profile = "flat",

        follow_mouse = 1,
        follow_mouse_shrink = 10,
        follow_mouse_threshold = 20,

        focus_on_close = 1,
        mouse_refocus = true,
        float_switch_override_focus = 1,
        special_fallthrough = false,

        off_window_axis_events = 2,
        emulate_discrete_scroll = 1,

        touchpad = {
            disable_while_typing = true,
            natural_scroll = true,
            scroll_factor = 1.5,
        },
    },

    group = {
        auto_group = true,
        insert_after_current = true,
        focus_removed_window = true,
        drag_into_group = 1,
        merge_groups_on_drag = true,
        merge_groups_on_groupbar = true,
        merge_floated_into_tiled_on_groupbar = false,
        group_on_movetoworkspace = false,
        ["col.border_active"] = "#00ff99",
        ["col.border_inactive"] = "#808080",
        ["col.border_locked_active"] = "#00aa99",
        ["col.border_locked_inactive"] = "#505050",

        groupbar = {
            enabled = true,
            gradients = false,
            indicator_height = 3,
            stacked = false,
            render_titles = false,
            scrolling = true,
            rounding = 1,
            rounding_power = 2,
            round_only_edges = true,
            ["col.active"] = "#00ff99",
            ["col.inactive"] = "#808080",
            ["col.locked_active"] = "#00aa99",
            ["col.locked_inactive"] = "#505050",
            gaps_in = 5,
            gaps_out = 5,
            keep_upper_gap = false,
            middle_click_close = true,
            blur = false,
        },
    },

    misc = {
        disable_hyprland_logo = true,
        disable_splash_rendering = true,
        vrr = 1,
        animate_manual_resizes = false,
        animate_mouse_windowdragging = false,
        disable_autoreload = true,
        focus_on_activate = true,
        background_color = "#222222",
        close_special_on_empty = true,
        middle_click_paste = true,
    },

    layout = {
        single_window_aspect_ratio = { 0, 0 },
        single_window_aspect_ratio_tolerance = 0.1,
    },

    dwindle = {
        force_split = 0,
        preserve_split = true,
        smart_split = true,
        smart_resizing = true,
    },

    scrolling = {
        fullscreen_on_one_column = false,
        column_width = 0.75,
        focus_fit_method = 1,
        follow_focus = true,
        follow_min_visible = 0.8,
        explicit_column_widths = "0.25, 0.5, 0.75, 1",
        wrap_focus = false,
        wrap_swapcol = false,
        direction = "right",
    },

    binds = {
        pass_mouse_when_bound = false,
        scroll_event_delay = 0,
        workspace_back_and_forth = false,
        hide_special_on_workspace_change = true,
        allow_workspace_cycles = false,
        workspace_center_on = 1,
        focus_preferred_method = 1,
        ignore_group_lock = false,
        movefocus_cycles_fullscreen = false,
        movefocus_cycles_groupfirst = false,
        window_direction_monitor_fallback = false,
        disable_keybind_grabbing = false,
        allow_pin_fullscreen = false,
        drag_threshold = 0,
    },

    xwayland = {
        enabled = true,
        use_nearest_neighbor = true,
        force_zero_scaling = true,
    },

    cursor = {
        hotspot_padding = 0,
        inactive_timeout = 10,
        zoom_factor = 1,
        zoom_rigid = true,
        zoom_detached_camera = false,
        zoom_disable_aa = false,
        enable_hyprcursor = true,
        hide_on_key_press = true,
        hide_on_touch = true,
    },

    ecosystem = {
        no_update_news = true,
        no_donation_nag = true,
        enforce_permissions = false,
    },

    debug = {
        disable_logs = false,
        disable_time = false,
    },
})

hl.curve("accel", { type = "bezier", points = { {0.3, 0}, {0.8, 0.15} } })
hl.curve("decel", { type = "bezier", points = { {0.05, 0.7}, {0.1, 1} } })
hl.curve("fast",  { type = "bezier", points = { {0, 0}, {0, 1} }})

hl.animation({ leaf = "windowsIn",           enabled = true, speed = 3, bezier = "decel", style = "popin 80%" })
hl.animation({ leaf = "windowsOut",          enabled = true, speed = 2, bezier = "accel", style = "popin 80%" })
hl.animation({ leaf = "windowsMove",         enabled = true, speed = 3, bezier = "decel", style = "slide" })
hl.animation({ leaf = "border",              enabled = true, speed = 1, bezier = "decel" })
hl.animation({ leaf = "fadeIn",              enabled = true, speed = 3, bezier = "decel"})
hl.animation({ leaf = "fadeOut",             enabled = true, speed = 2, bezier = "accel"})
hl.animation({ leaf = "workspaces",          enabled = true, speed = 5, bezier = "decel", style = "slidevert" })
hl.animation({ leaf = "specialWorkspaceIn",  enabled = true, speed = 3, bezier = "decel", style = "slidevert" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 2, bezier = "accel", style = "slidevert" })
hl.animation({ leaf = "layersIn",            enabled = true, speed = 3, bezier = "decel", style = "popin 80%" })
hl.animation({ leaf = "layersOut",           enabled = true, speed = 2, bezier = "accel", style = "popin 80%" })
hl.animation({ leaf = "fadeLayersIn",        enabled = true, speed = 3, bezier = "decel"})
hl.animation({ leaf = "fadeLayersOut",       enabled = true, speed = 2, bezier = "accel"})
hl.animation({ leaf = "zoomFactor",          enabled = true, speed = 3, bezier = "fast"})
