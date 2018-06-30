prepare:
	[ -d /Library/Caches/Homebrew ] || /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	brew bundle

link:
	mkdir -p ~/.config/nvim
	mkdir -p ~/.config/alacritty
	mkdir -p ~/.packages

	[ -f ~/.config/nvim/init.vim ] || ln -s $(PWD)/vimrc ~/.config/nvim/init.vim
	[ -f ~/.config/alacritty/alacritty.yml ] || ln -s $(PWD)/alacritty.yml ~/.config/alacritty/alacritty.yml
	[ -f ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	[ -f ~/.bashrc ] || ln -s $(PWD)/bashrc ~/.bashrc
	[ -f ~/.zshrc ] || ln -s $(PWD)/zshrc ~/.zshrc
	[ -f ~/.tmux.conf ] || ln -s $(PWD)/tmuxconf ~/.tmux.conf
	[ -f ~/.tigrc ] || ln -s $(PWD)/tigrc ~/.tigrc
	[ -f ~/.git-prompt.sh ] || ln -s $(PWD)/git-prompt.sh ~/.git-prompt.sh
	[ -f ~/.agignore ] || ln -s $(PWD)/agignore ~/.agignore
	[ -d ~/.packages/alacritty ] || git clone https://github.com/jwilm/alacritty.git ~/.packages/alacritty

	# don't show last login message
	touch ~/.hushlogin

build:
	cd ~/.packages/alacritty && [ -d target/release/osx/Alacritty.app ] || $(MAKE) app

install:
	[ -d /Applications/Alacritty.app ] || cp -r ~/.packages/alacritty/target/release/osx/Alacritty.app /Applications/

clean:
	rm -f ~/.vimrc 
	rm -f ~/.config/nvim/init.vim
	rm -f ~/.config/alacritty/alacritty.yml
	rm -f ~/.bashrc
	rm -f ~/.zshrc
	rm -f ~/.tmux.conf
	rm -f ~/.tigrc
	rm -f ~/.git-prompt.sh
	rm -f ~/.agiginore
	rm -f ~/.packages/alacritty

all:	prepare link build install

.PHONY: all
