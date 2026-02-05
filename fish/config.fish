source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
    #    # smth smth
end

if status is-interactive
    starship init fish | source
end

# Begrüßung ausschalten
set -g fish_greeting ""

alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --group-directories-first'
alias la='eza -la --icons --group-directories-first'

# --- FZF Plugin Einstellungen ---

# Erzwingt fd für die allgemeine Suche
set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --exclude .git'

# Erzwingt fd für die Dateisuche (Strg+T)
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

# Falls du das Plugin "fzf.fish" nutzt, braucht es oft diese Variable:
set -gx fzf_fd_opts --hidden --exclude .git

set -gx fzf_preview_file_cmd bat --style=numbers --color=always --line-range :500
set -gx fzf_preview_dir_cmd eza --all --color=always --icons

set -gx EDITOR nvim
# 2. Tastenbelegung neu ordnen (Weg von Strg+Alt+F)
# Wir binden die Funktionen auf die klassischen Kürzel:
# Strg+T = Dateien, Strg+R = Historie, Alt+C = Ordner
fzf_configure_bindings --directory=\ct --history=\cr --variables=\cv

# yazi-terminal-cwd
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
