# Fish Shell Configuration
# Ported from xonsh rc.py + .xonshrc

# ────────────────────────────────────────────────────────────────
# 1. PATH
# ────────────────────────────────────────────────────────────────
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /usr/local/bin
fish_add_path /usr/local/sbin
fish_add_path /opt/local/bin
fish_add_path /opt/local/sbin
fish_add_path $HOME/bin
fish_add_path $HOME/.local/bin
fish_add_path $HOME/go/bin
fish_add_path $HOME/.cargo/bin
fish_add_path $HOME/.bun/bin
fish_add_path $HOME/.orbstack/bin
fish_add_path /opt/homebrew/opt/ruby/bin
fish_add_path /opt/homebrew/lib/ruby/gems/3.4.7/bin
fish_add_path /opt/homebrew/opt/openjdk/bin
fish_add_path $HOME/exe
fish_add_path $HOME/exe/separator
fish_add_path /Applications/Ghostty.app/Contents/MacOS
fish_add_path /Applications/OrbStack.app/Contents/MacOS/bin
fish_add_path /Library/TeX/texbin
fish_add_path $HOME/.dotnet/tools
fish_add_path /opt/homebrew/opt/llvm/bin
fish_add_path /opt/homebrew/opt/rustup/bin
fish_add_path $HOME/.lmstudio/bin
fish_add_path $HOME/.antigravity/antigravity/bin
fish_add_path $HOME/.spicetify
fish_add_path $HOME/.console-ninja/.bin
fish_add_path $HOME/DEV/vcpkg
fish_add_path /opt/homebrew/opt/ccache/libexec
fish_add_path /opt/homebrew/opt/php@8.2/bin
fish_add_path /opt/homebrew/opt/php@8.2/sbin
fish_add_path $HOME/.config/emacs/bin
fish_add_path /opt/homebrew/opt/emacs-plus@30/bin
fish_add_path /opt/homebrew/opt/pnpm/bin
fish_add_path /opt/homebrew/opt/pnpm
fish_add_path /opt/homebrew/opt/bzip2/bin
fish_add_path /opt/homebrew/opt/libpng/bin
fish_add_path /opt/homebrew/opt/freetype2/bin
#fish_config theme choose agnoster
omf theme agnoster

# Environment manager shims
if command -q pyenv
    fish_add_path $HOME/.pyenv/shims
    set -gx PYENV_SHELL fish
end
if command -q nodenv
    fish_add_path $HOME/.nodenv/shims
    set -gx NODENV_SHELL fish
end
if command -q goenv
    fish_add_path $HOME/.goenv/shims
    set -gx GOENV_SHELL fish
end
if command -q rbenv
    fish_add_path $HOME/.rbenv/shims
    set -gx RBENV_SHELL fish
end

# ────────────────────────────────────────────────────────────────
# 2. ENVIRONMENT VARIABLES
# ────────────────────────────────────────────────────────────────
set -gx HOMEBREW_PREFIX /opt/homebrew
set -gx HOMEBREW_CELLAR /opt/homebrew/Cellar
set -gx HOMEBREW_REPOSITORY /opt/homebrew
set -gx HOMEBREW_AUTO_UPDATE_SECS 1
set -gx EDITOR "emacsclient -c -a \"emacs\""
set -gx VISUAL "emacsclient -c -a \"emacs\""
set -gx TERM xterm-256color
set -gx GIT_CONFIG $HOME/DEV/dotfiles-macos/.gitconfig
set -gx JAVA_HOME $(brew --prefix openjdk)
set -gx BUN_INSTALL $HOME/.bun
set -gx NVM_DIR $HOME/.nvm
set -gx VCPKG_ROOT $HOME/DEV/vcpkg
set -gx ANDROID_HOME $HOME/Library/Android/sdk
set -gx DOTNET_ROOT /opt/homebrew/opt/dotnet/libexec
set -gx CRYPTOGRAPHY_OPENSSL_NO_LEGACY 1
set -gx DOCKER_HOST unix:///var/run/docker.sock
set -gx PNPM_HOME /opt/homebrew/opt/pnpm

# FZF
set -gx FZF_DEFAULT_COMMAND "rg --files --hidden --follow --no-ignore-vcs"
set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border"

# Compilation flags
set -gx LDFLAGS "-L/opt/homebrew/opt/ruby/lib -L/opt/homebrew/opt/llvm/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/ruby/include -I/opt/homebrew/opt/llvm/include"

# 1. Den Haupt-Pfad von Homebrew ermitteln
set -l HOMEBREW_PREFIX (brew --prefix)

# 2. Den Standard-pkgconfig-Pfad hinzufügen
set -gx PKG_CONFIG_PATH "$HOMEBREW_PREFIX/lib/pkgconfig:$PKG_CONFIG_PATH"

# 3. Finde alle pkgconfig Ordner nur innerhalb von Homebrew und füge sie hinzu
for pc_dir in (find "$HOMEBREW_PREFIX/opt" -maxdepth 3 -type d -name "pkgconfig" 2>/dev/null)
    set -gx PKG_CONFIG_PATH "$pc_dir:$PKG_CONFIG_PATH"
end


# TMUX fix: restore original terminal for programs like fastfetch
if set -q TMUX; and set -q FISH_PARENT_TERM
    set -gx TERM_PROGRAM $FISH_PARENT_TERM
end

set -g theme_svn_prompt_enabled yes
set -g fish_git_prompt_untracked_files no

# ────────────────────────────────────────────────────────────────
# 3. ALIASES
# ────────────────────────────────────────────────────────────────
alias ls 'colorls -l -a --group-directories-first'
alias lss '/bin/ls -la'
alias cgp 'git push --signed=if-asked'
alias cgs 'git status'
alias cgpl 'git pull'
alias cgcl 'git clone'
alias lazyg lazygit
alias rm trash
alias hangman "$HOME/exe/hangman"
alias clock 'tty-clock -sScxB -f "KW%V,%A,%0d/%m/%Y|%H:%M:%S"'
alias ssh zssh
alias trae code
alias cursor code
alias gf2 '/Applications/gf2.app/Contents/MacOS/gf2'
alias terminal '/Applications/Ghostty.app/Contents/MacOS/ghostty'
alias edit 'emacsclient -c -a "emacs"'
alias tailscale '/Applications/Tailscale.app/Contents/MacOS/Tailscale'

# Navigation
alias .. 'cd ..'
alias ... 'cd ../..'
alias .3 'cd ../../..'
alias .4 'cd ../../../..'
alias .5 'cd ../../../../..'

# System aliases
alias df 'df -h'
alias grep 'grep --color=auto'
alias psa 'ps auxf'
alias psgrep 'ps aux | grep -v grep | grep -i -e VSZ -e'
alias psmem 'ps auxf | sort -nr -k 4'
alias pscpu 'ps auxf | sort -nr -k 3'

# mDNSResponder (macOS)
alias stop-mDNSResponder 'sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist'
alias start-mDNSResponder 'sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist'

# ────────────────────────────────────────────────────────────────
# 4. INTERACTIVE-ONLY SETUP
# ────────────────────────────────────────────────────────────────
if status is-interactive

    if set -q TMUX
       tmux source-file ~/.tmux.conf
    end

    # Zoxide (smart cd)
    if command -q zoxide
        zoxide init fish --cmd cd | source
        #alias cdi zi
    end

    # Atuin (shell history)
    if command -q atuin
        atuin init fish | source
        atuin gen-completions --shell fish | source
    end

    # Oh-My-Posh prompt
    if command -q oh-my-posh
        oh-my-posh init fish --config "https://raw.githubusercontent.com/mcpeapsUnterstrichHD/dotfiles/main/.config/ohmyposh/config.toml" | source
    end

    # Direnv
    if command -q direnv
        direnv hook fish | source
    end

    # thefuck
    if command -q thefuck
        thefuck --alias | source
    end

    # FZF key bindings
    if command -q fzf
        fzf --fish | source
    end

    # gh (GitHub CLI) completions
    if command -q gh
        gh completion -s fish | source
    end

    # jj (Jujutsu) completions
    if command -q jj
        jj util completion fish | source
    end

    # ngrok completions
    #if command -q ngrok
    #    ngrok completion | source
    #end

    # VSCode shell integration
    if test "$TERM_PROGRAM" = vscode
        if command -q code
            set -l integration_path (code --locate-shell-integration-path fish 2>/dev/null)
            if test -n "$integration_path"; and test -f "$integration_path"
                source "$integration_path"
            end
        end
    end

    # Cursor style (blinking bar)
    if isatty stdout
        printf '\e[5 q'
    end

    # ────────────────────────────────────────────────────────────
    # 5. TMUX AUTO-START
    # ────────────────────────────────────────────────────────────
    # Die Logik hängt am `fish_prompt` Event, damit sie erst ausgeführt wird,
    # wenn eventuelle Start-Kommandos vollständig abgeschlossen sind.
    function _auto_tmux --on-event fish_prompt
        # Event sofort entfernen, damit es nur beim ersten Start passiert
        functions -e _auto_tmux

        # Prüfen, ob wir tmux starten sollen (Überspringen in VSCode, Emacs, als Root etc.)
        if set -q TMUX; or set -q INSIDE_EMACS; or set -q VSCODE_PID; or test "$USER" = root; or test "$TERM_PROGRAM" = emacs; or test "$TERM_PROGRAM" = vscode; or test "$TERM_PROGRAM" = agy; or test "$TERM_PROGRAM" = antigravity; or test -n "$SSH_CONNECTION"; or test "$TERM_PROGRAM" = WarpTerminal; or test "$TERM_PROGRAM" = cmux
            return
        end

        set -l tp "$TERM_PROGRAM"
        if test "$tp" = agy; or test "$tp" = antigravity; or test "$tp" = vscode
            return
        end

        # Tmux Executable suchen
        set -l tmux_bin (command -v tmux 2>/dev/null)
        if test -z "$tmux_bin"
            if test -x /opt/homebrew/bin/tmux
                set tmux_bin /opt/homebrew/bin/tmux
            else if test -x /usr/local/bin/tmux
                set tmux_bin /usr/local/bin/tmux
            end
        end

        if test -n "$tmux_bin"; and isatty stdin
            # Existierende Sessions abrufen
            set -l sessions ($tmux_bin list-sessions -F '#{session_name}' 2>/dev/null)

            # Prüfen, ob "main" existiert
            set -l has_main 0
            for s in $sessions
                if test "$s" = main
                    set has_main 1
                end
            end

            # Ursprüngliches Terminal sichern
            if set -q TERM_PROGRAM
                set -gx FISH_PARENT_TERM $TERM_PROGRAM
            end

            if test $has_main -eq 0
                # Keine 'main' Session gefunden -> Abfrage überspringen und direkt 'main' erstellen
                exec $tmux_bin new-session -s main
            else
                # 'main' existiert -> Abfrage starten
                printf "\n📺 Vorhandene tmux Sessions:\n"
                set -l i 1
                for s in $sessions
                    printf "  %d. %s\n" $i $s
                    set i (math $i + 1)
                end
                printf "  n. Neue Session erstellen\n"

                # Abfrage (Warten auf Eingabe)
                read -P "Wähle eine Session (1-"(count $sessions)") oder 'n' für neu [main]: " -l choice

                if test -z "$choice"
                    # Bei reinem Enter standardmäßig mit 'main' verbinden
                    exec $tmux_bin attach-session -t main
                else if test "$choice" = "n"; or test "$choice" = "N"
                    # Neue Session anlegen
                    read -P "Name der neuen Session: " -l session_name
                    if test -z "$session_name"
                        set session_name "session-"(math (count $sessions) + 1)
                    end
                    exec $tmux_bin new-session -s $session_name
                else if test "$choice" -gt 0 2>/dev/null; and test "$choice" -le (count $sessions) 2>/dev/null
                    # Mit gewählter Nummer verbinden
                    exec $tmux_bin attach-session -t $sessions[$choice]
                else
                    # Fallback auf main bei ungültiger Eingabe
                    exec $tmux_bin attach-session -t main
                end
            end
        end
    end
end

# Added by LM Studio CLI (lms)
#set -gx PATH $PATH /Users/mahd/.lmstudio/bin
# End of LM Studio CLI section

# OpenClaw Completion
#source "/Users/mahd/.openclaw/completions/openclaw.fish"
