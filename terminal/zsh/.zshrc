# Historial
export HISTFILE=~/.zsh/zsh_hist
HISTSIZE=10000
HISTFILESIZE=10000

# Configuración de HISTCONTROL para:
# - ignoreboth: Ignorar comandos duplicados consecutivos y comandos que empiezan con espacio.
# - erasedups: Eliminar comandos duplicados anteriores.
# - ignoreerr: No guardar comandos que fallan (código de salida diferente de 0).
export HISTCONTROL="ignoreboth:erasedups:ignoreerr"

SAVEHIST=10000
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
alias lsa="ls -a"
alias lss="ls -la"
alias lsd="ls -aR -1"
alias cl="clear"
alias commit="bash /home/devmike/Documents/bashScripts/gitMsgPerCommit.sh"
alias gt="git status"
alias re="cd .."
alias ho="cd ~"
alias gsm="git switch master"
alias gsd="git switch dev"
alias gst="git switch tests"
alias ga="git add ."
alias gb="git branch"
alias gbb="git remote -vv"
alias undo="git reset --soft HEAD~1"
alias erase="git reset --hard HEAD~1"
alias reset="git reset --hard HEAD"
alias reset-test="git reset --hard tests"
alias reset-dev="git reset --hard dev"
alias reset-master="git reset --hard master"
alias fol-dev="cd ~/Documents/Projects/devtools"
alias fol-pro="cd ~/Documents/Projects"
alias scripts="cd ~/Documents/Projects/devtools/scripts"

eval "$(ssh-agent -s)"  # Inicia el agente SSH
ssh-add ~/.ssh/git  # Agrega la clave (o ~/.ssh/id_rsa si usaste RSA)

# Tema de "Oh My Posh"
eval "$(oh-my-posh init zsh --config ~/.ohmyposh/theme.omp.json)"
