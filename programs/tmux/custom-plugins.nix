{ pkgs, ... }:

let
  buildTmuxPlugin = pkgs.tmuxPlugins.mkTmuxPlugin;
in
{
  tpm = buildTmuxPlugin {
    pluginName = "tpm";
    version = "v3.0.0";
    src = builtins.fetchTarball {
      name   ="tpm";
      url    =
        "https://github.com/tmux-plugins/tpm/archive/1ff32085b2b30956fbab58b1520d84d95f18d48d.tar.gz";
      sha256 = "18q5j92fzmxwg8g9mzgdi5klfzcz0z01gr8q2y9hi4h4n864r059";
    };
  };
}
