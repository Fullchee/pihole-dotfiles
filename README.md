# Pihole dotfiles

## Saving pihole changes to dotfiles

### Mac

Run `ssh-update-pihole-config`

### Browser

1. Go to <http://pi.hole/admin/settings/teleporter>
2. Export the zip file into the `pihole-dotfiles/.dotfiles` folder
3. Commit the pihole file
   1. `prek` will only keep the latest version

## Setup

### On Mac

1. Clone this repo
   1. `gh repo clone Fullchee/pihole-dotfiles`
3. `just mac-setup`
4. Install Raspberry Pi OS on an SD card
   1. `brew install --cask raspberry-pi-imager`
   2. Pick the latest `lite` debian version
   3. set the user to be `pihole`, call the computer `pihole`
5. Connect the pihole to power and to router via ethernet

### Asus router

1. Open the router app
   1. <http://asusrouter.com>
2. Get the IP address of the pihole
   1. Confirm you can `ssh pihole@<ip-address>`
   2. Run `sudo apt update` in the background
3. Router: reserve that IP address
   1. Asus: LAN -> DHCP -> Manually Assigned IP -> scroll down
   2. Can't do this with Beanfield Airties Air 4960x, even when logged into http://masternode.local/

### Mac terminal

1. `ssh-copy-id pihole@<ip-address>`
   1. (ssh without the typing the password)
2. `~/.ssh/config`: update the IP address of the `pihole` entry
3. Confirm you can `ssh pihole`

### SSHed on pihole

1. Generate an SSH key
   1. `ssh-keygen`
2. Copy the value of the public SSH key
   1. `cat ~/.ssh/id_ed25519.pub`
3. Add the key to GitHub as a deploy key (can just access this one repo)
   1. https://github.com/Fullchee/pihole-dotfiles/settings/keys
4. Setup the bare git repo

```bash
sudo apt update;
sudo apt upgrade -y;
sudo apt install -y git;
git config --global init.defaultBranch main
git init --bare $HOME/.cfg
config() {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME "$@"
}
config config --local status.showUntrackedFiles no
config remote add origin git@github.com:Fullchee/pihole-dotfiles.git
config fetch origin main
config checkout main
config reset --hard origin/main
config branch --set-upstream-to=origin/main main
bash ~/.dotfiles/post-install.sh
```

### Browser

1. Open pihole and import config
2. http://192.168.50.8/admin/settings/teleporter
3. Turn off Secure DNS in browsers
   1. `chrome://settings/security?search=secure+dns`
   2. Firefox: `about:preferences` -> search for `DNS over HTTPS` -> disable it

### Wrap up

1. Mac `System Settings` -> search for `DNS` -> Enter just the Pihole's IP address as the sole DNS server
   1. `iCloud` -> turn off Private Relay
2. Change passwords
   1. Raspberry pi
   2. pihole password
