alias update="sudo apt update && sudo apt -y upgrade"
alias ainstall="sudo apt install $1"
alias auninstall="sudo apt purge $1 && sudo apt --purge autoremove"
alias isitinstalled="sudo apt list --installed | grep $1"
alias ifconfig="ip addr"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias open="xdg-open $1 &"
alias pbcopy="xclip"
alias pbpaste="xclip -o"
alias rf='rm -rf'
alias la="ls -a"
alias ll="ls -alh"
alias src="source ~/.bashrc"
alias bench="cd ~/bench"
alias gs="git status"
alias doco="docker-compose"
alias git-fire="git checkout -b FIRE-$(date +%s); git commit -am \"FIRE! FIRE!\"; git push -u origin HEAD"
alias weather="curl https://wttr.in/johnston,ia"
alias edaliases="vim ~/.bash_aliases"
alias edbashrc="vim ~/.bashrc"
alias edvimrc="vim ~/.vimrc"
alias edtmux="vim ~/.tmux.conf"

alias technic="cd ~/Downloads; java -jar TechnicLauncher.jar; cd -"
alias node='docker run --rm -it -v "$PWD":/usr/src/app -w /usr/src/app node:8-alpine node'
alias npm='docker run --rm -it -v "$PWD":/usr/src/app -w /usr/src/app node:8-alpine npm'
alias latexmk='docker run --rm -i --user="$(id -u):$(id -g)" --net=none -v "$PWD":/data blang/latex latexmk'
alias goto-scoot='ssh scoot@192.168.1.19'
alias rustc="docker run --rm -it -v $(pwd):/workspace -w /workspace rust:latest rustc"
alias cargo="docker run --rm -it -v $(pwd):/workspace -w /workspace rust:latest cargo"

function tm {
  # create or attach & resume tmux sessions by name
  TMUXNAME=${1:-"default"}

  if tmux ls | grep "^$TMUXNAME:"; then
    tmux attach -d -t $TMUXNAME
  else
    tmux new -s $TMUXNAME
  fi
}

function rmd {
    pandoc $1 | lynx -stdin
}

function docker_run {
    local DOCKER_WORKSPACE_ARGS="-v $(pwd):/workspace -w /workspace"
    local DOCKER_IMAGE="$1"
    shift

    local OTHER_PARAMS=""
    local DOCKER_COMMAND=""
    if [[ "$1" == "--cmd" ]]; then
        shift
        DOCKER_COMMAND="$1"
        shift
    fi
    if [[ "$1" == "--flags" ]]; then
        shift
        OTHER_PARAMS="$*"
    fi
   
    set -x
    docker run --rm -it $DOCKER_WORKSPACE_ARGS $OTHER_PARAMS $DOCKER_IMAGE $DOCKER_COMMAND
    set +x
}

