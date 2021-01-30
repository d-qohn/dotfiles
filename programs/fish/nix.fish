if test -n "$HOME"
   and test -n "$USER"

    # Set up the per-user profile.
    # This part should be kept in sync with nixpkgs:nixos/modules/programs/shell.nix

    set -x NIX_LINK $HOME/.nix-profile


    # Append ~/.nix-defexpr/channels to $NIX_PATH so that <nixpkgs>
    # paths work when the user has fetched the Nixpkgs channel.
    set -x NIX_PATH $HOME/.nix-defexpr/channels

    # Set up environment.
    # This part should be kept in sync with nixpkgs:nixos/modules/programs/environment.nix
     set -x NIX_PROFILES "/nix/var/nix/profiles/default $HOME/.nix-profile"

    # Set $NIX_SSL_CERT_FILE so that Nixpkgs applications like curl work.

    if test -e /etc/ssl/certs/ca-certificates.crt
        set -x NIX_SSL_CERT_FILE /etc/ssl/certs/ca-certificates.crt
    else if test -e /etc/ssl/ca-bundle.pem
        set -x NIX_SSL_CERT_FILE /etc/ssl/ca-bundle.pem
    else if test -e /etc/ssl/certs/ca-bundle.crt
        set -x NIX_SSL_CERT_FILE /etc/ssl/certs/ca-bundle.crt
    else if test -e /etc/pki/tls/certs/ca-bundle.crt
        set -x NIX_SSL_CERT_FILE /etc/pki/tls/certs/ca-bundle.crt
    else if test -e "$NIX_LINK/etc/ssl/certs/ca-bundle.crt"
        set -x NIX_SSL_CERT_FILE "$NIX_LINK/etc/ssl/certs/ca-bundle.crt"
    else if test -e "$NIX_LINK/etc/ca-bundle.crt"
        set -x NIX_SSL_CERT_FILE "$NIX_LINK/etc/ca-bundle.crt"
    end

    if test -n "$MANPATH"
      set -x MANPATH $MANPATH "$NIX_LINK/share/man"
    end

    set -x PATH $PATH "$NIX_LINK/bin"
    set -e NIX_LINK
end

