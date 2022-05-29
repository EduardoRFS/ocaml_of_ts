{ pkgs, doCheck ? true }:

let inherit (pkgs) lib stdenv ocamlPackages; in

with pkgs; with ocamlPackages; buildDunePackage rec {
  pname = "ocaml_of_ts";
  version = "0.0.0-dev";

  src = lib.filterSource {
    src = ./..;
    dirs = [ "src" ];
    files = [ "dune-project" ];
  };

  # TODO: this seems weird 
  nativeBuildInputs = [ pkg-config tree-sitter ];

  propagatedBuildInputs = [ ocaml-tree-sitter dune-configurator ]
    # checkInputs are here because when cross compiling dune needs test dependencies
    # but they are not available for the build phase. The issue can be seen by adding strictDeps = true;.
    ++ checkInputs;

  checkInputs = [ alcotest ];
}
