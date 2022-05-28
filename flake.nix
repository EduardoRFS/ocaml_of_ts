{
  description = "Nix Flake";

  inputs = {
    nixpkgs.url = "github:anmonteiro/nix-overlays";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = (nixpkgs.makePkgs {
        inherit system;
        extraOverlays = [
          (import ./nix/overlay.nix)
        ];
      }).extend (self: super: {
        ocamlPackages = super.ocaml-ng.ocamlPackages_4_14;
      }); in
      let ocaml_of_ts = pkgs.callPackage ./nix { doCheck = true; }; in
      rec {
        packages = { inherit ocaml_of_ts; };
        devShell = import ./nix/shell.nix { inherit pkgs ocaml_of_ts; };
      });
}
