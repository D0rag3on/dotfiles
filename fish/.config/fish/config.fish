if status is-interactive
# Commands to run in interactive sessions can go here
  alias con="sudo -e /home/nono/dotfiles/nixos/configuration.nix"
  alias reb="sudo nixos-rebuild switch --flake /home/nono/dotfiles/nixos/.config/nixos"
  alias upg="sudo nixos-rebuild switch --upgrade --flake /home/nono/dotfiles/nixos/.config/nixos"
  alias sudo="sudo "
end

