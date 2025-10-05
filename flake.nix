{
  description = "A Typst project that uses Typst packages";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    typix = {
      url = "github:loqusion/typix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";

    # Example of downloading icons from a non-flake source
    # font-awesome = {
    #   url = "github:FortAwesome/Font-Awesome";
    #   flake = false;
    # };
  };

  outputs =
    inputs@{
      nixpkgs,
      typix,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        inherit (pkgs) lib;

        typixLib = typix.lib.${system};

        # this was originally using the typix cleanTypstSource function
        # but that filters out image files
        # would be best to do some kind of cleaning,
        # but uh, later problem. maybe could contribute
        # an extension to cleanTypstSource with optional extra paths
        # for the user to explicitly declare
        src = ./.;
        commonArgs = {
          typstSource = "main.typ";

          fontPaths = [
            # Add paths to fonts here
            # "${pkgs.roboto}/share/fonts/truetype"
          ];

          virtualPaths = [
            # Add paths that must be locally accessible to typst here
            # {
            #   dest = "icons";
            #   src = "${inputs.font-awesome}/svgs/regular";
            # }
            # {
            #   dest = "media";
            #   src = "${}media";
            # }
          ];
        };

        unstable_typstPackages = [
          {
            name = "diatypst";
            version = "0.7.1";
            hash = "sha256-8CcyuBZkB0H60hPEh+AZAlXgpTKeuYZwxx8h0Qdl98E=";
          }
        ];

        # Compile a Typst project, *without* copying the result
        # to the current directory
        build-drv = typixLib.buildTypstProject (
          commonArgs
          // {
            inherit src unstable_typstPackages;
          }
        );

        # Compile a Typst project, and then copy the result
        # to the current directory
        build-script = typixLib.buildTypstProjectLocal (
          commonArgs
          // {
            inherit src unstable_typstPackages;
          }
        );

        # Watch a project and recompile on changes
        watch-script = typixLib.watchTypstProject commonArgs;

        # Check for spelling errors in the presentation
        spell-check-script = pkgs.writeShellApplication {
          name = "spell-check";
          runtimeInputs = [ pkgs.codespell ];
          text = ''
            find . -name "*.typ" -exec codespell {} +
          '';
        };
      in
      {
        checks = {
          inherit build-drv build-script watch-script;
        };

        packages.default = build-drv;

        apps = rec {
          default = watch;
          build = flake-utils.lib.mkApp {
            drv = build-script;
          };
          watch = flake-utils.lib.mkApp {
            drv = watch-script;
          };
          spell-check = flake-utils.lib.mkApp {
            drv = spell-check-script;
          };
        };

        devShells.default = typixLib.devShell {
          inherit (commonArgs) fontPaths virtualPaths;
          packages = [
            # WARNING: Don't run `typst-build` directly, instead use `nix run .#build`
            # See https://github.com/loqusion/typix/issues/2
            # build-script
            watch-script
            # More packages can be added here, like typstfmt
            pkgs.tinymist
            pkgs.codespell
          ];
        };
      }
    );
}
