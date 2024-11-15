{
    description = "Home Manager configuration of peterbarrow";

    inputs = {
        # Specify the source of Home Manager and Nixpkgs.
        nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
        neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
        home-manager = {
          url = "github:nix-community/home-manager";
          inputs.nixpkgs.follows = "nixpkgs";
        };
        emacs-overlay.url = "github:nix-community/emacs-overlay";
        doomemacs = {
          url = "github:doomemacs/doomemacs";
          flake = false; 
        };
    };

    # outputs = { 
    #       nixpkgs,
    #       home-manager,
    #       neovim-nightly-overlay,
    #       doomemacs,
    #       ... 
    #   }:
    outputs = inputs @ {self, nixpkgs, home-manager, neovim-nightly-overlay, doomemacs, emacs-overlay, ...}:
        let
            lib = nixpkgs.lib;
            system = "x86_64-linux";
            pkgs = import nixpkgs {
                inherit system;
                overlays = [
                    neovim-nightly-overlay.overlays.default
                    emacs-overlay.overlays.default
                  ];
              };
        in {
            homeConfigurations = {
                # thinkpad-yoga12 = home-manager.lib.homeManagerConfiguration {
                thinkpad-yoga12 = inputs.home-manager.lib.homeManagerConfiguration {
                    inherit pkgs;
                    modules = [ ./home.nix ];
                    };
                };
    };
}
