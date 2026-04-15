function yy --description 'Yazi file manager with directory change on exit'
    set -l tmp (mktemp -t "yazi-cwd.XXXXXX")
    set -l had_zellij 0
    if set -q ZELLIJ
        set had_zellij 1
    end
    set -gx ZELLIJ true
    yazi $argv --cwd-file="$tmp"
    if test $had_zellij -eq 0
        set -e ZELLIJ
    end
    if test -f "$tmp"
        set -l cwd (cat "$tmp")
        if test -n "$cwd"; and test "$cwd" != (pwd)
            cd "$cwd"
        end
    end
    rm -f "$tmp"
end
