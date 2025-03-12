export PATH="$HOME/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

# Historial
export HISTFILE=~/.custom_zsh_history
HISTSIZE=5000
SAVEHIST=5000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt APPEND_HISTORY

# Autocompletado
autoload -Uz compinit
compinit

# NVM (Node.js Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

if [ -f /etc/profile ]; then
  source /etc/profile
fi

# Usar dircolors para establecer colores en ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# Aliases
alias la="ls -la"
alias cl="clear"
alias commit="bash /home/devmike/Documents/bashScripts/gitMsgPerCommit.sh"
alias gt="git status"
alias re="cd .."
alias ho="cd ~"
alias gsm="git switch master"
alias gsd="git switch dev"
alias gst="git switch tests"
alias gcm="git checkout master"
alias gcd="git checkout dev"
alias gct="git checkout tests"
alias ga="git add ."
alias gb="git branch"
alias gbb="git remote -vv"
alias undo="git reset --soft HEAD~1"
alias reset="git reset --hard HEAD~1"
alias restore="git reset --hard HEAD"
alias po="cd ~/Documents/Projects"

# Tema de "Oh My Posh"
eval "$(oh-my-posh init zsh --config ~/.poshthemes/customtheme.omp.json)"
