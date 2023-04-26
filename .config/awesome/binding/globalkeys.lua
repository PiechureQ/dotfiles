-- Standard awesome library
local gears = require("gears")
local beautiful = require("beautiful")
local awful = require("awful")
local naughty = require("naughty")
-- local hotkeys_popup = require("awful.hotkeys_popup").widget
local hotkeys_popup = require("awful.hotkeys_popup")
-- Menubar library
local menubar = require("menubar")

-- Resource Configuration
local modkey = RC.vars.modkey
local altkey = RC.vars.altkey

local _M = {}

function _M.get()
  local globalkeys = gears.table.join(
    -- Destroy all notifications
    awful.key({ "Control",           }, "space", function() naughty.destroy_all_notifications() end,
              {description = "destroy all notifications", group = "hotkeys"}),

    -- Take a screenshot
    awful.key({ altkey }, "\\", function() os.execute("screenshot") end,
              {description = "take a screenshot", group = "hotkeys"}),

    -- Show help
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),

    -- previous tag
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "previous", group = "tag"}),

    -- Default client focus
    awful.key({ altkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ altkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey, altkey    }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey, altkey    }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey, altkey }, "h",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "client"}),
    awful.key({ modkey, altkey }, "l",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "client"}),

    -- By-direction client focus
    awful.key({ modkey }, "j",
        function()
            awful.client.focus.global_bydirection("down")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus down", group = "client"}),
    awful.key({ modkey }, "k",
        function()
            awful.client.focus.global_bydirection("up")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus up", group = "client"}),
    awful.key({ modkey }, "h",
        function()
            awful.client.focus.global_bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus left", group = "client"}),
    awful.key({ modkey }, "l",
        function()
            awful.client.focus.global_bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        {description = "focus right", group = "client"}),

    -- change master width
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),

    -- Swap clients
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),

    -- Urgent client
    awful.key({ modkey, altkey    }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),

    awful.key({ modkey,           }, "Tab",
        function ()
            if cycle_prev then
                awful.client.focus.history.previous()
            else
                awful.client.focus.byidx(-1)
            end
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "previous client", group = "client"}),

    -- Show/hide titlebar
    awful.key({ modkey, "Shift" }, "t",
        function ()
            local c = client.focus
            if c then
                awful.titlebar.toggle(c)
            end
        end,
        {description = "toggle titlebar", group = "awesome"}),

    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    -- Change layout
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n", function ()
        local c = awful.client.restore()
        -- Focus restored client
        if c then
            c:emit_signal("request::activate", "key.unminimize", {raise = true})
        end
    end, {description = "restore minimized", group = "client"}),

    -- Screen brightness
    awful.key({ }, "XF86MonBrightnessUp", function () os.execute("brightnessctl s +10% -q") end,
              {description = "+10%", group = "hotkeys"}),
    awful.key({ }, "XF86MonBrightnessDown", function () os.execute("brightnessctl s 10%- -q") end,
              {description = "-10%", group = "hotkeys"}),

    -- Audio control
    awful.key({ }, "XF86AudioPlay",
        function ()
            os.execute("sp play")
        end,
        {description = "spotify play", group = "hotkeys"}),
    awful.key({ modkey, altkey }, "l",
        function ()
            os.execute("sp play")
        end,
        {description = "spotify play", group = "hotkeys"}),
    awful.key({ }, "XF86AudioNext",
        function ()
            os.execute("sp next")
        end,
        {description = "spotify next", group = "hotkeys"}),
    awful.key({ modkey, altkey }, "k",
        function ()
            os.execute("sp next")
        end,
        {description = "spotify next", group = "hotkeys"}),
    awful.key({ }, "XF86AudioPrev",
        function ()
            os.execute("sp prev")
        end,
        {description = "spotify previous", group = "hotkeys"}),
    awful.key({ modkey, altkey }, "j",
        function ()
            os.execute("sp prev")
        end,
        {description = "spotify previous", group = "hotkeys"}),

    -- ALSA volume control
    awful.key({ }, "XF86AudioRaiseVolume",
        function ()
            os.execute(string.format("amixer -q set %s 5%%+", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "volume up", group = "hotkeys"}),
    awful.key({ }, "XF86AudioLowerVolume",
        function ()
            os.execute(string.format("amixer -q set %s 5%%-", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "volume down", group = "hotkeys"}),

    awful.key({ }, "XF86AudioMute",
        function ()
            os.execute(string.format("amixer -q set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "toggle mute", group = "hotkeys"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(RC.vars.terminal) end,
              {description = "open a terminal", group = "launcher"}),

    awful.key({ modkey, altkey    }, "f", function () awful.spawn(RC.vars.files) end,
              {description = "run files", group = "launcher"}),

    awful.key({ modkey, altkey    }, "b", function () awful.spawn(RC.vars.browser) end,
              {description = "run " .. RC.vars.browser, group = "launcher"}),

    awful.key({ modkey, altkey    }, "m", function () awful.spawn(RC.vars.messages) end,
              {description = "run " .. RC.vars.messages, group = "launcher"}),

    awful.key({ modkey, altkey    }, "e", function () awful.spawn(RC.vars.email) end,
              {description = "run email client", group = "launcher"}),

    awful.key({ modkey }, "/", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
  )

  return globalkeys
end

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
