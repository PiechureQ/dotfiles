if status is-interactive
    # Commands to run in interactive sessions can go here

    function fish_greeting
        neofetch --kitty $HOME/.config/fish/nf400.jpg --disable icons theme wm_theme --colors 4 4 7 5 6 7 --color_blocks off
        echo 🙏 (fortune -s) 🙏
    end

    set -L
    set -U fish_color_normal normal
    set -U fish_color_command blue
    set -U fish_color_autosuggestion brmagenta -d
    set -U fish_color_param brmagenta
    set -U fish_color_end normal
    set -U fish_color_error red
    set -U fish_color_quote brcyan
    set -U fish_color_comment black
    set -U fish_color_redirection brblue
    set -U fish_color_history_current --bold
    set -U fish_color_valid_path --bold
    set -U fish_color_operator blue --bold

    alias q exit
    alias ff ranger
    alias cat bat

    abbr -a npr npm run
    abbr -a nps npm start
    abbr -a npi npm install

    abbr -a g git
    abbr -a ga git add
    abbr -a gs git status
    abbr -a gd git diff
    abbr -a gc git commit
    abbr -a gp git push
    abbr -a gl git pull
    abbr -a gb git branch
    abbr -a gco git checkout
    abbr -a gf git fetch

    # kitty
    alias icat "kitty +kitten icat"
    alias opakitty "kitty -o background_opacity=0.0 --detach"

    # open configs with editor
    alias ek="$EDITOR $HOME/.config/kitty/kitty.conf"
    alias ea="$EDITOR $HOME/.config/awesome/rc.lua"
    alias en="$EDITOR $HOME/.config/nvim/init.lua"

    function todo
        $EDITOR "$HOME/Dokumenty/todo/$argv[1]"
    end

    function nv
        if test -z (which node)
           node -v > /dev/null
        end
        nvim $argv
    end

    set -U EDITOR nv

    alias config 'git --git-dir=$HOME/.myconfig/ --work-tree=$HOME/'
    abbr -a con config
    abbr -a conf config
    abbr -a cnf config

    # faster typing
    xset r rate 260 45

    if test -e $HOME/.my.fish
        source $HOME/.my.fish
    end
end
