sudo apt install neovim
sudo pip2 install neovim
sudo pip3 install neovim

mkdir -p ~/.cache/dein
cd ~/.cache/dein

curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh

sh ./installer.sh ~/.cache/dein

cd ~/.config/nvim && git clone https://github.com/w0ng/vim-hybrid.git && mv vim-hybrid/colors/ ~/.config/nvim

mkdir -p .config/nvim
ln ./init.vim ~/.config/nvim/init.vim
