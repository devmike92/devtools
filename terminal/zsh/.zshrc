# Configuración del Historial de Comandos
HISTFILE=~/.zsh_history        # Archivo donde se guardará el historial
HISTSIZE=10000                 # Número máximo de comandos en memoria
SAVEHIST=10000                 # Número máximo de comandos a guardar en el archivo

# Opciones de historial
setopt HIST_IGNORE_DUPS      # No guardar comandos duplicados consecutivos
setopt HIST_IGNORE_ALL_DUPS  # Elimina duplicados en todo el historial
setopt HIST_IGNORE_SPACE     # No guardar comandos que comiencen con espacio
setopt HIST_REDUCE_BLANKS    # Elimina espacios extra en los comandos
setopt HIST_VERIFY           # Editar antes de ejecutar comandos recuperados
setopt APPEND_HISTORY        # Agrega nuevos comandos al historial en lugar de sobrescribir
setopt INC_APPEND_HISTORY    # Agregar al archivo de historial en tiempo real
setopt SHARE_HISTORY         # Sincronizar historial entre varias terminales
setopt extendedhistory incappendhistorytime

## Función para Eliminar Comandos Erróneos
# La función TRAPERR se ejecuta cuando un comando retorna un código distinto de 0.
# En este caso, se elimina la última línea del archivo de historial y se recarga.
function TRAPERR() {
    if [[ -s $HISTFILE ]]; then
        sed -i '$d' "$HISTFILE"  # Elimina la última línea del archivo de historial
        fc -R "$HISTFILE"        # Recarga el historial en memoria
    fi
}

# Sincronización del Historial en Tiempo Real
autoload -Uz add-zsh-hook
load-shared-history() {
  # Quita el historial actual de la pila para evitar duplicados
  fc -P
  # Carga el historial desde HISTFILE
  fc -p "$HISTFILE"
}
# Antes de mostrar el prompt, se importa el último historial
add-zsh-hook precmd load-shared-history

# Configuración de Colores y Alias para ls y Comandos Relacionados
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias c='clear'
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Configuración del Autocompletado
autoload -Uz compinit
compinit

# NVM (Node.js Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Fuente del Perfil Global (si existe)
if [ -f /etc/profile ]; then
  source /etc/profile
fi

# Alias Personalizados
alias lsa="ls -a"
alias lss="ls -la -v --group-directories-first"
alias lsd="ls -aR -1"
alias c="clear"
alias commit="bash /home/devmike/Documents/projects/devtools/terminal/scripts/gitMsgPerCommit.sh"
alias gt="git status"
alias re="cd .."
alias ho="cd ~"
alias gsm="git switch master"
alias gsd="git switch dev"
alias gst="git switch tests"
alias gsqa="git switch qa"
alias gsmain="git switch main"
alias ga="git add ."
alias gb="git branch -a"
alias undo="git reset --soft HEAD~1"
alias erase="git reset --hard HEAD~1"
alias reset="git reset --hard HEAD"
alias reset-test="git reset --hard tests"
alias reset-dev="git reset --hard dev"
alias reset-master="git reset --hard master"
alias fol-dev="cd ~/Documents/projects/devtools"
alias fol-pro="cd ~/Documents/projects"
alias fol-ftb="cd ~/Documents/projects/ftb_bot"
alias scripts="cd ~/Documents/projects/devtools/scripts"
alias tr="tree -L 2"

# Configuración del Agente SSH
eval "$(ssh-agent -s)"         # Inicia el agente SSH
ssh-add ~/.ssh/git              # Agrega la clave SSH (ajusta la ruta si es necesario)

# Tema de "Oh My Posh"
eval "$(oh-my-posh init zsh --config /home/devmike/.cache/oh-my-posh/themes/theme.omp.json)"