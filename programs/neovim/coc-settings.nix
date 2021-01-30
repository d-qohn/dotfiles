{
  "coc.preferences.colorSupport"= true;
  "coc.preferences.snippetStatusText"= "Ⓢ ";
  "coc.preferences.formatOnSaveFiletypes"= [
    "javascript"
    "html"
    "css"
    "json"
    "markdown"
    "typescript"
    "python"
  ];


  "diagnostic.displayByAle"= false;
  "diagnostic.refreshOnInsertMode"= false;
  "diagnostic.errorSign"= "✘";
  "diagnostic.warningSign"= "⚠";
  "diagnostic.infoSign"= "";
  "diagnostic.hintSign"= "ஐ";
  "diagnostic.messageDelay"= 800;
  "diagnostic.refreshAfterSave"= false;
  "diagnostic.checkCurrentLine"= true;
  "diagnostic.virtualTextPrefix"= " ❯❯❯ ";
  "diagnostic.virtualText"= true;
  "diagnostic.enableMessage"= "jump";
  "diagnostic.messageTarget"= "float";

  "languageserver" = {

    "haskell"= {
      "command"= "haskell-language-server-wrapper";

      "args"= ["--lsp"];

      "rootPatterns"= [
        "stack.yaml"
        "hie.yaml"
        ".hie-bios"
        "BUILD.bazel"
        ".cabal"
        "cabal.project"
        "package.yaml"
      ];

      "filetypes"= ["haskell" "lhaskell" "hs" "lhs"];
    };


    "purescript" = {
      "command" = "npx";

      "args" = [
        "purescript-language-server"
        "--stdio"
      ];

      "rootPatterns" = [
        "bower.json"
        "psc-package.json"
        "spago.dhall"
        "packages.dhall"
      ];

      "filetypes" = ["purescript"];

      "settings" = {
        "purescript" = {
          "addSpagoSources" = true;
          "addNpmPath" = true;
          "buildCommand" = "spago build --purs-args --json-errors";
          "editorMode" = true;
        };
      };
    };

    "nix" = {
      "command" = "rnix-lsp";
      "filetypes" = [ "nix" ];
    };

    "dhall"= {
      "command"= "dhall-lsp-server";
      "filetypes"= ["dhall"];
    };
  };
}
