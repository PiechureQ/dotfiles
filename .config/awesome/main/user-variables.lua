-- {{{ Global Variable Definitions
-- moved here in module as local variable
-- }}}

local _M = {
  -- This is used later as the default terminal and editor to run.
  terminal = "kitty",
  editor = "nvim",
  browser = "firefox",
  messages = "slack",
  files = "nautilus",
  email = "thunderbird",

  -- Default modkey.
  modkey = "Mod4",
  altkey = "Mod1",

  -- theme
  chosen_theme = 'colorless',

  battery_widget = false,
}

return _M

