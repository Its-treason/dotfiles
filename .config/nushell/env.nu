# env.nu
#
# Installed by:
# version = "0.114.1"
#
# Previously, environment variables were typically configured in `env.nu`.
# In general, most configuration can and should be performed in `config.nu`
# or one of the autoload directories.
#
# This file is generated for backwards compatibility for now.
# It is loaded before config.nu and login.nu
#
# See https://www.nushell.sh/book/configuration.html
#
# Also see `help config env` for more options.
#
# You can remove these comments if you want or leave
# them for future reference.

$env.PATH = (
    $env.PATH |
    split row (char esep) |
    # Add Mise shims to path
    append '~/.local/share/mise/shims' |
    append '~/.config/composer/vendor/bin/' |
    append '~/.yarn/bin' |
    append '~/.cargo/bin' |
    append '~/.bun/bin/' |
    append '~/.local/bin' |
    # This will remove all Windows executables from WSL2
    where { |it| $it | str starts-with '/mnt/c' | $in != true }
)

source ./aliase.nu


let mise_path = $nu.default-config-dir | path join mise.nu
^mise activate nu | save $mise_path --force

$env.ANSIBLE_GATHERING = "smart"
