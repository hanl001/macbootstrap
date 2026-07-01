# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A personal macOS dev-environment bootstrap (forked from bestswifter/macbootstrap). It installs tools, applies macOS system defaults, and symlinks dotfiles from this repo into `$HOME`. The repo lives at `~/.macbootstrap` and that path is hard-coded in several places (`MACBOOTSTRAP_ROOT`).

There is no build step, no test suite, and no linter — it is shell scripts plus config files. The `test` function in `shell-src/base.sh` is a stub.

## Commands

Everything is driven through `manager.sh`, which is exposed in the interactive shell as the `hl` function. Run `hl help` for the full list. Key entry points:

- `hl setup` — full first-run: `setup_mac_config` → `install` → `link`
- `hl install` — check/install brew packages, oh-my-zsh, neovim, xcode snippets, cask apps (each is idempotent: checks for an existing binary/path before installing)
- `hl link` — symlink all configs into `$HOME` (git, shell, vim, lldb)
- `hl update` — `git pull -r` this repo and `~/.oh-my-zsh` (wrapped in stash/pop)
- `hl tx` — `cd` to the Xcode CodeSnippets dir

Sub-targets can be run individually, e.g. `hl link_vim`, `hl check_brew`, `hl link_git`.

The `hl` function resolves a short→long alias map in `_hl_resolve` (`shell-src/global/function.sh`, e.g. `l`→`link`, `i`→`install`, `u`→`update`, `tx` for the path jump), handles the `cd` target in-shell, and passes the resolved full command to `manager.sh`, which dispatches `$action "$@"`.

## Architecture

Three layers, kept strictly separate:

**1. `manager.sh` + `shell-src/*.sh` — the bootstrap logic.** `manager.sh` sources `base.sh`, `setup.sh`, `install.sh`, `update.sh`, `path.sh`, `link.sh` and dispatches the requested function. These files define the `setup`/`install`/`link`/`update` functions and are *only* loaded when you invoke `hl`/`manager.sh` — they are not in the interactive shell.

- `base.sh` — logging (`_log`, `log_run`, etc.) and `exe_cmd` (logs then `eval`s a command string). Almost every action is built by passing command strings to `exe_cmd`.
- `install.sh` — `check_*` functions; the convention is `if [[ ! -e <path> ]]; then install; else echo "you have ..."; fi`.
- `link.sh` — see the symlink convention below.

**2. `shell-src/global/*.sh` — the interactive shell runtime.** `config/sh-config/_zshrc` sources `shell-src/global/global.sh`, which in turn sources `ssh_agent.sh`, `config.sh`, `alias.sh`, `function.sh`. This is what defines `hl`, the aliases (`o`, `oo`, `la`, `vf`, …), PATH exports, and the ssh-agent auto-start. Edits here affect every new shell after the file is re-sourced.

**3. `config/` — dotfile sources, symlinked into `$HOME`.** Files are stored with a leading underscore (`_zshrc`, `_vimrc`, `_gitconfig`) and `link.sh` symlinks them to their dotfile name (`~/.zshrc`, `~/.vimrc`, …). When adding/renaming a config you must update the matching `ln -sf` in `link.sh`.

## Conventions that bite

- **The `_` prefix ↔ symlink contract.** A config file only takes effect once `link.sh` symlinks it. Adding a file under `config/` does nothing until you wire it into the relevant `link_*` function.
- **`_gitconfig` is special.** `link_git` *copies* `_gitconfig` → `.gitconfig` (only if absent), then symlinks `.gitconfig` → `~/.gitconfig`. `config/git-config/.gitconfig` is gitignored — it holds machine-local values, so never commit it and never overwrite an existing one.
- **`command/flutter` is a git submodule** (see `.gitmodules`); `command/phabricator/*` (arcanist, libphutil) are vendored third-party trees; `command/APPAnalyzeCommand` is a prebuilt Mach-O binary. Treat everything under `command/` as external — don't edit or "fix" it.
- **Editing shell behavior:** runtime user-facing changes go in `shell-src/global/`; one-time install/link/setup logic goes in the top-level `shell-src/*.sh`. Don't mix the two.
- **`agents_skills_sync.sh`** is invoked by wrapper `claude()`/`codex()` functions in `function.sh` before launching those CLIs. It idempotently symlinks `~/.agents/skills/<name>` into `~/.claude/skills` and `~/.codex/skills`, and only ever touches symlinks that point at `~/.agents/skills` (it must not disturb other skill symlinks).

## Notes

- Scripts and comments are largely in Chinese; match the surrounding language when editing.
- `install.sh` assumes Apple-Silicon Homebrew (`/opt/homebrew/...`) and uses some stale syntax (`brew cask install`); verify before relying on a given `check_*`.
- macOS system tweaks live only in `setup_mac_config` (`shell-src/setup.sh`) and use `defaults write` / `spctl` — these change the machine, run deliberately.
