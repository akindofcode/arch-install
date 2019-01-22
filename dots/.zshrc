export PATH=$HOME/.bin:$PATH
export ZSH=$HOME/.oh-my-zsh
export TERM="xterm-256color"

ZSH_THEME="powerlevel9k/powerlevel9k"

plugins=(
  git
  command-not-found
  colored-man-pages
  zsh-syntax-highlighting
  zsh-autosuggestions
  #thefuck
)

source $ZSH/oh-my-zsh.sh

# aliases

alias zshconfig="vim ~/.zshrc"

alias prj="cd ~/Projects/arch-install"

alias install='trizen -S --noedit --noconfirm'

alias neofetch='clear; neofetch'

alias refugees='pacman -Qm'
#Clean orphan packages from the system
alias anakin="sudo pacman -Rns \$(pacman -Qtdq)"

alias gj="git add .; git commit -m 'update'; git push"

alias monitor="xrandr --output DVI-I-1 --auto --output DVI-D-0 --off"
alias tv="xrandr --output DVI-I-1 --off --output DVI-D-0 --auto"

alias play='echo c | beet play year+ album+ track+'
alias mopc="mpc --port 6666"
alias tengo='sudo pacman -Q |grep'
alias random='mpc random'
alias again='mpc repeat'

alias weather='curl "https://wttr.in/Aviles"'

alias flac2mp3="parallel ffmpeg -i {} -b:a 320k {.}.mp3 ::: ./*.flac"
alias alac2flac="parallel ffmpeg -i {} -c:a flac {.}.flac ::: ./*.m4a"
#alias flac24to16="parallel ffmpeg -i {} -sample_fmt s16 -ar 48000  {.}.flac ::: ./*.flac"

alias sleep=systemctl suspend

alias tmux='tmux -2'

alias ls="ls --group-directories-first --color=always -A"

alias bton="bluetoothctl power on"
alias btoff="bluetoothctl power off"

# Custom cd
c() {
	cd $1;
	ls;
}
alias cd="c"

export LC_CTYPE="en_GB.UTF-8"

