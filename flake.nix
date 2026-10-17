{
  description = "fish game template";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    zigflake = {
      url = "github:silversquirl/zig-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      zigflake,
    }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      zig = zigflake.packages.x86_64-linux.zig_0_17_0;
      zls = zigflake.packages.x86_64-linux.zig_0_16_0.zls;
    in
    {
      packages.x86_64-linux = {
        default = zig.makePackage {
          pname = "digitales";
          version = "0.1.0";
          src = ./.;
          nativeBuildInputs = [
            zig
            pkgs.libGL
            pkgs.wayland-scanner
            pkgs.wayland
            pkgs.libxkbcommon
          ];
          zigReleaseMode = "fast";
          depsHash = "sha256-3vxgOZT4XYckGYd9jJC6zF2odptDlCUg/UQ5AeSNesA=";
        };
      };

      devShells.x86_64-linux = {
        default = pkgs.mkShell {
          LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
            pkgs.alsa-lib
          ];
          packages = [
            zig
            zls
            pkgs.libGL
            pkgs.wayland-scanner
            pkgs.wayland
            pkgs.libxkbcommon
          ];
        };
      };
    };
}
