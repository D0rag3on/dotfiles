{
  description = "Hopefully a working nixFlake";

  inputs.nixpkgs = {
	url = "nixpkgs/nixos-unstable";
  };

  inputs.zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };


  outputs = { self, nixpkgs, ... }@inputs: {
    nixosConfigurations.GlaDOS = nixpkgs.lib.nixosSystem {
      system = "x86_64-Linux";
      specialArgs = { inherit inputs; };
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
      ];
    };
  };
}
