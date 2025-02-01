local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.zenburn_dir                               = require("awful.util").get_themes_dir() .. "zenburn"
theme.dir                                       = gears.filesystem.get_configuration_dir() .. "themes/gruvbox"
theme.wallpaper                                 = theme.dir .. "/wall.jpg"
theme.font                                      = "FiraCode Mono Font 10"

-- Palette: {{{

-- setup palette dictionary
palette = {}

-- fill it with absolute colors
palette.dark0_hard  = '#1d2021'     -- 29-32-33
palette.dark0       = '#282828'     -- 40-40-40
palette.dark0_soft  = '#32302f'     -- 50-48-47
palette.dark1       = '#3c3836'     -- 60-56-54
palette.dark2       = '#504945'     -- 80-73-69
palette.dark3       = '#665c54'     -- 102-92-84
palette.dark4       = '#7c6f64'     -- 124-111-100
palette.dark4_256   = '#7c6f64'     -- 124-111-100

palette.gray_245    = '#928374'     -- 146-131-116
palette.gray_244    = '#928374'     -- 146-131-116

palette.light0_hard = '#f9f5d7'     -- 249-245-215
palette.light0      = '#fbf1c7'     -- 253-244-193
palette.light0_soft = '#f2e5bc'     -- 242-229-188
palette.light1      = '#ebdbb2'     -- 235-219-178
palette.light2      = '#d5c4a1'     -- 213-196-161
palette.light3      = '#bdae93'     -- 189-174-147
palette.light4      = '#a89984'     -- 168-153-132
palette.light4_256  = '#a89984'     -- 168-153-132

palette.bright_red     = '#fb4934'     -- 251-73-52
palette.bright_green   = '#b8bb26'     -- 184-187-38
palette.bright_yellow  = '#fabd2f'     -- 250-189-47
palette.bright_blue    = '#83a598'     -- 131-165-152
palette.bright_purple  = '#d3869b'     -- 211-134-155
palette.bright_aqua    = '#8ec07c'     -- 142-192-124
palette.bright_orange  = '#fe8019'     -- 254-128-25

palette.neutral_red    = '#cc241d'     -- 204-36-29
palette.neutral_green  = '#98971a'     -- 152-151-26
palette.neutral_yellow = '#d79921'     -- 215-153-33
palette.neutral_blue   = '#458588'      -- 69-133-136
palette.neutral_purple = '#b16286'     -- 177-98-134
palette.neutral_aqua   = '#689d6a'      -- 104-157-106
palette.neutral_orange = '#d65d0e'     -- 214-93-14

palette.faded_red      = '#9d0006'      -- 157-0-6
palette.faded_green    = '#79740e'     -- 121-116-14
palette.faded_yellow   = '#b57614'     -- 181-118-20
palette.faded_blue     = '#076678'      -- 7-102-120
palette.faded_purple   = '#8f3f71'      -- 143-63-113
palette.faded_aqua     = '#427b58'      -- 66-123-88
palette.faded_orange   = '#af3a03'     -- 175-58-3

-- }}}

theme.fg_normal = palette.light0_soft
-- theme.fg_focus = palette.light0_soft
theme.fg_urgent = palette.neutral_yellow

theme.bg_normal = palette.dark0
-- theme.bg_focus = palette.dark0
theme.bg_urgent = palette.neutral_red

theme.border_width = dpi(1.25)

theme.border_normal = palette.gray_244
theme.border_focus = palette.light3
theme.border_marked = palette.bright_green

theme.taglist_bg_focus = palette.dark2
theme.taglist_fg_focus = palette.light0_hard

theme.tasklist_bg_focus = palette.dark2
theme.tasklist_fg_focus = palette.light0_hard

theme.menu_height                               = dpi(16)
theme.menu_width                                = dpi(140)
theme.awesome_icon                              = theme.dir .."/icons/awesome.png"
theme.menu_submenu_icon                         = theme.dir .. "/icons/submenu.png"

theme.layout_txt_tile                           = "[t]"
theme.layout_txt_tileleft                       = "[l]"
theme.layout_txt_tilebottom                     = "[b]"
theme.layout_txt_tiletop                        = "[tt]"
theme.layout_txt_fairv                          = "[fv]"
theme.layout_txt_fairh                          = "[fh]"
theme.layout_txt_spiral                         = "[s]"
theme.layout_txt_dwindle                        = "[d]"
theme.layout_txt_max                            = "[m]"
theme.layout_txt_fullscreen                     = "[F]"
theme.layout_txt_magnifier                      = "[M]"
theme.layout_txt_floating                       = "[f]"
theme.layout_txt_cornernw                       = "[nw]"
theme.layout_txt_cornerne                       = "[ne]"
theme.layout_txt_cornersw                       = "[sw]"
theme.layout_txt_cornerse                       = "[se]"
theme.layout_txt_cornerse                       = "[se]"
-- lain related
theme.layout_txt_termfair                       = "[termfair]"
theme.layout_txt_centerfair                     = "[centerfair]"
theme.layout_txt_cascadetile                    = "[c]"

theme.tasklist_plain_task_name                  = true
theme.tasklist_disable_icon                     = false
theme.useless_gap                               = dpi(5)
theme.titlebar_close_button_normal              = theme.zenburn_dir.."/titlebar/close_normal.png"
theme.titlebar_close_button_focus               = theme.zenburn_dir.."/titlebar/close_focus.png"
theme.titlebar_minimize_button_normal           = theme.zenburn_dir.."/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus            = theme.zenburn_dir.."/titlebar/minimize_focus.png"
theme.titlebar_ontop_button_normal_inactive     = theme.zenburn_dir.."/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive      = theme.zenburn_dir.."/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active       = theme.zenburn_dir.."/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active        = theme.zenburn_dir.."/titlebar/ontop_focus_active.png"
theme.titlebar_sticky_button_normal_inactive    = theme.zenburn_dir.."/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive     = theme.zenburn_dir.."/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active      = theme.zenburn_dir.."/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active       = theme.zenburn_dir.."/titlebar/sticky_focus_active.png"
theme.titlebar_floating_button_normal_inactive  = theme.zenburn_dir.."/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive   = theme.zenburn_dir.."/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active    = theme.zenburn_dir.."/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active     = theme.zenburn_dir.."/titlebar/floating_focus_active.png"
theme.titlebar_maximized_button_normal_inactive = theme.zenburn_dir.."/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.zenburn_dir.."/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active   = theme.zenburn_dir.."/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active    = theme.zenburn_dir.."/titlebar/maximized_focus_active.png"

local markup = lain.util.markup
local gray   = palette.light4

-- Textclock
local mytextclock = wibox.widget.textclock(" %H:%M ")
mytextclock.font = theme.font

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = "Terminus 11",
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- CPU
local cpu = lain.widget.sysload({
    settings = function()
        widget:set_markup(markup.font(theme.font, markup(gray, " Cpu ") .. load_1 .. " "))
    end
})

-- MEM
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, markup(gray, " Mem ") .. mem_now.used .. " "))
    end
})

local bat = lain.widget.bat({
    settings = function()
        local perc = bat_now.perc
        if bat_now.ac_status == 1 then perc = perc .. " Plug" end
        widget:set_markup(markup.font(theme.font, markup(gray, " Bat ") .. perc .. " "))
    end
})

-- Net checker
local net = lain.widget.net({
    settings = function()
        if net_now.state == "up" then net_state = "On"
        else net_state = "Off" end
        widget:set_markup(markup.font(theme.font, markup(gray, " Net ") .. net_state .. " "))
    end
})

-- ALSA volume
theme.volume = lain.widget.alsa({
    settings = function()
        header = " Vol "
        vlevel  = volume_now.level

        if volume_now.status == "off" then
            vlevel = vlevel .. "M "
        else
            vlevel = vlevel .. " "
        end

        widget:set_markup(markup.font(theme.font, markup(gray, header) .. vlevel))
    end
})

local spotify_widget = require("awesome-wm-widgets.spotify-widget.spotify")

-- Separators
local spr   = wibox.widget.textbox('   ')

local function update_txt_layoutbox(s)
    -- Writes a string representation of the current layout in a textbox widget
    local txt_l = theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))] or ""
    s.mytxtlayoutbox:set_text(txt_l)
end

function theme.at_screen_connect(s)
    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    -- awful.tag(awful.util.tagnames, s, awful.util.tag_layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Textual layoutbox
    s.mytxtlayoutbox = wibox.widget.textbox(theme["layout_txt_" .. awful.layout.getname(awful.layout.get(s))])
    awful.tag.attached_connect_signal(s, "property::selected", function () update_txt_layoutbox(s) end)
    awful.tag.attached_connect_signal(s, "property::layout", function () update_txt_layoutbox(s) end)
    s.mytxtlayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function() awful.layout.inc(1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function() awful.layout.inc(-1) end),
                           awful.button({}, 4, function() awful.layout.inc(1) end),
                           awful.button({}, 5, function() awful.layout.inc(-1) end)))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(18) })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mytxtlayoutbox,
            s.mypromptbox,
            spr,
        },
        s.mytasklist, -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            spr,
            wibox.widget.systray(),
            spr,
            -- theme.mpd.widget,
            spotify_widget(),
            spr,
            cpu.widget,
            mem.widget,
            bat.widget,
            net.widget,
            theme.volume.widget,
            mytextclock
        },
    }
end

return theme
