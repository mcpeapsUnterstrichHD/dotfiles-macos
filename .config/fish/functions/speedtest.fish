function speedtest --description 'Run speedtest with separator decoration'
    set -l sep_script "$HOME/exe/separator/sep.sh"
    if test -f "$sep_script"
        bash "$sep_script" | pv -qL 1000 | lolcat
    end
    /opt/homebrew/bin/speedtest --share --server 31469 --secure $argv
    if test -f "$sep_script"
        bash "$sep_script" | pv -qL 1000 | lolcat
    end
end
