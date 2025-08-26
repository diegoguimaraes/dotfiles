vim-links:
	ln -s $(PWD)/vimrc ~/.vimrc || true
	mkdir ~/.vim/ftplugin  || true
	ln -s $(PWD)/org.vim ~/.vim/ftplugin/org.vim || true

vim-plug:
	mkdir -p ~/.vim/autoload/ || true
	curl -fLo ~/.vim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim || true
	vim +PlugInstall +qall +silent

vim-tmp-dir:
	mkdir -p ~/.vimtmp || true

tmux-links:
	ln -s $(PWD)/tmux.conf ~/.tmux.conf || true

tmux-tpm:
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm || true

vim: vim-links vim-plug vim-tmp-dir

tmux: tmux-links tmux-tpm

bash:
	ln -s $(PWD)/bashrc ~/.bashrc || true
	ln -s $(PWD)/bashrc ~/.bashprofile || true

gitconfig:
	ln -s $(PWD)/gitconfig ~/.gitconfig || true

lazygit:
	mkdir -p "$$HOME/Library/Application Support/lazygit" || true
	ln -s $(PWD)/lazygit-config.yml "$$HOME/Library/Application Support/lazygit/config.yml" || true
	chmod +x $(PWD)/scripts/ai-commit.sh || true

setup: vim tmux bash gitconfig lazygit
