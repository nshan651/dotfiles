# AGENTS.md

Guix System + Guix Home dotfiles, written in Guile Scheme. No CI, no tests — "validation" is running the relevant `guix` command.

## Layout

- `ns/` — Guix configuration as Scheme modules (module `(ns systems base)` lives at `ns/systems/base.scm`).
  - `ns/systems/<hostname>.scm` — one `operating-system` per machine (`golemxiv`, `ulysses`), keyed by `$(hostname)` in the update scripts. `base.scm` defines the shared `base-system` plus the `guix-home-config` helper that wires a home environment into an OS. Also `installer.scm` and `vm/`.
  - `ns/home/` — guix home service modules; `common.scm` exports `common-home-services`, which each system file plugs in via `(guix-home-config (home-environment (services common-home-services)))`.
  - `ns/packages/emacs.scm`, `ns/manifests/emacs.scm` — package list / foreign-distro manifest.
  - `ns/files/` — shell configs referenced from home services with `(local-file "../files/...")`; paths are relative to the defining `.scm`.
- `files/` — plain dotfiles, symlinked into `$HOME` with `stow --adopt -d ~/.dotfiles -t ~ files` (`files/.local/bin/dotstow`). Edits here reach `$HOME` only after stowing.

## Commands

Reconfigure and stow via the scripts in `files/.local/bin` (stowed to `$HOME/.local/bin`, on `$PATH`), not raw `guix` commands — that's the consistent workflow. `update-system` (root) and `update-home` (no root) both take the system file as `~/.dotfiles/ns/systems/$(hostname).scm`; `update-home` is NOT a bug: current Guix accepts an `operating-system` file and extracts the `guix-home-service-type` home envs (verified in `guix/scripts/home.scm`).

All `guix` invocations that reference `ns/` modules need `-L ~/.dotfiles` (repo root is the Guile load path). Plain `guile` cannot load them either — `gnu`/`nongnu` modules live in the Guix store.

- System reconfigure (root): `update-system`.
- Home reconfigure (no root): `update-home`.
- Apply `files/` to `$HOME`: `dotstow` (`stow --adopt -d ~/.dotfiles -t ~ files`).
- Build/dry-run (no script exists): `guix system build -L ~/.dotfiles` / `guix home build -L ~/.dotfiles` with `~/.dotfiles/ns/systems/$(hostname).scm`.
- Installer ISO: `guix system image -L ~/.dotfiles -t iso9660 ns/systems/installer.scm`.
- Foreign-distro emacs manifest: `guix package -L ~/.dotfiles -m ~/.dotfiles/ns/manifests/emacs.scm`.
- VM configs: header comments in `ns/systems/vm/*.scm`; run from that directory with `-L ~/git/channel-5` (the custom `channel-5` channel provides `dwm`/`st` for `x11.scm`).

## Gotchas

- Adding a machine means creating `ns/systems/<hostname>.scm` that `(inherit base-system)`. New home config goes into `ns/home/common.scm` (or a module it uses).
- `nonguix` and the custom `channel-5` (codeberg) channels are used — `(nongnu ...)` imports and non-free packages are expected, not mistakes. Substitutes configured in `base.scm`; channels file at `files/.config/guix/channels.scm`.
- The Emacs *config* is NOT in this repo — only the package list (`ns/packages/emacs.scm`). `~/.emacs.d` is a separate git repo. Don't go hunting for init files here.
- `ns/files/` (consumed by guix home) and `files/` (stowed) are distinct trees; don't confuse them.
- Several scripts under `files/` reference things absent from this repo (e.g. `update-dotfiles` → `./.emacs.d/tangle-dotfiles.el`, `update-channels` → `~/.config/guix/base-channels.scm`). They run against the live `$HOME`; don't "fix" them based on repo state alone.
- `.gitignore`: `files/.local/share/ns/{bookmarks,jobs}`, `*.qcow2`. `ns/systems/vm/wayland` is an untracked build-artifact symlink into `/gnu/store` — leave it uncommitted.
- Commits are SSH-GPG-signed (`gpg.format ssh`, `commit.gpgSign = true` in stowed `files/.config/git/config`); the git template adds a post-receive hook that mirrors to codeberg/github/gitlab.
