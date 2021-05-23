#{ pkgs, locals }:
{ pkgs }:

let
  file = {
    ".emacs.d/init.el".source = ./init.el;
    # ".emacs.d/locals.el".source = locals;
  };
  deriv =
    pkgs.emacsWithPackages {
      config = ./init.el;
      package = pkgs.emacsGit;
      extraEmacsPackages = epkgs: [
        epkgs.rainbow-delimiters
      ];
    };
in
  {
    derivation = deriv;
    file = file;
  }
