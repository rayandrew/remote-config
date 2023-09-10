export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

################ Section: ZSH PACKAGE MANAGER

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

zinit ice wait'!' lucid atload'source $HOME/.config/remote-config/p10k.zsh; _p9k_precmd' nocd
zinit light romkatv/powerlevel10k

zvm_config() {
    ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
    ZVM_CURSOR_STYLE_ENABLED=false
}
zinit ice wait'!' lucid \
  atinit'zvm_config() { \ 
      ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT \
      ZVM_CURSOR_STYLE_ENABLED=false \
  } \
  zvm_after_init_commands+=(init_fzf)'
zinit light jeffreytse/zsh-vi-mode

zinit light zsh-users/zsh-history-substring-search
# Autosuggestions & fast-syntax-highlighting
zinit wait lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
      zdharma-continuum/fast-syntax-highlighting \
  blockf \
      zsh-users/zsh-completions \
  atinit"ZSH_AUTOSUGGEST_STRATEGY=(history completion)" \
  atload"!_zsh_autosuggest_start" \
      zsh-users/zsh-autosuggestions

zinit ice wait"0c" lucid reset \
  atclone"local P=${${(M)OSTYPE:#*darwin*}:+g}
      \${P}sed -i \
      '/DIR/c\DIR 38;5;63;1' LS_COLORS; \
      \${P}dircolors -b LS_COLORS > c.zsh" \
  atpull'%atclone' pick"c.zsh" nocompile'!' \
  atload'zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”'
zinit light trapd00r/LS_COLORS

zinit light asdf-vm/asdf

zinit ice wait"2" as"command" from"gh-r" lucid \
      mv"zoxide*/zoxide -> zoxide" \
      atclone"./zoxide init zsh > init.zsh" \
      atpull"%atclone" src"init.zsh" nocompile'!'
zinit light ajeetdsouza/zoxide

####################################################

export GPG_TTY=$(tty)

alias ls="ls -al --color"
alias ga="git add"
alias gcm="git commit -m"
alias gst="git status -sb"
alias gp="git push"
alias tmuxa="tmux attach || tmux new"
alias ..='cd ..'
alias :q='exit'
# alias cat='/nix/store/vpqq47j73y27694daipjpqn3fzr59gj7-bat-0.23.0/bin/bat'
# alias du='/nix/store/sl9nzaspg0g9pjmjfqq42q44qchz1p4a-du-dust-0.8.6/bin/dust'
alias g='git status -sb'
alias ga='git add'
alias gb='git branch -v'
alias gba='git for-each-ref --sort=committerdate refs/heads/ --format="%(authordate:short) %(color:red)%(objectname:short) '\'''\''%(color:yellow)%(refname:short)%(color:reset) (%(color:green)%(committerdate:relative)%(color:reset))"'
alias gbd='git for-each-ref --sort=-committerdate refs/heads/ --format="%(authordate:short) %(color:red)%(objectname:short) %(color:yellow)%(refname:short)%(color:reset) (%(color:green)%(committerdate:relative)%(color:reset))"'
alias gc='git commit'
alias gca='git commit --amend'
alias gcheck='git checkout'
alias gcm='git commit -m'
alias gcod='git checkout develop'
alias gcom='git checkout main'
alias gcos='git checkout staging'
alias gd='git diff --color-words'
alias gf='git fetch'
alias gfa='git fetch --all'
alias gl='git log --oneline --decorate'
alias gp='git push'
alias gpl='git pull --rebase'
alias gpod='git push origin develop'
alias gpofl='git push --force-with-lease origin'
alias gpom='git push origin main'
alias gpos='git push origin staging'
alias gprod='git pull --rebase origin develop'
alias gprom='git pull --rebase origin main'
alias gpros='git pull --rebase origin staging'
alias gprud='git pull --rebase upstream develop'
alias gprum='git pull --rebase upstream main'
alias gprus='git pull --rebase upstream staging'
alias gpud='git push upstream develop'
alias gpufl='git push --force-with-lease upstream'
alias gpum='git push upstream main'
alias gpus='git push upstream staging'
alias gr='git rm'
alias gra='git rebase --abort'
alias grc='git rebase --continue'
alias grd='git rebase develop'
alias gri='git rebase -i'
alias grm='git rebase main'
alias grs='git rebase staging'
alias gsl='git stash list'
alias gslog='git log --graph --abbrev-commit --decorate --date=relative --format=format:"%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)" --all'
alias gsp='git stash pop'
alias gss='git stash save'
alias gst='git status -sb'
alias l='lla'
alias la='lla'

# completions
# source "$HOME/.third-parties/exa/completions/exa.zsh"
# source "$HOME/.third-parties/zoxide/completions/zoxide.zsh"
# source "$HOME/.third-parties/bat/autocomplete/bat.zsh"

fpath=($HOME/.third-parties/exa/completions $fpath)
fpath=($HOME/.third-parties/zoxide/completions $fpath)
fpath=($HOME/.third-parties/bat/autocomplete $fpath)

# alias ls="exa"
alias ll="ls -l --time-style long-iso --icons"
alias la="ll -a"
alias l="la"
alias vim="nvim"
# alias tree="et"

# https://github.com/zshzoo/cd-ls/blob/main/cd-ls.zsh
if ! (( $chpwd_functions[(I)chpwd_cdls] )); then
  chpwd_functions+=(chpwd_cdls)
fi
function chpwd_cdls() {
  if [[ -o interactive ]]; then
    emulate -L zsh
    ls -la
  fi
}

compdef _gnu_generic snakemake

autoload -U compinit
compinit

HISTSIZE="10000"
SAVEHIST="10000"

HISTFILE="$HOME/.zsh_history"
mkdir -p "$(dirname "$HISTFILE")"

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
unsetopt HIST_EXPIRE_DUPS_FIRST
setopt SHARE_HISTORY
unsetopt EXTENDED_HISTORY

cuda_version=11.8
export CUDA_HOME=/usr/local/cuda-${cuda_version}
export LD_LIBRARY_PATH=$CUDA_HOME/lib64:$LD_LIBRARY_PATH
export PATH=$CUDA_HOME/bin:$PATH

acl() {
  micromamba activate acl
}

t-acl() {
  tmuxp load ~/.tmuxp/acl.yaml
}

t-ddcl() {
  tmuxp load ~/.tmuxp/ddcl.yaml
}


# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE="/home/rayandrew/.local/bin/micromamba";
export MAMBA_ROOT_PREFIX="/home/rayandrew/.micromamba";
__mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    if [ -f "/home/rayandrew/.micromamba/etc/profile.d/micromamba.sh" ]; then
        . "/home/rayandrew/.micromamba/etc/profile.d/micromamba.sh"
    else
        export  PATH="/home/rayandrew/.micromamba/bin:$PATH"  # extra space after export prevents interference from conda init
    fi
fi
unset __mamba_setup
# <<< mamba initialize <<<

alias ppython="PYTHONPATH=\$PYTHONPATH:. python"

# remove ctrl-l
bindkey -r "^L"
