VPS="149.56.12.120"

autoload -U compinit
compinit
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '% Pas de résultats pour : %d%b'
zstyle ':completion:*' menu select=2
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                             /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
zstyle ':completion:*:s:*' command-path /usr/local/sbin /usr/local/bin \
                             /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

#history
export HISTSIZE=2000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

#Cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh_cache

#couleurs de completion
zmodload zsh/complist
setopt extendedglob
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

#Correction
setopt correctall

#binkey
bindkey -e

bindkey "\e[H" beginning-of-line # Début
bindkey "\e[F" end-of-line # Fin
bindkey "\e[3~" delete-char
bindkey "^R" history-incremental-search-backward # Rechercher
bindkey "\e[5C" forward-word
bindkey "\e[5D" backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word



#---ALI0AS------------------------------------------------------------------------
alias ls='ls --color=auto'
alias ll='ls --color=auto -lh'
alias lll='ls --color=auto -lh | less'
alias la='ls --color=auto -A'
alias s='sudo'
alias rm='rm -i'
alias genpasswd='tr -dc '\x15-\x7e' < /dev/urandom| head -c 8 | paste'
alias ccat='pygmentize -g'

Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

#grep colors
export GREP_COLOR=31
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'



#--PS1---------------------------------------------------------------------------

PROMPT=$'
 %{\e[1;38;5;196m%}%n@%M %{\e[0;36m%}[%~]%{\e[0m%} #> '
RPROMPT=$'%{\e[0;33m%}%?%{\e[0m%}'


#--FONCTIONS---------------------------------------------------------------------
#ls automatique à cd
xs() {
  cd "$@"
  ls
}


destroy() {
  shred -n 4 -z -u $1
}

pong(){
  ping -c 5 $1
}

extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}
