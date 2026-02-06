# Install software
yay -Sy brave-bin --noconfirm
yay -Sy visual-studio-code-bin --noconfirm
yay -Sy powershell-bin --noconfirm
yay -Sy enpass-bin --noconfirm
sudo pacman -Sy gemini-cli --noconfirm
sudo pacman -Sy dotnet-sdk aspnet-runtime --noconfirm
sudo pacman -S krusader --noconfirm
sudo pacman -S vlc --noconfirm
sudo pacman -S kompare --noconfirm
sudo pacman -S krename --noconfirm
export PATH="$PATH:/home/radek/.dotnet/tools"

# Docker desktop
wget https://download.docker.com/linux/static/stable/x86_64/docker-29.2.0.tgz -qO- | tar xvfz - docker/docker --strip-components=1
sudo cp -rp ./docker /usr/local/bin/ && rm -r ./docker
cd ~/Stažené
wget https://desktop.docker.com/linux/main/amd64/217644/docker-desktop-x86_64.pkg.tar.zst
sudo pacman -U ./docker-desktop-x86_64.pkg.tar.zst
cd ~

yay -S rider --noconfirm