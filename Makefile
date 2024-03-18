HOME := $(shell echo $$HOME)
PWD := $(shell echo $$PWD)

all: install

install:
	# Copy scripts
	rsync --exclude="plugged" --exclude="dotfiles" --mkpath -ariv \
		$(PWD)/.local/bin/ \
		$(HOME)/.local/bin/ 
	# Copy config
	rsync --exclude="plugged" --exclude="dotfiles" --mkpath -ariv \
		$(PWD)/.config/ \
		$(HOME)/.config/

clean:
	# WARNING: This will nuke your existing configs and scripts
	rm -rf $(HOME)/.config/ $(HOME)/.local/bin/
