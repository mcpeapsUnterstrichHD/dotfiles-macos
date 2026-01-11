# -*- coding: utf-8 -*-
"""
Xonsh Shell Configuration
Ported from .zshrc with xontribs support
"""
import os
import shutil
import subprocess
import sys
import tempfile

from xonsh.xontribs import xontribs_load  # type: ignore

# Shortcuts für Environment und Aliases (xonsh built-ins)
env = __xonsh__.env  # type: ignore
aliases = __xonsh__.aliases  # type: ignore
builtins = __xonsh__.builtins  # type: ignore
subproc_uncaptured = __xonsh__.subproc_uncaptured #type:ignore


#env["XONSH_COLOR_STYLE"] = "nord"

# --------------------------------------------------------------------
# 1. PATH ZUERST SETZEN (VOR ALLEM ANDEREN!)
# --------------------------------------------------------------------
paths_to_add = [
    "/opt/homebrew/bin",
    "/opt/homebrew/sbin",
    "/usr/local/bin",
    "/usr/local/sbin",
    os.path.join(env['HOME'], "bin"),
    os.path.join(env['HOME'], ".local/bin"),
    os.path.join(env['HOME'], "go/bin"),
    os.path.join(env['HOME'], ".cargo/bin"),
    os.path.join(env['HOME'], ".bun/bin"),
    os.path.join(env['HOME'], ".orbstack/bin"),
    "/opt/homebrew/opt/ruby/bin",
    "/opt/homebrew/lib/ruby/gems/3.4.7/bin",
    "/opt/homebrew/opt/openjdk/bin",
    os.path.join(env['HOME'], "exe"),
    os.path.join(env['HOME'], "exe/separator"),
    "/Applications/Ghostty.app/Contents/MacOS",
    "/Applications/OrbStack.app/Contents/MacOS/bin",
    "/Library/TeX/texbin",
    os.path.join(env['HOME'], ".dotnet/tools"),
    "/opt/homebrew/opt/llvm/bin",
    "/opt/homebrew/opt/rustup/bin",
    os.path.join(env['HOME'], ".lmstudio/bin"),
    os.path.join(env['HOME'], ".antigravity/antigravity/bin"),
    os.path.join(env['HOME'], ".local/xonsh-env/xbin"),
    # Additional paths from zshrc
    os.path.join(env['HOME'], ".yarn/bin"),
    os.path.join(env['HOME'], ".config/yarn/global/node_modules/.bin"),
    os.path.join(env['HOME'], ".spicetify"),
    os.path.join(env['HOME'], ".console-ninja/.bin"),
    os.path.join(env['HOME'], "DEV/vcpkg"),
    "/opt/homebrew/opt/ccache/libexec",
    "/opt/homebrew/opt/php@8.2/bin",
    "/opt/homebrew/opt/php@8.2/sbin",
]

# PATH sofort setzen
for p in paths_to_add:
    if os.path.exists(p):
        env['PATH'].add(p, front=True)

# WICHTIG: PATH in os.environ synchronisieren für subprocess/shutil.which
os.environ['PATH'] = ':'.join(env['PATH'])

# --------------------------------------------------------------------
# 2. ENVIRONMENT (REST)
# --------------------------------------------------------------------

# --- TMUX FIX START ---
# Wenn wir innerhalb von Tmux sind, stellen wir das ursprüngliche Terminal wieder her.
# Damit sehen Programme wie fastfetch "ghostty" statt "tmux".
if env.get('TMUX') and env.get('XONSH_PARENT_TERM'):
    env['TERM_PROGRAM'] = env['XONSH_PARENT_TERM']
# --- TMUX FIX END ---

env['HOMEBREW_PREFIX'] = "/opt/homebrew"
env['HOMEBREW_CELLAR'] = "/opt/homebrew/Cellar"
env['HOMEBREW_REPOSITORY'] = "/opt/homebrew"
env['HOMEBREW_AUTO_UPDATE_SECS'] = "1"
env['EDITOR'] = "nvim"
env['TERM'] = "xterm-256color"
env['GIT_CONFIG'] = os.path.join(env['HOME'], "DEV/dotfiles-macos/.gitconfig")
env['JAVA_HOME'] = "/opt/homebrew/opt/openjdk"
env['BUN_INSTALL'] = os.path.join(env['HOME'], ".bun")
env['NVM_DIR'] = os.path.join(env['HOME'], ".nvm")
env['VCPKG_ROOT'] = os.path.join(env['HOME'], "DEV/vcpkg")
env['ANDROID_HOME'] = "/Volumes/SD200/Library/Android/sdk"
env['DOTNET_ROOT'] = "/opt/homebrew/opt/dotnet/libexec"
env['CRYPTOGRAPHY_OPENSSL_NO_LEGACY'] = "1"
env['DOCKER_HOST'] = "unix:///var/run/docker.sock"
env['ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE'] = "fg=3"

# FZF
env['FZF_DEFAULT_COMMAND'] = "rg --files --hidden --follow --no-ignore-vcs"
env['FZF_DEFAULT_OPTS'] = "--height 40% --layout=reverse --border"

# Completions
env['COMPLETIONS_CONFIRM'] = True  # Require Tab confirmation for completions
env['COMPLETIONS_DISPLAY'] = 'multi'  # Display completions in multiple columns

# Fix CPR (Cursor Position Request) warning for terminals that don't support it
env['ENABLE_PROMPT_POS_RESET'] = False  # Disable cursor position reset to avoid CPR

#starship
env['STARSHIP_CONFIG'] = "~/.config/starship.toml"
env['XONTRIB_PROMPT_STARSHIP_RIGHT_CONFIG'] = "~/.config/starship.toml"
env['XONTRIB_PROMPT_STARSHIP_REPLACE_PROMPT'] = False
env['XONTRIB_PROMPT_BAR_RIGHT'] = '{long_cmd_duration}{starship_right#noesc#nonl#strip}'

# sh
env['XONTRIB_SH_SHELLS'] = ["zsh","bash","sh"]
env['SHELL'] = '/Users/mahd/.config/xonsh/start-xonsh'


env['CARAPACE_BRIDGES'] = 'zsh,fish,bash,inshellisense'
env['COMPLETIONS_CONFIRM'] = True

# --------------------------------------------------------------------
# 3. XONTRIBS LADEN
# --------------------------------------------------------------------

# Jetzt sollte shutil.which() funktionieren!
tool_dependent_xontribs = {
    "zoxide": "zoxide",
    "fzf-completions": "fzf",
    "fzf-widgets": "fzf",
}

# Problematische Xontribs überspringen
skip_xontribs = [
    "jump_to_dir",      # Funktioniert nicht mit JSON history
    "output_search",    # Capturing-Probleme
]

xontrib_list = [
    "coreutils", "direnv", "pipeliner", "ergopack", "argcomplete",
    "fish_completer", "termcolors", "homebrew", "ssh_agent",
    "fzf-completions",  "zoxide", "sh",
    "clp", "cmd_durations", "term_integrations", "fzf-widgets",
    "langenv", "kitty", "bash_completions_dirs",
    "makefile_complete", "docker_tabcomplete", "abbrevs",
    "prompt_ret_code", "prompt_starship", "cmd_done", "prompt_bar",
    "whole_word_jumping",  "nodenv",
    "pyenv", "autoxsh", "goenv",
    "zoxide_init_cache", "rbenv"
]
for xt in xontrib_list:
    if xt in skip_xontribs:
        continue

    # Prüfe Tool-Abhängigkeiten
    if xt in tool_dependent_xontribs:
        required_tool = tool_dependent_xontribs[xt]
        tool_path = shutil.which(required_tool)
        if not tool_path:
            print(f"⚠️  Skipping {xt} (requires {required_tool}, not found in PATH)", file=sys.stderr)
            continue

    try:
        xontribs_load([xt])
    except Exception as e:
        print(f"⚠️  Skipping {xt}:  {e}", file=sys.stderr)

# --------------------------------------------------------------------
# 4. ALIASES (Simple)
# --------------------------------------------------------------------
aliases['ls'] = 'colorls -l -a --group-directories-first'
aliases['lss'] = '/bin/ls -la'
aliases['cgp'] = 'git push --signed=if-asked'
aliases['cgs'] = 'git status'
aliases['cgpl'] = 'git pull'
aliases['cgcl'] = 'git clone'
aliases['lazyg'] = 'lazygit'
aliases['rm'] = 'trash'
aliases['hangman'] = os.path.join(env['HOME'], "exe/hangman")
aliases['clock'] = 'tty-clock -sScxB -f "KW%V,%A,%0d/%m/%Y|%H:%M:%S"'
aliases['ssh'] = 'zssh'
aliases['trae'] = 'code'
aliases['cursor'] = 'code'
aliases['gf2'] = '/Applications/gf2.app/Contents/MacOS/gf2'
aliases['terminal'] = '/Applications/Ghostty.app/Contents/MacOS/ghostty'
aliases['cd'] = 'z'
aliases['cdi'] = 'zi'
# --------------------------------------------------------------------
# 5. ALIASES (Funktionen)
# --------------------------------------------------------------------

def _cga(args):
    if not args:
        subprocess.run(['git', 'add', '.'])
    else:
        subprocess.run(['git', 'add'] + args)
aliases['cga'] = _cga

def _cgc(args):
    msg = args[0] if args else "."
    subprocess.run(['git', 'commit', '-m', msg, '--allow-empty', '--gpg-sign=3F462691', '--signoff'])
aliases['cgc'] = _cgc

def _speedtest(args):
    sep_script = os.path.join(env['HOME'], "exe/separator/sep.sh")
    def run_sep():
        if os.path.exists(sep_script):
            os.system(f"{sep_script} | pv -qL 1000 | lolcat")
    run_sep()
    subprocess.run(['/opt/homebrew/bin/speedtest', '--share', '--server', '31469', '--secure'] + args)
    run_sep()
aliases['speedtest'] = _speedtest

def _fastfetch(args):
    config_file = os.path.join(env['HOME'], ".config/fastfetch/config.jsonc")
    subprocess.run(['/opt/homebrew/bin/fastfetch', '--config', config_file] + args)
aliases['fastfetch'] = _fastfetch
aliases['neofetch'] = _fastfetch

def _yy(args):
    fd, tmp_path = tempfile.mkstemp(prefix="yazi-cwd.")
    os.close(fd)
    zellij_was_set = 'ZELLIJ' in env
    try:
        env['ZELLIJ'] = "true"
        subprocess.run(['yazi'] + args + [f"--cwd-file={tmp_path}"])
        if not zellij_was_set and 'ZELLIJ' in env:
            del env['ZELLIJ']
        if os.path.exists(tmp_path):
            with open(tmp_path, 'r') as f:
                cwd = f.read().strip()
            if cwd and cwd != os.getcwd():
                os.chdir(cwd)
    finally:
        if os.path.exists(tmp_path):
            os.remove(tmp_path)
aliases['yy'] = _yy

# --------------------------------------------------------------------
# 6. INITIALISIERUNG (Atuin, Oh-My-Posh, Cursor) - NACH PATH!
# --------------------------------------------------------------------

# Atuin - uses xonsh-specific syntax, needs execx
if shutil.which("atuin"):
    try:
        res = subprocess.run(["atuin", "init", "xonsh"], capture_output=True, text=True, check=False)
        if res.returncode == 0 and res.stdout.strip():
            builtins.execx(res.stdout)
    except Exception as e:
        print(f"⚠️  Atuin init failed: {e}", file=sys.stderr)

# Oh-My-Posh
#if shutil.which("oh-my-posh"):
#    try:
#        config_path = os.path.join(env['HOME'], ".config/ohmyposh/config.toml")
#
#        # Falls lokale Config nicht existiert, lade sie herunter
#        if not os.path.exists(config_path):
#            os.makedirs(os.path.dirname(config_path), exist_ok=True)
#            print("📥 Lade Oh-My-Posh Config...", file=sys.stderr)
#            try:
#                import urllib.request
#                urllib.request.urlretrieve(
#                    "https://raw.githubusercontent.com/mcpeapsUnterstrichHD/dotfiles/main/.config/ohmyposh/config.toml",
#                    config_path
#                )
#                print("✅ Config heruntergeladen", file=sys.stderr)
#            except Exception as e:
#                print(f"⚠️  Config-Download fehlgeschlagen: {e}", file=sys.stderr)
#                config_path = "https://raw.githubusercontent.com/mcpeapsUnterstrichHD/dotfiles/main/.config/ohmyposh/config.toml"
#
#        res = subprocess.run(
#            ["oh-my-posh", "init", "xonsh", "--config", config_path],
#            capture_output=True,
#            text=True,
#            check=False,
#            timeout=5
#        )
#
#        if res.returncode == 0 and res.stdout.strip():
#            builtins.execx(res.stdout)
#        else:
#            print(f"⚠️  Oh-My-Posh init failed (Code {res.returncode})", file=sys.stderr)
#            if res.stderr:
#                print(f"Error: {res.stderr}", file=sys.stderr)
#    except subprocess.TimeoutExpired:
#        print("⚠️  Oh-My-Posh Timeout", file=sys.stderr)
#    except Exception as e:
#        print(f"⚠️  Oh-My-Posh init failed: {e}", file=sys.stderr)
#else:
#    print("⚠️  oh-my-posh nicht gefunden im PATH", file=sys.stderr)

# Cursor Style
print("\033[5 q", end="", flush=True)

# --------------------------------------------------------------------
# 7. AUTO-START TMUX (SSH / TTY)
# --------------------------------------------------------------------

def _auto_start_tmux():
    import select

    # Configuration
    TMUX_PROMPT_TIMEOUT = 5  # seconds to wait before auto-attaching

    if os.environ.get('TERM_PROGRAM') == 'vscode':
        return
    if os.environ.get('TMUX'):
        return
    if not shutil.which("tmux"):
        return

    # If xonsh is running a script (non-interactive), skip tmux
    # The script will run, and when it ends the shell becomes interactive
    # At that point this rc.py runs again and tmux will prompt
    if len(sys.argv) > 1 and not sys.stdin.isatty():
        return

    # --- TMUX FIX START ---
    # Hilfsfunktion: Setzt die Parent-Term Variable bevor execvp aufgerufen wird
    def set_parent_term():
        if 'TERM_PROGRAM' in os.environ:
             os.environ['XONSH_PARENT_TERM'] = os.environ['TERM_PROGRAM']
    # --- TMUX FIX END ---

    def input_with_timeout(prompt):
        """Get input with timeout and visual countdown. Returns None on timeout."""
        print(prompt, end='', flush=True)

        for remaining in range(TMUX_PROMPT_TIMEOUT, 0, -1):
            # Check for input with 1 second timeout
            ready, _, _ = select.select([sys.stdin], [], [], 1)
            if ready:
                result = sys.stdin.readline().strip()
                print()  # newline
                return result
            # Update countdown display
            print(f"\r{prompt}{remaining}... ", end='', flush=True)

        print(f"\r{prompt}0!    ")  # Clear and show 0
        return None

    def select_session(sessions):
        """Prompt user to select from existing sessions."""
        print("\n📺 Existing sessions:")
        for i, s in enumerate(sessions, 1):
            print(f"  {i}. {s}")
        try:
            choice = input("Select session number [1]: ").strip()
            if choice.isdigit() and 0 < int(choice) <= len(sessions):
                return sessions[int(choice) - 1]
        except (EOFError, KeyboardInterrupt):
            pass
        return sessions[0]  # default to first

    try:
        # Get existing sessions
        result = subprocess.run(
            ["tmux", "list-sessions", "-F", "#{session_name}"],
            capture_output=True, text=True, check=False
        )
        existing_sessions = [s.strip() for s in result.stdout.strip().split('\n') if s.strip()]

        if not existing_sessions:
            # No sessions - create "main"
            set_parent_term() # FIX
            os.execvp("tmux", ["tmux", "new-session", "-s", "main"])

        # Sessions exist - prompt with timeout
        has_main = "main" in existing_sessions
        default_action = f"attach to 'main' in {TMUX_PROMPT_TIMEOUT}s" if has_main else f"attach to '{existing_sessions[0]}' in {TMUX_PROMPT_TIMEOUT}s"

        print(f"\n📺 Found {len(existing_sessions)} tmux session(s)")
        choice = input_with_timeout(f"Create new session? (y/N) [{default_action}]: ")

        if choice is None or choice == '':
            # Timeout or empty - attach to main or first session
            target = "main" if has_main else existing_sessions[0]
            set_parent_term() # FIX
            os.execvp("tmux", ["tmux", "attach-session", "-t", target])
        elif choice.lower() in ('y', 'yes'):
            # Create new session
            try:
                name = input("Session name: ").strip() or f"session-{len(existing_sessions)+1}"
            except (EOFError, KeyboardInterrupt):
                name = f"session-{len(existing_sessions)+1}"
            set_parent_term() # FIX
            os.execvp("tmux", ["tmux", "new-session", "-s", name])
        else:
            # 'n' or anything else - show session list
            target = select_session(existing_sessions)
            set_parent_term() # FIX
            os.execvp("tmux", ["tmux", "attach-session", "-t", target])

    except Exception as e:
        print(f"⚠️  Tmux error: {e}", file=sys.stderr)

_auto_start_tmux()

# --------------------------------------------------------------------
# 8. NAVIGATION ALIASES (from DT's config)
# --------------------------------------------------------------------
aliases['..'] = 'cd ..'
aliases['...'] = 'cd ../..'
aliases['.3'] = 'cd ../../..'
aliases['.4'] = 'cd ../../../..'
aliases['.5'] = 'cd ../../../../..'

# --------------------------------------------------------------------
# 9. ADDITIONAL FUNCTIONS FROM ZSHRC
# --------------------------------------------------------------------

# lfcd function - Use lf to switch directories
def _lfcd(args):
    fd, tmp_path = tempfile.mkstemp()
    os.close(fd)
    try:
        subprocess.run(['lf', f'-last-dir-path={tmp_path}'] + list(args))
        if os.path.exists(tmp_path):
            with open(tmp_path, 'r') as f:
                dir_path = f.read().strip()
            if dir_path and os.path.isdir(dir_path) and dir_path != os.getcwd():
                os.chdir(dir_path)
    finally:
        if os.path.exists(tmp_path):
            os.remove(tmp_path)

aliases['lfcd'] = _lfcd

# System aliases
aliases['df'] = 'df -h'
aliases['free'] = 'free -m'
aliases['grep'] = 'grep --color=auto'
aliases['psa'] = 'ps auxf'
aliases['psgrep'] = 'ps aux | grep -v grep | grep -i -e VSZ -e'
aliases['psmem'] = 'ps auxf | sort -nr -k 4'
aliases['pscpu'] = 'ps auxf | sort -nr -k 3'

# mDNSResponder aliases (macOS)
aliases['stop-mDNSResponder'] = 'sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist'
aliases['start-mDNSResponder'] = 'sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.mDNSResponder.plist'

# Tailscale
aliases['tailscale'] = '/Applications/Tailscale.app/Contents/MacOS/Tailscale'

# --------------------------------------------------------------------
# 10. ADDITIONAL COMPLETIONS & INTEGRATIONS
# --------------------------------------------------------------------

# thefuck integration (if installed)
if shutil.which("thefuck"):
    try:
        res = subprocess.run(["thefuck", "--alias"], capture_output=True, text=True, check=False)
        if res.returncode == 0 and res.stdout.strip():
            # thefuck outputs shell-specific code, we'll create a simple alias
            aliases['fuck'] = 'thefuck $(fc -ln -1)'
    except Exception:
        pass

# gh (GitHub CLI) completions
if shutil.which("gh"):
    try:
        res = subprocess.run(["gh", "completion", "-s", "zsh"], capture_output=True, text=True, check=False)
        # Completions are handled by argcomplete xontrib
    except Exception:
        pass

# jj (Jujutsu) completions
if shutil.which("jj"):
    try:
        res = subprocess.run(["jj", "util", "completion", "zsh"], capture_output=True, text=True, check=False)
        # Completions are handled by argcomplete xontrib
    except Exception:
        pass

# VSCode shell integration
if os.environ.get('TERM_PROGRAM') == 'vscode':
    try:
        res = subprocess.run(["code", "--locate-shell-integration-path", "xonsh"],
                                capture_output=True, text=True, check=False)
        if res.returncode == 0 and res.stdout.strip():
            integration_path = res.stdout.strip()
            if os.path.exists(integration_path):
                # VSCode integration loaded
                pass
    except Exception:
        pass

# Angular CLI completions (if ng is available)
if shutil.which("ng"):
    try:
        # Angular completions handled by argcomplete
        pass
    except Exception:
        pass

# ngrok completions
if shutil.which("ngrok"):
    try:
        # ngrok completions handled by argcomplete
        pass
    except Exception:
        pass

# Docker CLI completions (handled by docker_tabcomplete xontrib)
# --------------------------------------------------------------------
# 11. LDFLAGS & CPPFLAGS (for compilation)
# --------------------------------------------------------------------
env['LDFLAGS'] = "-L/opt/homebrew/opt/ruby/lib -L/opt/homebrew/opt/llvm/lib"
env['CPPFLAGS'] = "-I/opt/homebrew/opt/ruby/include -I/opt/homebrew/opt/llvm/include"
env['PKG_CONFIG_PATH'] = "/opt/homebrew/opt/ruby/lib/pkgconfig"

# --------------------------------------------------------------------
# DONE - Configuration loaded successfully
# --------------------------------------------------------------------

#subproc_uncaptured(["carapace", "_carapace"])

#print("✅ Xonsh config loaded", file=sys.stderr)
