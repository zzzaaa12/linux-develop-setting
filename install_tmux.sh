# Install libevent
tar -xvzf libevent-2.1.12-stable.tar.gz
cd libevent-2.1.12-stable || return 1
./configure --prefix=$HOME/local || return 1
make || return 1
make install || return 1
cd ../

# Install tmux 2.8
tar -xvzf tmux-2.8.tar.gz || return 1
cd tmux-2.8
./configure CFLAGS="-I$HOME/local/include" LDFLAGS="-L$HOME/local/lib" --prefix=$HOME/local || return 1
make || return 1
make install || return 1

# Add to your bashrc
export PATH=$HOME/local/bin:$PATH
export LD_LIBRARY_PATH=$HOME/local/lib:$LD_LIBRARY_PATH
echo "tmux 2.8: install OK"
