HOME := $(shell echo $$HOME)
PWD := $(shell echo $$PWD)

all: pull
# TODO Install all dots
# install:

pull:
	# Copy scripts
	rsync --exclude="plugged" --exclude="dotfiles" --mkpath -ariv \
		$(HOME)/.local/bin/ \
		$(PWD)/.local/bin/
	# Copy config
	rsync --exclude="plugged" --exclude="dotfiles" --mkpath -ariv \
		$(HOME)/.config/ \
		$(PWD)/.config/

clean:
	rm -rf $(PWD)/.config $(PWD)/.local
