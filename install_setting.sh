# bash setting
cp setting/bash_setting.sh ~/.bash_setting.sh
if [ "$(grep bash_setting ~/.bashrc)" = "" ]; then
	echo "source ~/.bash_setting.sh" >> ~/.bashrc
fi

# colordiff setting
cp setting/colordiffrc ~/.colordiffrc

# git setting
cp setting/gitconfig ~/.gitconfig

# svn setting
if [ ! -e ~/.subversion ]; then
	mkdir ~/.subversion
fi
cp setting/svn_config ~/.subversion/config

# tmux setting
cp setting/tmux.conf ~/.tmux.conf

# vimrc
cp setting/vimrc ~/.vimrc

# dircolors (LS_COLORS)
cp setting/dircolors ~/.dircolors

# tigrc
cp setting/tigrc ~/.tigrc

# apply setting
source ~/.bash_setting.sh
