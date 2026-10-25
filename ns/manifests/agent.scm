(use-modules (guix profiles)
              (gnu packages))
(specifications->manifest
  '("opencode"
    "git-minimal"
    "ripgrep"
    "nss-certs"
    "curl"
    "coreutils"
    "findutils"
    "grep"
    "sed"
    "gawk"
    "make"
    "gcc-toolchain"))
