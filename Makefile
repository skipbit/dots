
SOURCE := $(CURDIR)
DESTINATION := $(HOME)

install:
	@make install-zsh
	@make install-git
	@make install-vim
	@make install-screen

clean:
	@mkdir $(DESTINATION)/.cleanup
	@make uninstall-zsh
	@make uninstall-git
	@make uninstall-vim
	@make uninstall-screen

install-zsh:
	@[ ! -e $(DESTINATION)/.zsh ] && ln -s $(SOURCE)/zsh $(DESTINATION)/.zsh
	@[ ! -e $(DESTINATION)/.zshenv ] && ln -s $(DESTINATION)/.zsh/zshenv.default.zsh $(DESTINATION)/.zshenv

uninstall-zsh:
	@mv $(DESTINATION)/.zsh $(DESTINATION)/.cleanup/
	@mv $(DESTINATION)/.zshenv $(DESTINATION)/.cleanup/

install-git:
	@ln -s $(SOURCE)/gitconfig  $(DESTINATION)/.gitconfig
	@ln -s $(SOURCE)/gitexcludes $(DESTINATION)/.gitexcludes

uninstall-git:
	@mv $(DESTINATION)/.gitconfig $(DESTINATION)/.cleanup/
	@mv $(DESTINATION)/.gitexcludes $(DESTINATION)/.cleanup/

install-vim:
	@ln -s $(SOURCE)/exrc $(DESTINATION)/.exrc
	@ln -s $(SOURCE)/vimrc $(DESTINATION)/.vimrc
	@mkdir $(DESTINATION)/.vim
	@ln -s $(SOURCE)/vim-templates $(DESTINATION)/.vim/templates

uninstall-vim:
	@mv $(DESTINATION)/.exrc $(DESTINATION)/.cleanup/
	@mv $(DESTINATION)/.vimrc $(DESTINATION)/.cleanup/
	@mv $(DESTINATION)/.vim $(DESTINATION)/.cleanup/

install-screen:
	@ln -s $(SOURCE)/screenrc $(DESTINATION)/.screenrc

uninstall-screen:
	@mv $(DESTINATION)/.screenrc $(DESTINATION)/.cleanup/

