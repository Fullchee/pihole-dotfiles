# Ubuntu dotfiles

## Setup

### On mac

1. Install Raspberry Pi OS on an SD card
   1. `brew install --cask raspberry-pi-imager`
   2. Pick the latest `lite` debian version
   3. set the user to be `pi`, call the computer `pihole`
2. Connect the pihole to power and to router via ethernet
3. SSH config (on mac)
   1. Find the pihole's IP address (router app)
   1. `ssh pi@<ip-address>`
   1. Update the IP address in `~/.ssh/config`
   1. `ssh-copy-id pi@<ip-address>`
   1. now you can just login with `ssh pi@<ip-address>`

### SSHed on pihole

5. Generate an SSH key
   1. `ssh-keygen`
6. Copy the value of the public SSH key
   1. `cat ~/.ssh/id_ed25519.pub`
7. Add the key to GitHub as a deploy key (can just access this one repo)
   1. https://github.com/Fullchee/pihole-dotfiles/settings/keys
8. Install and switch to zsh
9. `sudo apt -y install zsh;`
10. `/bin/zsh`
11. Setup the bare git repo

```bash
git init --bare $HOME/.cfg
config() {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME "$@"
}
config config --local status.showUntrackedFiles no
config remote add origin git@github.com:Fullchee/pihole-dotfiles.git
config fetch origin main
config reset --hard origin/main
config branch --set-upstream-to=origin/main main
zsh ~/.dotfiles/post-install.sh
```
