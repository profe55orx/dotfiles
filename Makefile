GNUPG_HOME = $(HOME)/.gnupg
LOCAL_BIN_HOME = $(HOME)/.local/bin

prepare:
	mkdir -p $(GNUPG_HOME)
	mkdir -p $(LOCAL_BIN_HOME)

	chmod 700 $(GNUPG_HOME)

	brew bundle
	curl -s "https://get.sdkman.io" | zsh
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
	[ -f ~/.zsh_private ] || ln -s $(PWD)/zsh_private ~/.zsh_private

	# don't show last login message
	touch ~/.hushlogin

build:

install:
	pip3 install neovim
	nvim +'PlugInstall --sync' +qa
	nvim +'PlugUpdate --sync' +qa
	nvim +'PlugUpgrade --sync' +qa
	nvim +'GoInstallBinaries --sync' +qa
	$(PWD)/install_sdkman.sh

gpg:
	[ -f $(GNUPG_HOME)/gpg-agent.conf ] || ln -s $(PWD)/gpg-agent.conf $(GNUPG_HOME)/gpg-agent.conf
	[ -f $(GNUPG_HOME)/gpg.conf ] || ln -s $(PWD)/gpg.conf $(GNUPG_HOME)/gpg.conf
	chmod 600 $(GNUPG_HOME)/gpg-agent.conf $(GNUPG_HOME)/gpg.conf

clean:
	rm -f ~/.config/nvim/init.vim
	rm -f ~/.zshrc
	rm -f ~/.tmux.conf
	rm -f ~/.tigrc
	rm -f ~/.git-prompt.sh
	rm -f ~/.agignore
	rm -f  $(GNUPG_HOME)/gpg-agent.conf
	rm -f  $(GNUPG_HOME)/gpg.conf

all:	prepare link build install gpg

.PHONY: all
