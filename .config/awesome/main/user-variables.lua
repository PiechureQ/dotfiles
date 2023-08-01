-- {{{ Global Variable Definitions
-- moved here in module as local variable
-- }}}

local _M = {
  -- This is used later as the default terminal and editor to run.
  terminal = "/home/michalpraca/.local/kitty.app/bin/kitty",
  editor = "nvim",
  browser = "/opt/firefox/firefox",
  messages = "flatpak run com.slack.Slack",
  music = "flatpak run com.spotify.Client",
  files = "nautilus",
  email = "thunderbird",

  -- Default modkey.
  modkey = "Mod4",
  altkey = "Mod1",

  -- theme
  chosen_theme = 'colorless',

  battery_widget = true,
}

return _M
