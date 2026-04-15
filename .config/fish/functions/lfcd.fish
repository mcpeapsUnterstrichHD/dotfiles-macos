function lfcd --description 'Use lf to switch directories'
    set -l tmp (mktemp)
    lf -last-dir-path="$tmp" $argv
    if test -f "$tmp"
        set -l dir (cat "$tmp")
        rm "$tmp"
        if test -d "$dir"; and test "$dir" != (pwd)
            cd "$dir"
        end
    end
end
