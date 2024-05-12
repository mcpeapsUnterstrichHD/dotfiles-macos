


    # aliases
   #alias --save rparrot "curl parrot.live | pv -qL 1000 | lolcat"
   #alias --save rteleheck "telnet telehack.com | pv -qL 1000 | lolcat"
   #alias --save rwlanschool "python3.10 /Users/mahd/TicketAbfrage.py | pv -qL 1000 | lolcat"
   #alias --save brew-Syyu "brew update | pv -qL 1000 | lolcat && brew upgrade | pv -qL 1000 | lolcat"
   #alias --save wlanschool "python3.10 /Users/mahd/TicketAbfrage.py"
   #alias --save fireplace "docker run -it --rm fireplace -t 20 -f 60"
   #alias --save --save ngrokMinecraftServer "ngrok start --config /Users/mahd/.config/nrogk/ngrok.yml --region eu minecraft"

    # Commands to run in interactive sessions can go here
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>/Users/mahd/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export PATH="$HOME/•Local/bin" :$РАТН

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /opt/anaconda3/bin/conda
    eval /opt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/opt/anaconda3/etc/fish/conf.d/conda.fish"
        . "/opt/anaconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/opt/anaconda3/bin" $PATH
    end
end
# <<< conda initialize <<<

