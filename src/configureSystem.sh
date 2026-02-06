# Dark theme
lookandfeeltool -a org.kde.breezedark.desktop

# Czech keyboard
sudo localectl set-keymap cz
sudo localectl set-x11-keymap cz

# Night mode
kwriteconfig6 --file kwinrc --group NightColor --key Mode Constant

# Numlock
kwriteconfig6 --file kcminputrc --group Keyboard --key NumLock 0

# Czech layout
kwriteconfig6 --file kcminputrc --group Keyboard --key LayoutList cs

# Natural scroll for Touchpad
systemsettings kcm_touchpad

# Build yay toolbox to AUR
sudo pacman -S --needed git base-devel --noconfirm
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Setup git config
git config --global user.name "KUTlime"
git config --global user.email "kutlime@gmail.com"
git config --global commit.gpgsign true
git config --global user.signingkey E6F5C966FC0D7CE0

# Fingerprint reader
sudo pacman -S fprintd imagemagick alsa-utils --noconfirm