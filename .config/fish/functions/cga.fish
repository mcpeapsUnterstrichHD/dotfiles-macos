function cga --description 'Git add (defaults to . if no args)'
    if test (count $argv) -eq 0
        git add .
    else
        git add $argv
    end
end
