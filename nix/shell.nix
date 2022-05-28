{ pkgs, ocaml_of_ts }:

with pkgs; with ocamlPackages; mkShell {
  inputsFrom = [ ocaml_of_ts ];
  packages = [
    # Make developer life easier
    # formatters
    nixfmt
    ocamlformat

    # OCaml developer tooling
    ocaml
    dune_3
    ocaml-lsp
    ocamlformat-rpc
  ];
}
