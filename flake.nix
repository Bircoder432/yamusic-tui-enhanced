{
  description = "An unofficial Yandex Music terminal client.";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        packages.default = pkgs.buildGoModule {
          pname = "yamusic-tui-enhanced";
          version = "0.7.3";
          src = self;
          vendorHash = "sha256-x1dYqdsJtcankWjoq94CbBDx5iaroN+2aN/QoByq2t0=";

          nativeBuildInputs = [
            pkgs.pkg-config
          ];

          buildInputs = [
            pkgs.alsa-lib
            pkgs.pipewire
            pkgs.libpulseaudio
          ];
        };

        apps.default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/yamusic-tui";
        };
        homeManagerModules.yamusic-tui-enhanced = import ./nix/home-manager.nix;
      }
    );
}
