typeset -A ZI
ZI[BIN_DIR]="${HOME}/.zi/bin"
source "${ZI[BIN_DIR]}/zi.zsh"

autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export GIT_CONFIG="$HOME/DEV/dotfiles/.gitconfig"
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export HOMEBREW_AUTO_UPDATE_SECS=1;
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";
export DOCKER_HOST=unix:///var/run/docker.sock
export PATH="/usr/local/Cellar/llvm/10.0.1/bin/clangd:$PATH"
export PATH="usr/local/opt/llvm/bin/clangd:$PATH"
export PATH="/Users/mahd/go/bin:$PATH"
export PATH="$PATH:/usr/local/sbin"
export PATH="$PATH:/opt/homebrew/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="/opt/homebrew/sbin:$PATH"
export CLASSPATH=$CLASSPATH:/Library/Java/Extensions/mariadb-java-client-2.2.6.jar
# ~/.tmux/plugins
export PATH=$HOME/.tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
# ~/.config/tmux/plugins
export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
export PATH=/usr/local/bin/composer:$PATH
export EDITOR=$(which nvim)
export PATH="/Applications/:/Applications/c3:/:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="$HOME/exe:$PATH"
export PATH="$HOME/exe/separator:$PATH"
export PATH="/Applications/Alacritty.app/Contents/MacOS:$PATH"
export PATH="/Applications/Kitty.app/Contents/MacOS:$PATH"
export PATH=" /opt/homebrew/opt/ccache/libexec:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export PATH="/Applications/OrbStack.app/Contents/MacOS:/Applications/OrbStack.app/Contents/MacOS/bin:/Applications/OrbStack.app/Contents/MacOS/xbin:$PATH"
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1
#export PATH="/Users/mahd/dlang/dmd-nightly/osx/bin:$PATH"
#export PATH="/Users/mahd/dlang/ldc-1.40.1/bin:$PATH"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export LDFLAGS=""
export CPPFLAGS=""
export LDFLAGS="$LDFLAGS -L/opt/homebrew/opt/ruby/lib"
export CPPFLAGS="$CPPFLAGS -I/opt/homebrew/opt/ruby/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/ruby/lib/pkgconfig:$PKG_CONFIG_PATH"

#Setze den Terminal-Typ (optional, falls nötig)
export TERM=xterm-256color

# Alias für Alacritty
alias terminal='/Applications/Kitty.app/Contents/MacOS/kitty'

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH
export PATH=/usr/local/bin/vim:$PATH

# Set FZF Default to Ripgrep (must install ripgrep)
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --no-ignore-vcs"
# Set FZF DEFAULT OPTIONS
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"



#echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"


# Created by Zap installer
[ -f "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh" ] && source "${XDG_DATA_HOME:-$HOME/.local/share}/zap/zap.zsh"
plug "zsh-users/zsh-autosuggestions"
plug "zap-zsh/supercharge"
plug "zap-zsh/zap-prompt"
plug "zsh-users/zsh-syntax-highlighting"
plug "wintermi/zsh-brew"

# Load and initialise completion system
autoload -Uz compinit
compinit

if [[ ! -d ~/.zsh-autopair ]]; then
  git clone https://github.com/hlissner/zsh-autopair ~/.zsh-autopair
fi

source ~/.zsh-autopair/autopair.zsh
autopair-init

source $(dirname $(gem which colorls))/tab_complete.sh

source <(zoxide init --cmd cd --hook prompt zsh)
source <(thefuck --alias)
source <(fzf --zsh)
source <(jj util completion zsh)
source <(atuin init zsh)
source <(atuin gen-completions -s zsh)
#source ~/dlang/ldc-1.40.1/activate
#source ~/dlang/dmd-nightly/activate

alias ls="colorls -l -a --group-directories-first $*"
alias lss="/bin/ls -la $*"
alias speedtest="$HOME/exe/separator/sep.sh | pv -qL 1000 | lolcat && /opt/homebrew/bin/speedtest -s 30907 -a $* && $HOME/exe/separator/sep.sh | pv -qL 1000 | lolcat"
alias neofetch--speedtest="$HOME/exe/separator/sep.sh | pv -qL 1000 | lolcat && /opt/homebrew/bin/fastfetch --config $HOME/.config/fastfetch/config.jsonc  && $HOME/exe/separator/sep.sh | pv -qL 1000 | lolcat && /opt/homebrew/bin/speedtest  && $HOME/exe/separator/sep.sh | pv -qL 1000 | lolcat"
alias neofetch="$HOME/exe/separator/sep.sh | pv -qL 1000 | lolcat && /opt/homebrew/bin/fastfetch --config $HOME/.config/fastfetch/config.jsonc $* && $HOME/exe/separator/sep.sh | pv -qL 1000 | lolcat"
alias fastfetch="$HOME/exe/separator/sep.sh | pv -qL 1000 | lolcat && /opt/homebrew/bin/fastfetch --config $HOME/.config/fastfetch/config.jsonc $* && $HOME/exe/separator/sep.sh | pv -qL 1000 | lolcat"
alias stop-mDNSResponder="sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist"
alias start-mDNSResponder="sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist"
alias cga='if [ -z "$*" ]; then git add .; else git add $1; fi'
alias cgc='if [ -z "$*" ]; then git commit -m "." --allow-empty; else git commit -m "$*" --allow-empty; fi'
alias cgp='git push $*'
alias cgs='jj status $*'
alias cgpl='jj pull $*'
alias cgcl='jj git clone --colocate $*'
alias rm="/opt/homebrew/bin/trash $*"
alias rme="/opt/homebrew/bin/trash-empty $*"
alias hangman="$HOME/exe/hangman"
alias clock='tty-clock -sScxB -f "KW%V,%A,%0d/%m/%Y|%H:%M:%S"'
alias ssh="zssh $*"
alias trae="code $*"
alias cursor="code $*"

function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
source $(dirname $(gem which colorls))/tab_complete.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=3"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[[ ! -r /Users/mahd/.opam/opam-init/init.zsh ]] || source /Users/mahd/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null


if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  source <(oh-my-posh init zsh --config https://raw.githubusercontent.com/mcpeapsUnterstrichHD/dotfiles/main/.config/ohmyposh/config.toml)
fi

if command -v ngrok &>/dev/null; then
    source <(ngrok completion)
  fi

#eval $(/Applications/wgcf generate zsh)
export PATH="/opt/homebrew/opt/php@8.2/bin:$PATH"
export PATH="/opt/homebrew/opt/php@8.2/sbin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

if [[ ! "$TERM_PROGRAM" =~ "vscode" ]]; then
source <(zellij setup --generate-auto-start zsh)
fi
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk@21/bin:$PATH"

export PATH=$PATH:/Users/mahd/.spicetify

lazyg() {
    # Help function using printf
    display_help() {
        printf "Usage: lazyg [options] [file]\n"
        printf "\n"
        printf "A helper function for git operations.\n"
        printf "\n"
        printf "Options:\n"
        printf "  -m <message>    Specify the commit message.\n"
        printf "  -p <args>       Pass arguments to git push.\n"
        printf "  -h, --help      Display this help message.\n"
        printf "\n"
        printf "If no file is specified, all changes will be added.\n"
        printf "If no commit message is provided, the default message '.' will be used.\n"
    }

    # Check for help option
    if [[ "$1" == "-h" || "$1" == "--help" ]]; then
        display_help
        return 0
    fi

    local message="."
    local push_args=""
    local adding_all=true

    # Process command line arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            -m)
                shift
                if [[ -n "$1" ]]; then
                    message="$1"
                    shift
                fi
                ;;
            -p)
                shift
                push_args="$*"
                break
                ;;
            *)
                adding_all=false
                break
                ;;
        esac
    done

    # Handle git add
    if $adding_all; then
        git add .
    else
        git add "$1"
        shift
    fi

    # If push_args is not empty, remove the original push args from remaining arguments
    if [[ -n "$push_args" ]]; then
        set -- $push_args
    fi

    # Prompt for commit message if not provided
    if [[ "$message" == "." ]]; then
        printf "Enter commit message [default: .]: "
        read -e input_message
        message="${input_message:-.}"
    fi

    # Commit the changes
    git commit -m "$message" --allow-empty

    # Push the changes
    git push "$@"
}

#function sudo() {
#    local attempts=0
#    local messages=(
#        "No problem, everyone has a moment like this."
#        "A little slip, but you’re doing great!"
#        "Almost there—give it another go."
#        "Everyone makes mistakes; just try again!"
#        "Don’t stress; just give it one more try."
#        "You’re getting closer—keep going!"
#        "Small hiccups happen; you’ve got this!"
#        "Each attempt brings you closer to success."
#        "It’s all part of the process; try once more!"
#        "Perseverance pays off—let’s try again."
#        "You’re doing well; just a little more effort."
#        "Mistakes are just steps towards mastery."
#        "Take it easy; you’re almost there!"
#        "Focus and try again; you’re on the right track!"
#        "Just a minor setback; success is near."
#        "You’re improving with each attempt—keep it up!"
#        "Stay positive; one more try might be all you need."
#        "Errors are just learning opportunities—try again!"
#        "You're making progress; don’t give up now!"
#        "Almost there; your persistence will pay off!"
#    )
#
#    # ANSI-Farbcodes
#    local RED='\033[0;31m'
#    local YELLOW='\033[0;33m'
#    local GREEN='\033[0;32m'
#    local NC='\033[0m' # Kein Color (Reset)
#
#    # Überprüfe, ob das Passwort im Cache ist
#    if /usr/bin/sudo -n true 2>/dev/null; then
#        # Führe den Befehl ohne Passwort erneut aus, wenn es im Cache ist
#        /usr/bin/sudo "$@"
#        return $?
#    fi
#
#    # Wenn Passwort benötigt wird, beginne den benutzerdefinierten Ablauf
#    while [ $attempts -lt 3 ]; do
#        # Fordere das Passwort manuell an
#        printf "${GREEN}Password:󰟵${NC}"
#
#        # Verstecke die Passworteingabe und stelle sicher, dass es keine Zeilenumbrüche gibt
#        stty -echo
#        IFS= read -r password_input
#        stty echo
#        printf "\n"  # Zeilenumbruch nach der Passworteingabe
#
#        # Versuche, den sudo-Befehl mit dem Passwort auszuführen
#        if echo "$password_input" | /usr/bin/sudo -S "$@" 2>/dev/null; then
#            return 0
#        fi
#
#        # Falls sudo fehlschlägt, erhöhe den Versuchszähler
#        ((attempts++))
#
#        # Zeige eine zufällige Nachricht nach den ersten zwei Fehlversuchen
#        if [ $attempts -lt 3 ]; then
#            random_message=${messages[RANDOM % ${#messages[@]}]}
#            printf "${YELLOW}%s${NC}\n" "$random_message"
#        fi
#    done
#
#    # Nach dem dritten Fehlversuch beenden
#    printf "${RED}sudo: 3 incorrect password attempts${NC}\n"
#    return 1
#}

function yy() {
    export ZELLIJ="true"
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
    unset ZELLIJ
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd "$cwd"
	fi
	rm -f "$tmp"
    rme -f
}
eval "$(direnv hook zsh)"
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

function start-crafty-server() {
  echo "Starting the 'crafty' platform..."

  # Store the current working directory
  cpwd=$(pwd)

  # Navigate to the crafty project directory
  cd "$HOME/minecraft/crafty/" || { echo "Directory not found"; return 1; }

  # Activate conda environment "crafty"
  conda activate crafty

  # Activate virtual environment, if required
  source ".venv/bin/activate"

  # Navigate to the crafty-4 directory
  cd "crafty-4" || { echo "Directory crafty-4 not found"; return 1; }

  # Install Python dependencies from requirements.txt (quiet mode)
  pip3 install --no-cache-dir -r ./requirements.txt > /dev/null

  # Run Python script (keep it in the foreground for Ctrl+C)
  python3 main.py

  echo "The 'crafty' platform has been stopped"

  # After Ctrl+C, cleanup by deactivating the environments
  deactivate  # Deactivate .venv if used
  conda deactivate
  conda activate base

  # Return to the original working directory
  cd "$cpwd"

}

# bun completions
[ -s "/Users/mahd/.bun/_bun" ] && source "/Users/mahd/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

PATH=~/.console-ninja/.bin:$PATH
zi light-mode for \
  z-shell/z-a-meta-plugins \
  @annexes @zunit
