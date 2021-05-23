{ buildVimPlugin }:

{
  vim-apprentice = buildVimPlugin {
    name = "vim-apprentice";
    src = builtins.fetchTarball {
      url="https://github.com/romainl/Apprentice/archive/v1.9.tar.gz";
      sha256 = "0ia5nylcddwnydzd4x5pg1a64x8v4fp4lkgblpw3ingvnn8sm9bq";
    }; 
  };

  vim-gruvbox = buildVimPlugin {
    name = "vim-gruvbox";
    src = builtins.fetchTarball {
      url    = "https://github.com/morhetz/gruvbox/archive/v2.0.0.tar.gz";
      sha256 = "14m6yyni31h1idb2979ccpy0prr47dyav8rracx653gq46xclm7h";
    }; 
  };

  vim-markdown-preview = buildVimPlugin {
    name = "vim-markdown-preview";
    src = builtins.fetchTarball {
      url = "https://github.com/iamcco/markdown-preview.nvim/archive/v0.0.9.tar.gz";
      sha256  = "1y30ph5l240rccks8hv2q74r0ckx3yldmlcz5cg4sryvhp3gs10x";
    };
  };

  vim-ripgrep = buildVimPlugin {
    name = "vim-ripgrep";
    src = builtins.fetchTarball {
      name   = "RipGrep-v1.0.2";
      url    = "https://github.com/jremmen/vim-ripgrep/archive/v1.0.2.tar.gz";
      sha256 = "1by56rflr0bmnjvcvaa9r228zyrmxwfkzkclxvdfscm7l7n7jnmh";
    };
  };

  nerdtree-git-plugin = buildVimPlugin {
    name = "nerdtree-git-plugin";
    src = builtins.fetchGit {
      name   = "nerdtree-git-plugin";
      url    ="https://github.com/Xuyuanp/nerdtree-git-plugin.git";
      rev = "03ba4761aea53100476a8a0f6c0bae69d83290d1";
      ref = "master";
    };
  };
}
 

