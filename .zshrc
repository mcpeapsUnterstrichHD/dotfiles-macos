# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export GIT_CONFIG="$HOME/DEV/dotfiles/.gitconfig"
export GEM_HOME="$HOME/.gem/ruby/3.3.0"
export PATH="$GEM_HOME/bin:$PATH"
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
export EDITOR=nvim
export PATH="/Applications/:/Applications/c3:/:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="$HOME/exe:$PATH"
export PATH="$HOME/exe/separator:$PATH"
export PATH="/Applications/Alacritty.app/Contents/MacOS:$PATH"
export PATH="/Applications/Kitty.app/Contents/MacOS:$PATH"
export PATH=" /opt/homebrew/opt/ccache/libexec:$PATH"

# Setze den Terminal-Typ (optional, falls nötig)
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


alias ls="colorls -l -a --group-directories-first $*"
alias lss="/bin/ls -la $*"
alias speedtest="$HOME/exe/separator/sep.sh | pv -qL 1000 | lolcat && /opt/homebrew/bin/speedtest $* && $HOME/exe/separator/sep.sh | pv -qL 1000 | lolcat"
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
alias clock="date $*"



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



export PATH="/usr/local/opt/qt@5/bin:$PATH"
export LDFLAGS="$LDFLAGS -L/usr/local/opt/qt@5/lib"
export CPPFLAGS="$CPPFLAGS -I/usr/local/opt/qt@5/include"
export PKG_CONFIG_PATH="/usr/local/opt/qt@5/lib/pkgconfig:$PKG_CONFIG_PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ ! -r /Users/mahd/.opam/opam-init/init.zsh ]] || source /Users/mahd/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null

source <(zoxide init --cmd cd zsh)
source <(thefuck --alias)
source <(fzf --zsh)
source <(jj util completion zsh)
source <(atuin init zsh)
source <(atuin gen-completions -s zsh)
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
    local message="."

    # Handle the add part
    if [ -z "$1" ]; then
        git add .
    else
        git add "$1"
    fi

    # Check for the commit message
    if [[ "$*" == *"-m"* ]]; then
        message="${*##*-m }"  # Extract the message after -m
    else
        # Prompt for commit message if not provided
        read -e -p "Enter commit message [default: .]: " input_message
        # Use default message if input is empty
        message="${input_message:-.}"
    fi

    # Commit the changes
    git commit -m "$message" --allow-empty

    # Push the changes
    git push "${*//-m*/}"  # Pass all arguments except -m and its value
}

function sudo() {
    local attempts=0
    local messages=(
        "No problem, everyone has a moment like this."
        "A little slip, but you’re doing great!"
        "Almost there—give it another go."
        "Everyone makes mistakes; just try again!"
        "Don’t stress; just give it one more try."
        "You’re getting closer—keep going!"
        "Small hiccups happen; you’ve got this!"
        "Each attempt brings you closer to success."
        "It’s all part of the process; try once more!"
        "Perseverance pays off—let’s try again."
        "You’re doing well; just a little more effort."
        "Mistakes are just steps towards mastery."
        "Take it easy; you’re almost there!"
        "Focus and try again; you’re on the right track!"
        "Just a minor setback; success is near."
        "You’re improving with each attempt—keep it up!"
        "Stay positive; one more try might be all you need."
        "Errors are just learning opportunities—try again!"
        "You're making progress; don’t give up now!"
        "Almost there; your persistence will pay off!"
    )

    # ANSI-Farbcodes
    local RED='\033[0;31m'
    local YELLOW='\033[0;33m'
    local GREEN='\033[0;32m'
    local NC='\033[0m' # Kein Color (Reset)

    # Überprüfe, ob das Passwort im Cache ist
    if /usr/bin/sudo -n true 2>/dev/null; then
        # Führe den Befehl ohne Passwort erneut aus, wenn es im Cache ist
        /usr/bin/sudo "$@"
        return $?
    fi

    # Wenn Passwort benötigt wird, beginne den benutzerdefinierten Ablauf
    while [ $attempts -lt 3 ]; do
        # Fordere das Passwort manuell an
        printf "${GREEN}Password:󰟵${NC}"

        # Verstecke die Passworteingabe und stelle sicher, dass es keine Zeilenumbrüche gibt
        stty -echo
        IFS= read -r password_input
        stty echo
        printf "\n"  # Zeilenumbruch nach der Passworteingabe

        # Versuche, den sudo-Befehl mit dem Passwort auszuführen
        if echo "$password_input" | /usr/bin/sudo -S "$@" 2>/dev/null; then
            return 0
        fi

        # Falls sudo fehlschlägt, erhöhe den Versuchszähler
        ((attempts++))

        # Zeige eine zufällige Nachricht nach den ersten zwei Fehlversuchen
        if [ $attempts -lt 3 ]; then
            random_message=${messages[RANDOM % ${#messages[@]}]}
            printf "${YELLOW}%s${NC}\n" "$random_message"
        fi
    done

    # Nach dem dritten Fehlversuch beenden
    printf "${RED}sudo: 3 incorrect password attempts${NC}\n"
    return 1
}

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
