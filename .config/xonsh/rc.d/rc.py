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

start_xonsh = "/Users/mahd/DEV/dotfiles-macos/.config/xonsh/start-xonsh"

# Ensure all parent environment variables are loaded into Xonsh
for k, v in os.environ.items():
    env[k] = v

env["SHELL"] = start_xonsh

#env["XONSH_COLOR_STYLE"] = "nord"



# --------------------------------------------------------------------
# 1. PATH ZUERST SETZEN (VOR ALLEM ANDEREN!)
# --------------------------------------------------------------------
paths_to_add = [
    "/opt/homebrew/bin",
    "/opt/homebrew/sbin",
    "/usr/local/bin",
    "/usr/local/sbin",
    "/opt/local/bin",
    "/opt/local/sbin",
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
    os.path.join(env['HOME'], ".config/emacs/bin"),
    "/opt/homebrew/opt/emacs-plus@30/bin",
    "/opt/homebrew/opt/pnpm/bin","/opt/homebrew/opt/pnpm"
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
#env['EDITOR'] = "nvim"
env["EDITOR"] = "emacsclient -c -a \"emacs\""
env["VISUAL"] = "emacsclient -c -a \"emacs\""
env['TERM'] = "xterm-256color"
env['GIT_CONFIG'] = os.path.join(env['HOME'], "DEV/dotfiles-macos/.gitconfig")
env['JAVA_HOME'] = "/opt/homebrew/opt/openjdk"
env['BUN_INSTALL'] = os.path.join(env['HOME'], ".bun")
env['NVM_DIR'] = os.path.join(env['HOME'], ".nvm")
env['VCPKG_ROOT'] = os.path.join(env['HOME'], "DEV/vcpkg")
env['ANDROID_HOME'] = os.path.join(env['HOME'], "Library/Android/sdk")
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
env['ENABLE_PROMPT_POS_RESET'] = True  # Disable cursor position reset to avoid CPR

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

env['CONSOLE_NINJA_ENABLED'] = True
env['CONSOLE_NINJA_THEME'] = "dark"
env['CONSOLE_NINJA_LOG_LEVEL'] = 'verbose'
env['PNPM_HOME'] = '/opt/homebrew/opt/pnpm'


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
    "fzf-completions", "sh",
    "clp", "cmd_durations", "term_integrations", "fzf-widgets",
    "langenv", "kitty", "bash_completions_dirs",
    "makefile_complete", "docker_tabcomplete", "abbrevs",
    "prompt_ret_code", "prompt_starship", "cmd_done", "prompt_bar",
    "whole_word_jumping", "autoxsh",
    "zoxide_init_cache" #,"nvm"
]

# --------------------------------------------------------------------
# OPTIMIZATION: SKIP INTERACTIVE TOOLS IF NOT INTERACTIVE
# --------------------------------------------------------------------
# Fixes freezes in doom env / emacs by skipping zoxide, atuin, aliases, etc.
if not env.get('XONSH_INTERACTIVE'):
    # Load only essential xontribs for scripts (if any)
    # For now, we skip all heavy startup logic
    pass
else:
    # Only run this block in interactive sessions
    pass # Continue to sections below (indented)

# We need to restructure the file to indent the rest, OR use a 'sys.exit'/'return' if it was a function.
# Since it's a script, we can use a boolean guard or 'if' block.
# However, modifying the whole file indentation is risky/messy.
# A cleaner way: Check interactive status before each heavy block or exit early?
# 'exit' might kill the shell? No, usually just stops the RC execution?
# No, rc.py is just executed. Python 'sys.exit' exits the process!
# 'return' only works in functions.

# Best approach: Wrap sections 3, 4, 5, 6, 7... in an "if interactive:" block
# But that requires huge diffs.

# Alternative: Define a variable 'is_interactive' and check it.
# We also check for INSIDE_EMACS to ensure we never run heavy tools inside Emacs
# even if it thinks it is interactive (e.g. if vterm sets it).
is_interactive = env.get('XONSH_INTERACTIVE', False) and not os.environ.get('INSIDE_EMACS')


# --------------------------------------------------------------------
# 3a. MANUAL TOOL INITIALIZATION (zoxide, starship, etc)
# --------------------------------------------------------------------

if is_interactive:
    # Zoxide (Smart cd) - Manual Init to avoid xontrib issues
    if shutil.which("zoxide"):
        try:
            # Generate the init script
            res = subprocess.run(["zoxide", "init", "xonsh"], capture_output=True, text=True, check=False)
            if res.returncode == 0 and res.stdout:
                # Execute it
                builtins.execx(res.stdout)
        except Exception as e:
            print(f"⚠️  Manual zoxide init failed: {e}", file=sys.stderr)

# --------------------------------------------------------------------
# 3b. ENVIRONMENT MANAGERS (Manual Init to fix double-start issue)
# --------------------------------------------------------------------
# Tools like pyenv, nodenv, etc. needed xonsh to double-start to load envs properly.
# Manual init + sync ensures they work immediately.

def _manual_env_setup(tool_name, shim_path, shell_var_name=None):
    """Manually add shims to PATH and set SHELL env var."""
    if shutil.which(tool_name):
        # Add to PATH (prepend to override system binaries)
        env['PATH'].add(shim_path, front=True)
        # Check if we need to sync PATH manually to os.environ
        # (xonsh usually does this, but for subprocesses via doom env we want to be sure)
        if 'PATH' in env:
             os.environ['PATH'] = ':'.join(env['PATH'])

        # Set the SHELL variable if requested (e.g. PYENV_SHELL=xonsh)
        if shell_var_name:
            env[shell_var_name] = "xonsh"
            os.environ[shell_var_name] = "xonsh" # Sync explicitly

# Initialize tools explicitly (Native Xonsh way - no execution of bash scripts)
_manual_env_setup("pyenv",  os.path.join(env['HOME'], ".pyenv/shims"),  "PYENV_SHELL")
_manual_env_setup("nodenv", os.path.join(env['HOME'], ".nodenv/shims"), "NODENV_SHELL")
_manual_env_setup("goenv",  os.path.join(env['HOME'], ".goenv/shims"),  "GOENV_SHELL")
_manual_env_setup("rbenv",  os.path.join(env['HOME'], ".rbenv/shims"),  "RBENV_SHELL")

if is_interactive:
    for xt in xontrib_list:
        if xt in skip_xontribs:
            continue

        # Load xontrib directly - skipped dependency checks since they were flaky in rc.py
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
aliases['edit'] = 'emacsclient -c -a "emacs" '
#aliases['emacs'] = 'emacsclient -c -a "emacs"'
#aliases['nvm'] = """bash -c @(f'[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" && nvm {" ".join($args)}')"""
aliases['start-xonsh'] = start_xonsh
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

def _lsenv(args):
    """
    List environment variables, optionally filtered by a search string.
    Usage: lsenv [pattern]
    """
    pattern = args[0].lower() if args else None

    # Sort keys for better readability
    keys = sorted(env.keys())

    for k in keys:
        if pattern and pattern not in k.lower():
            continue
        print(f"\033[1;36m{k}\033[0m=\033[0;32m{env[k]}\033[0m")
aliases['lsenv'] = _lsenv

# --------------------------------------------------------------------
# 6. INITIALISIERUNG (Atuin, Oh-My-Posh, Cursor) - NACH PATH!
# --------------------------------------------------------------------

# Atuin - uses xonsh-specific syntax, needs execx
if is_interactive and shutil.which("atuin"):
    try:
        res = subprocess.run(["atuin", "init", "xonsh"], capture_output=True, text=True, check=False)
        if res.returncode == 0 and res.stdout.strip():
            builtins.execx(res.stdout)
    except Exception as e:
        print(f"⚠️  Atuin init failed: {e}", file=sys.stderr)

# Oh-My-Posh
# ... (existing commented out code) ...

# Cursor Style
if sys.stdout.isatty() and not os.environ.get('INSIDE_EMACS'):
    print("\033[5 q", end="", flush=True)

# --------------------------------------------------------------------
# 7. AUTO-START TMUX (SSH / TTY)
# --------------------------------------------------------------------

def _auto_start_tmux():
    import select

    # Configuration
    TMUX_PROMPT_TIMEOUT = 5  # seconds to wait before auto-attaching

    # Skip tmux auto-start if running inside Emacs
    if os.environ.get('INSIDE_EMACS') or os.environ.get('EMACS') == 't':
        return
    tp = os.environ.get('TERM_PROGRAM')

    if tp in ('agy', 'antigravity', 'vscode'):
        return
    if os.environ.get('TMUX'):
        return

    # Find tmux binary (robust check)
    tmux_bin = shutil.which("tmux")
    if not tmux_bin:
        # Fallback for Homebrew
        if os.path.exists("/opt/homebrew/bin/tmux"):
            tmux_bin = "/opt/homebrew/bin/tmux"
        elif os.path.exists("/usr/local/bin/tmux"):
            tmux_bin = "/usr/local/bin/tmux"

    if not tmux_bin:
        # print(f"⚠️  Skipping tmux auto-start: binary not found", file=sys.stderr)
        return

    # If xonsh is running a script (non-interactive), skip tmux
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
            [tmux_bin, "list-sessions", "-F", "#{session_name}"],
            capture_output=True, text=True, check=False
        )
        existing_sessions = [s.strip() for s in result.stdout.strip().split('\n') if s.strip()]

        if not existing_sessions:
            # No sessions - create "main"
            set_parent_term() # FIX
            os.execvp(tmux_bin, [tmux_bin, "new-session", "-s", "main"])

        # Sessions exist - prompt with timeout
        has_main = "main" in existing_sessions
        default_action = f"attach to 'main' in {TMUX_PROMPT_TIMEOUT}s" if has_main else f"attach to '{existing_sessions[0]}' in {TMUX_PROMPT_TIMEOUT}s"

        print(f"\n📺 Found {len(existing_sessions)} tmux session(s)")
        choice = input_with_timeout(f"Create new session? (y/N) [{default_action}]: ")

        if choice is None or choice == '':
            # Timeout or empty - attach to main or first session
            target = "main" if has_main else existing_sessions[0]
            set_parent_term() # FIX
            os.execvp(tmux_bin, [tmux_bin, "attach-session", "-t", target])
        elif choice.lower() in ('y', 'yes'):
            # Create new session
            try:
                name = input("Session name: ").strip() or f"session-{len(existing_sessions)+1}"
            except (EOFError, KeyboardInterrupt):
                name = f"session-{len(existing_sessions)+1}"
            set_parent_term() # FIX
            os.execvp(tmux_bin, [tmux_bin, "new-session", "-s", name])
        else:
            # 'n' or anything else - show session list
            target = select_session(existing_sessions)
            set_parent_term() # FIX
            os.execvp(tmux_bin, [tmux_bin, "attach-session", "-t", target])

    except Exception as e:
        print(f"⚠️  Tmux error: {e}", file=sys.stderr)

if is_interactive:
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

#aliases['source'] = 'source-bash'

# --------------------------------------------------------------------
# 10. ADDITIONAL COMPLETIONS & INTEGRATIONS
# --------------------------------------------------------------------

if is_interactive:
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

# CRITICAL: Final sync to ensure everything is exported
# _sync_env_to_os() # Removed to prevent crash

#subproc_uncaptured(["carapace", "_carapace"])

#print("✅ Xonsh config loaded", file=sys.stderr)
