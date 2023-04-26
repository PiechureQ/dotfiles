-- Standard awesome library
local awful = require("awful")
local freedesktop = require("freedesktop")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Theme handling library
local beautiful = require("beautiful") -- for awesome.icon

local M = {}  -- menu
local _M = {} -- module

local terminal = RC.vars.terminal
local editor = RC.vars.editor
local editor_cmd = terminal .. " -e " .. editor

M.awesome = {
    { "hotkeys", function()
      hotkeys_popup.show_help(nil, awful.screen.focused()) 
    end },
    { "Docs", function()
        awful.util.spawn(string.format("%s %s", browser, "https://awesomewm.org/doc/api/index.html"))
        -- awful.client.focus({})
    end },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "Terminal", terminal },
    { "Shutdown/Logout", "oblogout" },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end }
}


M.favorite = {
    { "&firefox", "firefox" },
}

function _M.get()
    local menu = freedesktop.menu.build {
        before = {
            { "Awesome", M.awesome, beautiful.awesome_subicon },
            { "Favorites", M.favorite },
        },
        after = {
            { "Open terminal", terminal },
        }
    }

    return menu
end

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
