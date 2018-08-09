# bash setting
cp setting/bash_setting.sh ~/.bash_setting.sh
echo "source ~/.bash_setting.sh" >> ~/.bashrc

# openwrt dev setting
cp setting/bash_openwrt.sh ~/.bash_openwrt.sh

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
