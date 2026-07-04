{ pkgs, lib, config, inputs, ... }: {
	env = {
		LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [
			pkgs.alsa-lib
		];
	};

  packages = [
		pkgs.git
		pkgs.libGL
		pkgs.wayland-scanner
		pkgs.wayland
		pkgs.libxkbcommon
	];

	languages = {
		zig = {
			enable = true;
		};
	};

  scripts.welcome.exec = ''
    echo ENV: Zig / Raylib
    echo GIT: $(git --version)
		echo ZIG: $(zig version)
  '';

  enterShell = ''
    welcome
  '';

  enterTest = ''
    echo "Running tests"
    git --version | grep --color=auto "${pkgs.git.version}"
  '';
}
