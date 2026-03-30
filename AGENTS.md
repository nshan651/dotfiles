# AGENTS.md - Guix System/Home Configuration

This repository contains Guix System and Guix Home configurations in Guile Scheme (.scm files).

## Repository Structure

```
.dotfiles/
├── ns/
│   ├── home/           # Home configs (common.scm, desktop.scm, emacs.scm)
│   ├── systems/        # OS configs (base.scm, golemxiv.scm, ulysses.scm, installer.scm)
│   ├── packages/       # Package definitions (emacs.scm)
│   ├── manifests/      # Guix package manifests
│   └── files/          # Shell configs (profile, zshrc, inputrc)
└── files/.config/      # App configs symlinked to ~/.config
```

## Build/Reconfiguration Commands

### System Configuration
```bash
sudo guix system reconfigure ns/systems/<host>.scm  # Apply system config
guix system build ns/systems/<host>.scm             # Dry-run build
guix system vm ns/systems/<host>.scm                # Test in VM
guix system image -L ~/.dotfiles ns/systems/installer.scm  # Build installer
```

### Home Configuration
```bash
guix home reconfigure ns/home/common.scm    # Apply home config
guix home build ns/home/common.scm          # Dry-run build
guix home reconfigure -L ~/.dotfiles ns/home/common.scm  # With load path
```

### Package Management
```bash
guix package -L ~/.dotfiles -s "emacs"           # Search packages
guix package -L ~/.dotfiles -m ns/manifests/emacs.scm  # Install manifest
guix upgrade -L ~/.dotfiles -m ns/manifests/emacs.scm  # Upgrade manifest
```

### Development/Testing
```bash
guix shell -L ~/.dotfiles -- emacs                                # Package shell
guix build -L ~/.dotfiles <package-name>                          # Build single package
guix shell -L ~/.dotfiles --preserve=^DISPLAY -- emacs            # GUI app shell
```

## Code Style Guidelines

### Module Declarations
```scheme
(define-module (ns <directory> <file-name>)
  #:use-module (ns home desktop)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  #:export (<public-variables>))
```

### Imports
- `#:use-module` for functional imports in `define-module`
- `(use-modules ...)` at top-level for `use-package-modules` and `use-service-modules`
- Order: project modules first, then guix/gnu, then external

### Naming Conventions
- Functions/variables: `kebab-case` (e.g., `home-desktop-profile-service`)
- Quoted symbols: hyphenated (e.g., `'add-nonguix-substitutes`)
- Avoid `snake_case` for new code

### Indentation
- 2-space indentation within s-expressions

### Comments
- `;;;` - Section/header comments
- `;;` - Inline comments

### Service Definitions
```scheme
(define home-desktop-service-type
  (service-type (name 'home-desktop)
    (description "Description.")
    (extensions
      (list (service-extension home-profile-service-type
                              home-desktop-profile-service)))
    (default-value #f)))
```

### Gexps
- `#~` for compiled gexps, `,` for unquoting
- `(local-file "../path")` for project files
- `(file-append package "/bin/program")` for package paths

## File Organization
- **Systems**: `base-system` as reusable foundation; hosts inherit with `(inherit base-system)`
- **Home**: Compose services in `common-home-services`
- **Packages**: Export as `<name>-packages` (e.g., `emacs-packages`)
- **Manifests**: Use `(packages->manifest (append ...))` pattern

## Common Patterns

### Package List
```scheme
(define-public emacs-packages
  (list package-one package-two))
```

### Operating System
```scheme
(define-public base-system
  (operating-system
    (timezone "America/Chicago") (locale "en_US.utf8")
    (kernel linux) (bootloader bootloader-configuration)
    (file-systems %base-file-systems)
    (users %base-user-accounts) (groups %base-groups)
    (packages (cons* extra-packages %base-packages))
    (services %base-services)))
```

### Home Environment
```scheme
(home-environment
  (services (list
    (service home-profile-service-type ...)
    (service home-shell-service-type ...))))
```

## Key References
- [Guix Reference Manual](https://guix.gnu.org/manual/en/html_node/)
- [Guix Cookbook](https://guix.gnu.org/cookbook/en/)
- [Guix Home Documentation](https://guix.gnu.org/en/manual/guix-profitable/)

## Notes
- Add packages to `ns/packages/*.scm` and export the list
- Add services to appropriate home config with service-type
- System configs in `ns/systems/` inherit from `base.scm`
- `local-file` paths are relative to the `.scm` file location
