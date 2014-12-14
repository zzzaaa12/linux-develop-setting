# bash setting
cp setting/bash_setting.sh ~/.bash_setting.sh
echo "source ~/.bash_setting.sh" >> ~/.bashrc

# colordiff setting
cp setting/colordiffrc ~/.colordiffrc

# git setting
cp setting/gitconfig ~/.gitsetting

# svn setting
if [ ! -e ~/.subversion ]; then
	mkdir ~/.subversion
fi
cp setting/svn_config ~/.subversion/config

# tmux setting
cp setting/tmux.conf ~/.tmux.conf

# vimrc
cp setting/vimrc ~/.vimrc
