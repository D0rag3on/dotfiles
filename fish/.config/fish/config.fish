if status is-interactive
# Commands to run in interactive sessions can go here
  alias con="sudo -e /home/nono/dotfiles/nixos/configuration.nix"
  alias reb="sudo -E nixos-rebuild switch"
  alias sudo="sudo "
end

set -x NIX_PATH $NIX_PATH nixos-config=/home/nono/dotfiles/nixos/.config/nixos/configuration.nix
