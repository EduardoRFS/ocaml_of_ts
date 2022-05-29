self: super:
with super; {
  # ocaml-ng = builtins.mapAttrs (_: ocamlVersion: ocamlVersion) super.ocaml-ng;
  # TODO: this is clearly not right, I should be overriding only 4_14
  ocaml-ng = ocaml-ng // (with ocaml-ng; {
    ocamlPackages_4_14 = ocamlPackages_4_14.overrideScope'
      (self: super: {
        ocaml-lsp = super.ocaml-lsp.overrideAttrs (_: {
          src = fetchurl {
            url = "https://github.com/ocaml/ocaml-lsp/releases/download/1.11.6/jsonrpc-1.11.6.tbz";
            sha256 = "50b546ced5332c4a038bcf68b65b7888cb8e61aebe102e8c80b23a4c5899bbbb";
          };
        });
        ocaml-tree-sitter = self.callPackage ./ocaml-tree-sitter.nix { };
        yojson = super.yojson.overrideAttrs (_: {
          src = fetchurl {
            url = "https://github.com/ocaml-community/yojson/releases/download/1.7.0/yojson-1.7.0.tbz";
            sha256 = "ZW/GX3lBhidPi5Ydw42rqeLeL8mTgpKR3vvaIYaBLMY=";
          };
          patches = [ ];
        });
        atdgen-codec-runtime = super.atdgen-codec-runtime.overrideAttrs (_: {
          src = builtins.fetchurl {
            url = "https://github.com/ahrefs/atd/releases/download/2.4.1/atdgen-codec-runtime-2.4.1.tbz";
            sha256 = "16888rnvhgh5yxxsnzsj10g5pzs1l4dn27n23kk2f4641dn26s3a";
          };
        });
      });
  });
}
