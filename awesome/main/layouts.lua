-- Standard awesome library
local awful = require("awful")
local lain = require("lain")

local _M = {}

local l = awful.layout.suit  -- Just to save some typing: use an alias.

lain.layout.cascade.tile.offset_x      = 10
lain.layout.cascade.tile.offset_y      = 64
lain.layout.cascade.tile.extra_padding = 10
lain.layout.cascade.tile.nmaster       = 4
lain.layout.cascade.tile.ncol          = 2

function _M.get ()
  -- Table of layouts to cover with awful.layout.inc, order matters.
  local layouts = {
    l.floating,
    l.tile,
    -- l.tile.left,
    l.tile.bottom,
    -- l.tile.top,
    l.fair,
    l.fair.horizontal,
    -- l.spiral,
    -- l.spiral.dwindle,
    l.max,
    -- l.max.fullscreen,
    l.magnifier,
    -- l.corner.nw,
    l.corner.ne,
    -- l.corner.sw,
    l.corner.se,
    -- lain.layout.cascade,
    lain.layout.cascade.tile,
    -- lain.layout.centerwork,
    -- lain.layout.centerwork.horizontal,
    -- lain.layout.termfair,
    -- lain.layout.termfair.center,
  }

  return layouts
end

return setmetatable({}, { __call = function(_, ...) return _M.get(...) end })
