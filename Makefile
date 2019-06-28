prepare:
	brew bundle
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	
link:
	mkdir -p ~/.config/nvim
	mkdir -p ~/.gnupg

	[ -f ~/.config/nvim/init.vim ] || ln -s $(PWD)/vimrc ~/.config/nvim/init.vim
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmuxconf ~/.tmux.conf
	[ -f ~/.tigrc ] || ln -s $(PWD)/tigrc ~/.tigrc
	[ -f ~/.git-prompt.sh ] || ln -s $(PWD)/git-prompt.sh ~/.git-prompt.sh
	[ -f ~/.agignore ] || ln -s $(PWD)/agignore ~/.agignore
	[ -f ~/.gnupg/gpg-agent.conf ] || ln -s $(PWD)/gpg-agent.conf ~/.gnupg/gpg-agent.conf
	[ -f ~/.zsh_private ] || cp $(PWD)/zsh_private ~/.zsh_private

	# don't show last login message
	touch ~/.hushlogin

build:

install:
	pip3 install neovim
	nvim +'PlugInstall --sync' +qa
	nvim +'PlugUpdate --sync' +qa
	nvim +'PlugUpgrade --sync' +qa
	nvim +'GoInstallBinaries --sync' +qa
	pod setup

clean:
	rm -f ~/.config/nvim/init.vim
	rm -f ~/.zshrc
	rm -f ~/.tmux.conf
	rm -f ~/.tigrc
	rm -f ~/.git-prompt.sh
	rm -f ~/.agignore

all:	prepare link build install

.PHONY: all
