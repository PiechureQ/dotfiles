if status is-interactive
    # Commands to run in interactive sessions can go here

    function fish_greeting
        fastfetch
        # fastfetch --image "$HOME/.config/fish/nf400.jpg" \
        #   --image-tty kitty \
        #   --disable icons theme wmTheme \
        #   --colors 4 4 7 5 6 7 \
        #   --no-color-blocks
	# echo 🙏 (fortune -s) 🙏
    end

    # set -L
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
    alias cat bat

    abbr -a npr npm run
    abbr -a nps npm start
    abbr -a npi npm i
    abbr -a npmi npm i

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

    abbr dockerc docker compose
    abbr dcompose docker compose
    abbr doco docker compose
    abbr docou docker compose up
    abbr docor docker compose run

    abbr tx tmux
    abbr txa tmux attach

    alias nv="nvim"
    abbr -a nvi neovide
    set -g -e EDITOR
    set -g EDITOR nvim
    set -U EDITOR nvim

    # faster typing
    # gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 30
    # gsettings set org.gnome.desktop.peripherals.keyboard delay 200
    # gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape']"

    # source local configs and keys
    if test -e $HOME/.my.fish
        source $HOME/.my.fish
    else
        touch $HOME/.my.fish
    end
    if test -e $HOME/.keys.fish
        source $HOME/.keys.fish
    else
        touch $HOME/.keys.fish
    end

    set --export PATH .local/bin $PATH
    if test "$XDG_SESSION_TYPE" = "wayland"
        alias pbcopy='wl-copy'
        alias pbpaste='wl-paste'
    else
        alias pbcopy='xclip -selection clipboard'
        alias pbpaste='xclip -selection clipboard -o'
    end
    alias clipp 'pbcopy'

    alias curlj 'curl -H "Content-type: application/json"'
    abbr -a xpost "-X POST"

    function r --description "Run previous command (excluding 'r' itself)"
        if test (count $argv) -eq 0
            # Znajdź ostatnie polecenie które nie jest 'r'
            set -l last_cmd (history | grep -v '^r$' | head -1)
            
            if test -n "$last_cmd"
                eval $last_cmd
            else
                echo ""
            end
        else
            # Z argumentem - znajdź ostatnie polecenie zawierające argument (także pomijając 'r')
            set -l found_cmd (history | grep -v '^r$' | grep "$argv[1]" | head -1)
            
            if test -n "$found_cmd"
                eval $found_cmd
            else
                echo "nieznaleziono poolecenia: $argv[1]"
            end
        end
    end
end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

#zig
set --export ZIG_INSTALL "$HOME/.local/zig"
set --export PATH $ZIG_INSTALL $PATH

# opencode
fish_add_path /home/xmichalx/.opencode/bin
