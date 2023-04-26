local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local usr = require("main.user-variables")

local theme = {}
theme.zenburn_dir = require("awful.util").get_themes_dir() .. "zenburn"
theme.dir = gears.filesystem.get_configuration_dir() .. "themes/colorless"

theme.wallpaper = theme.dir .. '/wall.jpeg'

theme.font = "FiraCode Mono Font 10"
theme.text = '#cdd6f4'
theme.sub_text = '#a6adc8'
theme.bg = '#11111b'
theme.active = '#313244'
theme.warning = '#fab387'
theme.marked = '#a6e3a1'

theme.status_height = dpi(24)

-- these are based on the settings above ^
theme.fg_normal = theme.text
theme.fg_focus = theme.text
theme.fg_urgent = theme.text

theme.bg_normal = theme.bg
theme.bg_focus = theme.active
theme.bg_urgent = theme.warning

theme.border_width = dpi(1)

theme.border_normal = theme.bg
theme.border_focus = theme.text
theme.border_marked = theme.marked

theme.taglist_bg_focus = theme.active
theme.taglist_bg_normal = theme.bg

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

local markup = lain.util.markup

-- Textclock
local mytextclock = wibox.widget.textclock(" %H:%M ")
mytextclock.font = theme.font

-- Calendar
theme.cal = lain.widget.cal({
    attach_to = { mytextclock },
    notification_preset = {
        font = theme.font,
        fg   = theme.fg_normal,
        bg   = theme.bg_normal
    }
})

-- CPU
local cpu = lain.widget.sysload({
    settings = function()
        widget:set_markup(markup.font(theme.font, markup(theme.sub_text, " Cpu ") .. load_1 .. " "))
    end
})

-- MEM
local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(markup.font(theme.font, markup(theme.sub_text, " Mem ") .. mem_now.used .. " "))
    end
})

local bat = lain.widget.bat({
    settings = function()
        local perc = bat_now.perc
        if bat_now.ac_status == 1 then perc = perc .. " Plug" end
        widget:set_markup(markup.font(theme.font, markup(theme.sub_text, " Bat ") .. perc .. " "))
    end
})

-- Net checker
local net = lain.widget.net({
    settings = function()
        if net_now.state == "up" then net_state = "On"
        else net_state = "Off" end
        widget:set_markup(markup.font(theme.font, markup(theme.sub_text, " Net ") .. net_state .. " "))
    end
})

-- ALSA volume
local volume = lain.widget.alsa({
    settings = function()
        header = " Vol "
        vlevel  = volume_now.level

        if volume_now.status == "off" then
            vlevel = vlevel .. "M "
        else
            vlevel = vlevel .. " "
        end

        widget:set_markup(markup.font(theme.font, markup(theme.sub_text, header) .. vlevel))
    end
})

volume.widget:buttons(awful.util.table.join(
    awful.button({}, 1, function() -- right click
        os.execute(string.format("%s set %s toggle", volume.cmd, volume.togglechannel or volume.channel))
        volume.update()
    end),
    awful.button({}, 4, function() -- scroll up
        os.execute(string.format("%s set %s 1%%+", volume.cmd, volume.channel))
        volume.update()
    end),
    awful.button({}, 5, function() -- scroll down
        os.execute(string.format("%s set %s 1%%-", volume.cmd, volume.channel))
        volume.update()
    end)
))

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
    s.mywibox = awful.wibar({ position = "top", screen = s, height = theme.status_height })

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
            (usr.battery_widget and bat.widget or nil),
            net.widget,
            volume.widget,
            mytextclock
        },
    }
end

return theme
