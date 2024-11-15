.PHONY: update
update:
	home-manager switch --flake .#thinkpad-yoga12

.PHONY: clean
clean:
	nix-collect-garbage -d

PHONY: doomsync
doomsync:
	~/.emacs.d/bin/doom sync
