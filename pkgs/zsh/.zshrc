################################################################################
# sheldon
# https://github.com/rossmacarthur/sheldon
################################################################################

eval "$(sheldon source)"

# #############################################################################@

################################################################################
# starship
# https://starship.rs/
################################################################################

export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

# #############################################################################@

################################################################################
# direnv
# https://github.com/direnv/direnv
################################################################################

eval "$(direnv hook zsh)"

# #############################################################################@

################################################################################
# rbenv
# https://github.com/rbenv/rbenv
################################################################################

export PATH=$HOME/.rbenv/bin:$PATH
eval "$(rbenv init - zsh)"

# #############################################################################@

################################################################################
# XDG
################################################################################

export XDG_DATA_HOME=$HOME/.local/share
export XDG_CONFIG_HOME=$HOME/.config
export XDG_STATE_HOME=$HOME/.local/state

# #############################################################################@

################################################################################
# ZSH vars
################################################################################

# export LC_ALL=en_IN.UTF-8
# export LANG=en_IN.UTF-8
export HISTFILE=$HOME/.local/state/.zsh_history
export HISTSIZE=10000000000
export SAVEHIST=10000000000

# #############################################################################@

################################################################################
# PATH
################################################################################

export PATH=$PATH:~/.poetry/bin
export PATH=$PATH:~/.cargo/env
export PATH=$PATH:~/.fzf/bin
export PATH=$PATH:~/.config/node-build/bin
export PATH=$PATH:~/.config/var/alacritty/target/release
export PATH=$PATH:~/.config/var/stylua/bin
export PATH=$PATH:~/.config/ninja/build-cmake
export PATH=$PATH:~/.config/var/lua/language-server/bin
export PATH=$PATH:~/.local/share/nvim/lsp_servers/sumneko_lua/extension/server/bin
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.local/toolshed/alacritty/target/release:$PATH

# #############################################################################@

################################################################################
# nix
################################################################################

export PATH=/nix/store/xdlpraypxdimjyfrr4k06narrv8nmfgh-nix-2.11.1/bin:$PATH
export NIX_REMOTE=daemon

# from nix.sh
if [ -n "$HOME" ] && [ -n "$USER" ]; then

    # Set up the per-user profile.

    NIX_LINK=$HOME/.nix-profile

    # Set up environment.
    # This part should be kept in sync with nixpkgs:nixos/modules/programs/environment.nix
    export NIX_PROFILES="/nix/var/nix/profiles/default $HOME/.nix-profile"

    # Set $NIX_SSL_CERT_FILE so that Nixpkgs applications like curl work.
    if [ -e /etc/ssl/certs/ca-certificates.crt ]; then # NixOS, Ubuntu, Debian, Gentoo, Arch
        export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
    elif [ -e /etc/ssl/ca-bundle.pem ]; then # openSUSE Tumbleweed
        export NIX_SSL_CERT_FILE=/etc/ssl/ca-bundle.pem
    elif [ -e /etc/ssl/certs/ca-bundle.crt ]; then # Old NixOS
        export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt
    elif [ -e /etc/pki/tls/certs/ca-bundle.crt ]; then # Fedora, CentOS
        export NIX_SSL_CERT_FILE=/etc/pki/tls/certs/ca-bundle.crt
    elif [ -e "$NIX_LINK/etc/ssl/certs/ca-bundle.crt" ]; then # fall back to cacert in Nix profile
        export NIX_SSL_CERT_FILE="$NIX_LINK/etc/ssl/certs/ca-bundle.crt"
    elif [ -e "$NIX_LINK/etc/ca-bundle.crt" ]; then # old cacert in Nix profile
        export NIX_SSL_CERT_FILE="$NIX_LINK/etc/ca-bundle.crt"
    fi

    # Only use MANPATH if it is already set. In general `man` will just simply
    # pick up `.nix-profile/share/man` because is it close to `.nix-profile/bin`
    # which is in the $PATH. For more info, run `manpath -d`.
    if [ -n "${MANPATH-}" ]; then
        export MANPATH="$NIX_LINK/share/man:$MANPATH"
    fi

    export PATH="$NIX_LINK/bin:$PATH"
    unset NIX_LINK
fi

# #############################################################################@

################################################################################
# directories to ensure
################################################################################

! [ -d $HOME/.local/bin ] && mkdir -p $HOME/.local/bin

# #############################################################################@

################################################################################
# aliases
################################################################################

alias vim="nvim"
alias pbcopy="xsel --clipboard --input"
alias pbpaste="xsel --clipboard --output"

# #############################################################################@

################################################################################
# zsh
################################################################################

[ -f $HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ] && source $HOME/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
[ -f $HOME/.zsh/ohmyzsh/lib/completion.zsh ] && source $HOME/.zsh/ohmyzsh/lib/completion.zsh && autoload -Uz compinit
[ -f $HOME/.zsh/ohmyzsh/lib/completion.zsh ] && 
	typeset -i updated_at=$(date +'%j' -r ~/.zcompdump 2>/dev/null || stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ -f $HOME/.zsh/ohmyzsh/lib/completion.zsh ];then
  if [ $(date +'%j') != $updated_at ]; then
    compinit -i
  else
    compinit -C -i
  fi
  zmodload -i zsh/complist
fi
[ -f $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
[ -f $HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh ] && export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'
bindkey -v
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# #############################################################################@

################################################################################
# bash
################################################################################

! [ -L ~/.local/bin/bash-language-server ] &&
	ln -s \
	~/.local/share/nvim/lsp_servers/bash/node_modules/bash-language-server/bin/main.js \
	~/.local/bin/bash-language-server

# #############################################################################@

################################################################################
# nomad
################################################################################

# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /usr/bin/nomad nomad

# #############################################################################@

################################################################################
# tmux
################################################################################

[ -z $TMUX_RPOJECT ] && TMUX_PROJECT=default
[ -z $TMUX_PLUGINS ] && TMUX_PLUGINS=$TMUX_HOME/plugins
! [ -d $TMUX_HOME ] && mkdir -p $TMUX_HOME
! [ -z "$TMUX_AUTO_ON" ] && if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
	tmux attach -t $TMUX_PROJECT || tmux new -s $TMUX_PROJECT
fi

# #############################################################################@
# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 2 numeric
zstyle :compinstall filename '/home/luis/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
