function cgc --description 'Git commit with GPG signing (defaults to "." message)'
    set -l msg "."
    if test (count $argv) -gt 0
        set msg "$argv"
    end
    git commit -m "$msg" --allow-empty --gpg-sign=3F462691 --signoff
end
