#---------------CONFIGURATION-----------------------------
autoload -U compinit
compinit
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '% Pas de résultats pour : %d%b'
zstyle ':completion:*' menu select=1
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

#---------------------------ALIAS---------------------------------
alias ls='colorls'
#alias ll='ls --color=auto -lh'
alias ll='colorls -l'
alias lll='ls --color=auto -lh | less'
alias la='ls --color=auto -A'
alias s='sudo'
alias systemctl='sudo systemctl'
#pacman
alias pi='sudo pacman -S'
alias pr='sudo pacman -R'
alias prs='sudo pacman -Rs'
alias prsn='sudo pacman -Rsn'
alias pss='sudo pacman -Ss'
alias psu='sudo pacman -Syu'
alias packinstall='sudo pacman -S'
alias packremove='sudo pacman -R'
alias packsearsh='sudo pacaur -Ss'
alias packupgrade='pacaur -Syyu --noconfirm'
alias packupgrade-all='pacaur -Syyu --noconfirm && for dir in $(find /home/jb/SysAdmin/Softs -name ".git"); do cd ${dir%/*}; git pull; cd -; done '
#divers
alias rm='rm -i'
alias youtube-dl-audio='youtube-dl --extract-audio --audio-format mp3'
alias genpasswd='tr -dc '\x15-\x7e' < /dev/urandom| head -c 8 | paste'
alias putain='echo "ça va, ça va...";sleep 5;clear;echo "Calme-toi! "; sleep 3 '
alias ccat='pygmentize -g'
alias partagehttp='python3 -m http.server'
alias rgrep='grep  -n -I -R -r'
alias fgrep='grep  -n -I'
alias mi='micro'
#grep
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
#Systemctl
alias service='sudo systemctl'

#-----------------------REGULAR COLORS----------------------
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

#-----------------------VARIABLES----------------------------
#editeur de txt
export EDITOR=/usr/bin/micro

#-----------------------PROMPTS------------------------------
function exitstatus(){
	if [[ $? == 0 ]];then
		print '%F{green}•%f'
	else 
		print '%F{red}•%f'
	fi
}
setopt promptsubst
#RPROMPT='%K{yellow}%F{black} %~ %f%k'
NEWLINE=$'\n'
PROMPT='${NEWLINE}%F{cyan}%n%f${NEWLINE}$(exitstatus) ' RPROMPT='%K{yellow}%F{black} %~ %f%k'
#PROMPT='${NEWLINE}%F{cyan}%n%f${NEWLINE}' RPROMPT='%K{yellow}%F{black} %~ %f%k'
#'$(exitstatus) '

#----------------------FONCTIONS-----------------------------
#ls automatique à cd
xs() {
  cd "$@"
  ls
}

#hackaide
hackaide(){
echo ""
echo "  maltego       =>  Analyse et recherche visuel"
echo "  spiderfoot    =>  Analyse et recherche OSINT visuel"
echo "  fierce        =>  Brutforce DNS"
echo "  datasploit    =>  A tool to perform various OSINT "
echo "  theHarvester  =>  E-mail, subdomain and people names harvester"
}

#Pacaide
pacaide() {
  echo ""
  echo "    --LISTE DES ALIAS PACMAN--"
  echo ""
  echo "  pi    => sudo pacman -S   = Installe le pk"
  echo "  pr    => sudo pacman -R   = Désistalle"
  echo "  prs   => sudo pacman -Rs  = Désinstalle + dependances"
  echo "  prsn  => sudo pacman -Rsn = Désinstalle + conf"
  echo "  pss   => sudo pacman -Ss  = cherche un pk dans les dépots"
  echo "  psu   => sudo pacman -Syu = syncro + mise a jour"
  echo ""
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

#------------------------PIMP ZSH !---------------------------------------------------
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='fg=41,underline'
ZSH_HIGHLIGHT_STYLES[alias]='fg=112'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=88'
ZSH_HIGHLIGHT_STYLES[command]='fg=112'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=113'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=112'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=113'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=113'
ZSH_HIGHLIGHT_STYLES[function]='fg=112'
#source /usr/share/nvm/init-nvm.sh

export PATH=/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/jb/.vimpkg/bin:/home/jb/.gem/ruby/2.4.0/bin

PATH="/home/jb/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/jb/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/jb/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/jb/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/jb/perl5"; export PERL_MM_OPT;

#source $(dirname $(gem which colorls))/tab_complete.sh

zle -C colorls .complete-word colorls_completion 
bindkey '^x^i' colorls
  
  # define the function that will be called
colorls_completion() {
  compadd $(colorls --'*'-completion-bash="$2" )
}
