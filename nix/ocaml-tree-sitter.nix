{ lib
, buildDunePackage
, fetchFromGitHub
, which
, pkg-config
, tree-sitter
, ansiterminal
, atdgen
, cmdliner
, ppx_deriving
, ppx_sexp_conv
, sexplib
, tsort
, alcotest
}:

buildDunePackage rec {
  pname = "tree-sitter";
  version = "dev";
  # TODO: version

  patches = [ ./shell-tree-sitter.patch ];

  src = fetchFromGitHub {
    owner = "returntocorp";
    repo = "ocaml-tree-sitter-core";
    rev = "ae47b86e4e9d8b85e97affa7904ce43b96439b3d";
    sha256 = "V4YtVuhZqn5mbpxHAaFRkz/dqsZKrdjqA4wKwT54jQ0=";
  };

  nativeBuildInputs = [ which pkg-config tree-sitter ];

  # TODO: at least dune 2
  propagatedBuildInputs = [
    ansiterminal
    atdgen
    cmdliner
    ppx_deriving
    ppx_sexp_conv
    sexplib
    tsort # TODO: at least tsort 2
  ];

  checkInputs = [ alcotest ];

  # TODO: is wrap needed?

  # TODO: meta
}
