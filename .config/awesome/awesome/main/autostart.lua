local awful = require("awful")

awful.util.shell = "bash"

-- This function will run once every time Awesome is started
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

function run_once(prg, arg_string, pname, screen)
    if not prg then
        do
            return nil
        end
    end

    if not pname then
        pname = prg
    end

    if not arg_string then
        awful.util.spawn_with_shell("pgrep -f -u $USER -x '" .. pname .. "' || (" .. prg .. ")", screen)
    else
        awful.util.spawn_with_shell(
            "pgrep -f -u $USER -x '" .. pname .. " " .. arg_string .. "' || (" .. prg .. " " .. arg_string .. ")",
            screen
        )
    end
end

run_once("urxvtd")
run_once("unclutter -root")
run_once("picom -b")
run_once("xset r rate 260 45")
run_once('setxkbmap -option "caps:escape"')

-- run_once("firefox")
