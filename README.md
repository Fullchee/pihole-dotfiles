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
   2. `ssh pi@<ip-address>`
   3. Update the IP address in `~/.ssh/config`
   4. `ssh-copy-id pi@<ip-address>`
   5. now you can just login with `ssh pi@<ip-address>`
4. Router: reserve that IP address
   1. I don't know how to do this with the Beanfield Airties Air 4960x, even when logged into http://masternode.local/
5. Update the IP address in https://github.com/Fullchee/mac-dotfiles/blob/.ssh/config

### SSHed on pihole

5. Set the static IP address on the Pihole OS
   1. `ip a`
   2. `sudo nmcli con mod "netplan-eth0" ipv4.addresses 10.88.111.14/24 ipv4.gateway 10.88.111.254 ipv4.dns "1.1.1.1,8.8.8.8" ipv4.method manual`
   3. `sudo nmcli con up "netplan-eth0"`
6. Generate an SSH key
   1. `ssh-keygen`
7. Copy the value of the public SSH key
   1. `cat ~/.ssh/id_ed25519.pub`
8. Add the key to GitHub as a deploy key (can just access this one repo)
   1. https://github.com/Fullchee/pihole-dotfiles/settings/keys
9. Install and switch to zsh
10. `sudo apt -y install zsh;`
11. `/bin/zsh`
12. Setup the bare git repo

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

12. Install pihole
    1.  `curl -sSL https://install.pi-hole.net | bash`
13. Update the password `sudo pihole setpassword`
14. Go to Pi-hole admin interface
    1.  http://[ip-address-of-pihole]/admin
15.
