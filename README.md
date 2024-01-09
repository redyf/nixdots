<h1 align="center">
<a href='#'><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="600px"/></a>
  <br>
  <br>
  <div>
    <a href="https://github.com/redyf/nixdots/issues">
        <img src="https://img.shields.io/github/issues/redyf/nixdots?color=fab387&labelColor=303446&style=for-the-badge">
    </a>
    <a href="https://github.com/redyf/nixdots/stargazers">
        <img src="https://img.shields.io/github/stars/redyf/nixdots?color=ca9ee6&labelColor=303446&style=for-the-badge">
    </a>
    <a href="https://github.com/redyf/nixdots/blob/master/LICENSE">
        <img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&logoColor=ca9ee6&colorA=313244&colorB=cba6f7"/>
    </a>
    <br>
    </div>
   </h1>
   <br>

<div align="center">
<h1>
❄️ NixOS dotfiles ❄️
</h1>
</div>
<h2 align="center">NixOS system configuration. Feel free to explore!</h2>

## Special thanks to:

- [AlphaTechnolog](https://github.com/AlphaTechnolog/nixdots)
- [Eriim's](https://github.com/erictossell/nixflakes)
- [IogaMaster](https://github.com/IogaMaster)
- [linuxmobile](https://github.com/linuxmobile)
- [NixOS Manual](https://nixos.org/manual/nixos/stable/)
- [NotAShelf](https://github.com/NotAShelf/nyx)
- [notusknot](https://github.com/notusknot)
- [Siduck76](https://github.com/siduck76/nvchad/)
- [Sioodmy](https://github.com/sioodmy/dotfiles)
- [ZerotoNix](https://zero-to-nix.com)

<div align="center">
<img align="right" src="https://cdn.discordapp.com/attachments/933711967217123411/1155200026486780005/rice.png" alt="Rice Preview" width="400px" height="253"/>
<img align="right" src="https://cdn.discordapp.com/attachments/933711967217123411/1155200026058952724/nvim.png" alt"Rice Preview2" width="400px" height="253"/>
</div>

```mint
⠀⠀   🌸 Setup / Hyprland 🌸
 -----------------------------------

 ╭─ Distro  -> NixOS
 ├─ Editor  -> Neovim
 ├─ Browser -> Firefox / Chrome
 ├─ Shell   -> ZSH
 ╰─ Resource Monitor -> Btop

 ╭─ Model -> DELL XPS 8940
 ├─ CPU   -> Intel i5-10400f @ 4.3GHz
 ├─ GPU   -> NVIDIA GeForce GTX 1650 SUPER
 ╰─ Resolution -> 1920x1080@165hz

 ╭─ WM       -> Hyprland
 ├─ Terminal -> Foot
 ├─ Theme    -> Catppuccin
 ├─ Icons    -> Papirus-Dark
 ├─ Font     -> JetBrains Mono Nerd Font
 ╰─ Hotel    -> Trivago

                        
```

## Commands you should know:

- Rebuild and switch to change the system configuration (in the configuration directory):

```
rebuild
```

OR

```
sudo nixos-rebuild switch --flake '.#redyf'
```

- Connect to internet (Change what's inside the brackets with your info).

```
iwctl --passphrase [passphrase] station [device] connect [SSID]
```

## Installation

I'll guide you through the Installation, but first make sure to download the Minimal ISO image available at [NixOS](https://nixos.org/download#nixos-iso) and make a bootable drive with it. I suggest using [Rufus](https://rufus.ie/en/) for the task as it's a great software.
Also I'm going to use an ethernet cable for the tutorial to make things easier. We shall begin!

### Installation Steps

**Only follow these steps after using the bootable drive, changing BIOS boot priority and getting into the installation!**

```
First part:

video=1920x1080

setfont ter-128n

configure networking as needed (skip this if you're using ethernet)

sudo -i

lsblk (check info about partitions and the device you want to use for the installation)

gdisk /dev/vda (change according to your system, for me it's /dev/nvme0n1)

then configure 600M type ef00, rest ext4 type 8300 as described below

Type "n" to make a new partition, choose the partition number, first sector can be default but last sector should be 600M. Hex code for EFI is ef00.

Now type n again to make another partition, this time we'll leave everything as default. After finishing these steps, make sure to write it to the disk by typing "w".

lsblk

mkfs.fat -F 32 -n boot /dev/vda1 (Format the partitions)

mkfs.ext4 -L nixos /dev/vda2

mount /dev/disk/by-label/nixos /mnt (Mount partitions)
mkdir /mnt/boot (Create a directory for boot)
mount /dev/disk/by-label/boot /mnt/boot
```

After mounting the partitions, you can move to the second part...

```
# go inside a nix shell with the specified programs
nix-shell -p git nixUnstable neovim

# create this folder if necessary
mkdir -p /mnt/etc/

# clone the repo
git clone https://github.com/redyf/nixdots.git /mnt/etc/nixos --recurse-submodules

# remove this file
rm /mnt/etc/nixos/hosts/redyf/hardware-configuration.nix

# generate the config and take some files
nixos-generate-config --root /mnt
rm /mnt/etc/nixos/configuration.nix
mv /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/hosts/redyf

# make sure you're in this path
cd /mnt/etc/nixos

# Install my config:
nixos-install --flake '.#redyf'

# Obs:
If you'd like to use my config as a template, all you need to do is replace "redyf" with your username.
```

Credits for the installation section goes to [Stephenstechtalks](https://github.com/stephenstechtalks) and [AlphaTechnolog](https://github.com/AlphaTechnolog) as they helped a lot with their installation guides.

## Conclusion

That should be all! If you have any problem, feel free to make an issue in the github repo. (https://github.com/Redyf/nixdots/issues).

The code is licensed under the MIT license, so you can use or distribute the code however you like. If you have any questions, contact me on Discord: `redyf`.
