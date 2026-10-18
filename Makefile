
SOURCE := $(CURDIR)
DESTINATION := $(HOME)

install:
	@make install-zsh
	@make install-git
	@make install-vim
	@make install-screen
	@make install-tmux
	@make install-nix
	@make install-wezterm
	@make install-ghostty
	@make install-herdr
	@make install-fzf-herdr

clean:
	@mkdir $(DESTINATION)/.cleanup
	@make uninstall-zsh
	@make uninstall-git
	@make uninstall-vim
	@make uninstall-screen
	@make uninstall-tmux
	@make uninstall-nix
	@make uninstall-wezterm
	@make uninstall-ghostty
	@make uninstall-herdr
	@make uninstall-fzf-herdr

install-zsh:
	@[ ! -e $(DESTINATION)/.zsh ] && ln -s $(SOURCE)/zsh $(DESTINATION)/.zsh
	@[ ! -e $(DESTINATION)/.zshenv ] && ln -s $(DESTINATION)/.zsh/zshenv.default.zsh $(DESTINATION)/.zshenv

uninstall-zsh:
	@mv $(DESTINATION)/.zsh $(DESTINATION)/.cleanup/
	@mv $(DESTINATION)/.zshenv $(DESTINATION)/.cleanup/

install-git:
	@ln -s $(SOURCE)/gitconfig  $(DESTINATION)/.gitconfig
	@ln -s $(SOURCE)/gitexcludes $(DESTINATION)/.gitexcludes
	@ln -s $(SOURCE)/tigrc $(DESTINATION)/.tigrc

uninstall-git:
	@mv $(DESTINATION)/.gitconfig $(DESTINATION)/.cleanup/
	@mv $(DESTINATION)/.gitexcludes $(DESTINATION)/.cleanup/
	@mv $(DESTINATION)/.tigrc $(DESTINATION)/.cleanup/

install-vim:
	@ln -s $(SOURCE)/exrc $(DESTINATION)/.exrc
	@ln -s $(SOURCE)/vimrc $(DESTINATION)/.vimrc
	@mkdir $(DESTINATION)/.vim
	@ln -s $(SOURCE)/vim-templates $(DESTINATION)/.vim/templates
	@mkdir -p $(DESTINATION)/.config
	@ln -s $(SOURCE)/nvim $(DESTINATION)/.config/nvim

uninstall-vim:
	@mv $(DESTINATION)/.exrc $(DESTINATION)/.cleanup/
	@mv $(DESTINATION)/.vimrc $(DESTINATION)/.cleanup/
	@mv $(DESTINATION)/.vim $(DESTINATION)/.cleanup/
	@mv $(DESTINATION)/.config/nvim $(DESTINATION)/.cleanup/

install-screen:
	@ln -s $(SOURCE)/screenrc $(DESTINATION)/.screenrc

uninstall-screen:
	@mv $(DESTINATION)/.screenrc $(DESTINATION)/.cleanup/

install-tmux:
	@ln -s $(SOURCE)/tmux/tmux.conf $(DESTINATION)/.tmux.conf
	@mkdir -p $(DESTINATION)/.tmux/bin
	@ln -s $(SOURCE)/tmux/tmux-pane-border $(DESTINATION)/.tmux/bin/tmux-pane-border
	@git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

uninstall-tmux:
	@mv $(DESTINATION)/.tmux.conf $(DESTINATION)/.cleanup/
	@mv $(DESTINATION)/.tmux $(DESTINATION)/.cleanup/

install-nix:
	@ln -s $(SOURCE)/nix $(DESTINATION)/.config/nix

uninstall-nix:
	@mv $(DESTINATION)/.config/nix $(DESTINATION)/.cleanup/

install-wezterm:
	@ln -s $(SOURCE)/wezterm $(DESTINATION)/.config/wezterm

uninstall-wezterm:
	@mv $(DESTINATION)/.config/wezterm $(DESTINATION)/.cleanup/

install-ghostty:
	@ln -s $(SOURCE)/ghostty $(DESTINATION)/.config/ghostty

uninstall-ghostty:
	@mv $(DESTINATION)/.config/ghostty $(DESTINATION)/.cleanup/

install-herdr:
	@mkdir -p $(DESTINATION)/.config/herdr
	@ln -s $(SOURCE)/herdr/config.toml $(DESTINATION)/.config/herdr/config.toml

uninstall-herdr:
	@mv $(DESTINATION)/.config/herdr/config.toml $(DESTINATION)/.cleanup/

# herdr のないホストでは何もしない。
install-fzf-herdr:
	@if command -v herdr > /dev/null 2>&1; then herdr plugin install --yes skipbit/fzf-herdr; fi

uninstall-fzf-herdr:
	@if command -v herdr > /dev/null 2>&1; then \
		herdr plugin uninstall skipbit.fzf-herdr; \
		mv $${XDG_DATA_HOME:-$(DESTINATION)/.local/share}/fzf-herdr $(DESTINATION)/.cleanup/; \
	fi
