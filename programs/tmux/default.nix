{ config, pkgs, ... }:

let
  plugins  = pkgs.tmuxPlugins // pkgs.callPackage ./custom-plugins.nix {};
  tmuxConf = builtins.readFile ./default.conf;
in
{
  programs.tmux = {
    enable = true;
    aggressiveResize = true;
    baseIndex = 1;
    extraConfig = tmuxConf;
    escapeTime = 0;
    keyMode = "vi";
    plugins = with plugins; [
      { 
        plugin = tpm;
        extraConfig = ''
          set -g @plugin 'tmux-plugins/tmux-pain-control'

          set -g @plugin 'tmux-plugins/tmux-open'

          set -g @plugin 'jimeh/tmux-themepack'
          set -g @themepack 'powerline/double/green'
        '';
      }
       {
         plugin = resurrect;
         extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
    ];
    shortcut = "b";
    terminal = "screen-256color";
  };
}
