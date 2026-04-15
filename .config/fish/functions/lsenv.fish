function lsenv --description 'List environment variables, optionally filtered'
    set -l pattern ""
    if test (count $argv) -gt 0
        set pattern (string lower $argv[1])
    end

    for line in (set -gx | sort)
        if test -n "$pattern"
            set -l lower_line (string lower $line)
            if not string match -q "*$pattern*" $lower_line
                continue
            end
        end
        # Parse variable name and value
        set -l parts (string split " " -m 1 $line)
        if test (count $parts) -ge 2
            printf "\033[1;36m%s\033[0m=\033[0;32m%s\033[0m\n" $parts[1] $parts[2]
        else
            printf "\033[1;36m%s\033[0m\n" $parts[1]
        end
    end
end
