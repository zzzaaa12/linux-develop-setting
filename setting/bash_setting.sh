# PS1 setting with color 
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

LANG=C

# alias for commands with color
alias diff='colordiff'
alias findx='find . -name'
alias ll='ls -al --color=always'
alias llh='ll -h'
alias cr='clear'
alias x='xargs'
alias p='pwd'
alias makec='colormake'
alias c='ctags -R .'
alias v='vim'


# color for ls command
#LS_COLORS=\
#"rs=0:di=01;36:ln=02;33:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;\
#01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:\
#*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:\
#*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:\
#*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;\
#31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:\
#*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:\
#*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:\
#*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:\
#*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:\
#*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:\
#*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:\
#*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:\
#*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:\
#*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:\
#*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:\
#*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:\
#*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:"


# ===== find =====
alias findx='find . -name'
alias fx='findx'
function fls() {
	fx "$1" | xargs ls -al
}


# ===== jobs =====
alias j='jobs'
alias m='j'
alias f='fg'
for i in $(seq 1 30)
do
	alias "$i"="fg $i"
done


# ===== grep =====
alias grep='grep --color=auto --exclude-dir=.svn --exclude-dir=CVS --exclude-dir=.git --exclude=tags'
alias grephis='history | grep'
alias gx='grepx'
function grepx() {
        if [ "$1" = "" ]; then
                echo "Nothing to grep!!!"
        elif [ "$2" = "" ]; then
                grep $1 * -rn
        elif [ "$3" = "" ]; then
                grep $1 $2
        else
                grep $@
        fi
}

function gxi() {
        if [ "$1" = "" ]; then
                echo "Nothing to grep!!!"
        elif [ "$2" = "" ]; then
                grep $1 * -rni
        elif [ "$3" = "" ]; then
                grep $1 $2 -i
        else
                grep $@
        fi
}

# ====== git ======
alias gitaddmodified='git st . | grep modified | sed "s/.*modified:   //g" | xargs git add ; git st'
alias gs='git st'
alias gitrenew='git stash && git pull --rebase && git stash pop'
alias g='git'
alias gbr='git branch -a'
alias gd='git diff'
alias gd2='git diff --staged'
alias glog='git log'
alias gshow='git show'
alias gci='git commit'
alias gremote='git remote -v'
alias gpush='git push'


# ====== tumx ======
alias tmux='TERM=xterm-256color tmux -2'
# show tmux status after login
tmux ls 2>/dev/null

# ====== others ======
if [ "$(hostname|grep '\[')" != "" ]; then
    export PS1=" \u@\h \[\033[01;32m\]\W\[\033[31m\]\$(parse_git_branch)\[\033[00m\] $ "
    export LD_LIBRARY_PATH=""
else
    export PS1=" \[\033[01;32m\]\W\[\033[31m\]\$(parse_git_branch)\[\033[00m\] $ "
    export PATH=$HOME/local/bin:$PATH
fi

source ~/.bash_openwrt.sh
# Disable for realtek make menuconfig
# export TERM=xterm1;export TERMINFO=/usr/share/terminfo
