alias update="sudo apt-get update && sudo apt-get -y upgrade"
alias ainstall="sudo apt-get install $1"
alias ..="cd .."
alias ifconfig="ip addr"
alias open="xdg-open $1 &"
alias rf='rm -rf'
alias la="ls -a"
alias ll="ls -alh"
alias src="source ~/.bashrc"
alias bench="cd ~/data/bench"
alias gs="git status"
alias doco="docker-compose"
alias git-fire="git checkout -b FIRE-$(date +%s); git commit -am \"FIRE! FIRE!\"; git push -u origin HEAD"
alias weather="curl https://wttr.in/johnston,ia"
alias edaliases="vim ~/.bash_aliases"
alias edbashrc="vim ~/.bashrc"
alias edvimrc="vim ~/.vimrc"
alias edtmux="vim ~/.tmux.conf"

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

