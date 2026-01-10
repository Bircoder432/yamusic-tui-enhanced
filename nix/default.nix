{
  pkgs ? import <nixpkgs> { },
}:

pkgs.buildGoModule {
  pname = "yamusic-tui-enhanced";
  version = "0.7.3";

  src = ./.;

  vendorHash = "sha256-x1dYqdsJtcankWjoq94CbBDx5iaroN+2aN/QoByq2t0=";

  # CGO нужен для alsa/oto
  CGO_ENABLED = 1;

  nativeBuildInputs = [
    pkgs.pkg-config
  ];

  buildInputs = [
    pkgs.alsa-lib
    pkgs.pipewire
    pkgs.libpulseaudio
  ];
}
