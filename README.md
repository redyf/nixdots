<h1 align="center">
<a href='#'><img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/palette/macchiato.png" width="600px"/></a>
  <br>
  <div>
    <a href="https://github.com/redyf/nixdots/issues">
        <img src="https://img.shields.io/github/issues/redyf/nixdots?color=fab387&labelColor=303446&style=for-the-badge">
    </a>
    <a href="https://github.com/redyf/nixdots/stargazers">
        <img src="https://img.shields.io/github/stars/redyf/nixdots?color=ca9ee6&labelColor=303446&style=for-the-badge">
    </a>
    <a href="https://github.com/redyf/nixdots">
        <img src="https://img.shields.io/github/repo-size/redyf/nixdots?color=ea999c&labelColor=303446&style=for-the-badge">
    </a>
    <a href="https://github.com/redyf/nixdots/LICENSE">
        <img src="https://img.shields.io/static/v1.svg?style=for-the-badge&label=License&message=MIT&logoColor=ca9ee6&colorA=313244&colorB=cba6f7"/>
    </a>
    <br>
    </div>
        <img href="https://builtwithnix.org" src="https://builtwithnix.org/badge.svg"/>
   </h1>

<div align="center">
<h1>
❄️ NixOS dotfiles ❄️
</h1>
</div>
<h2 align="center">NixOS system configuration. Feel free to explore!</h2>

```mint
⠀⠀   🌸 Setup / Hyprland 🌸
 -----------------------------------
 ╭─ Distro  -> NixOS
 ├─ Editor  -> Neovim
 ├─ Browser -> Zen
 ├─ Shell   -> Zsh
 ╰─ Resource Monitor -> Btop
 ╭─ Model -> DELL XPS 8940
 ├─ CPU   -> Intel i5-10400f @ 4.3GHz
 ├─ GPU   -> NVIDIA GeForce GTX 1650 SUPER
 ╰─ Resolution -> 1920x1080@165hz
 ╭─ WM       -> Hyprland
 ├─ Terminal -> Ghostty
 ├─ Theme    -> Tokyonight
 ├─ Icons    -> Papirus-Dark
 ├─ Font     -> TX-02
 ╰─ Hotel    -> Trivago
                        
```

<hr>

<details>
<summary>Minimal Desktop</summary>

![wallpaper](screenshots/screenshot.png)
![terminal](screenshots/screenshot2.png)

</details>

## Commands you should know:

- Validate the flake:

```bash
nix flake check
```

- Build the safe example system without switching your machine:

```bash
nix build '.#nixosConfigurations.example.config.system.build.toplevel'
```

- Build the safe example Home Manager activation package:

```bash
nix build '.#homeConfigurations.example.activationPackage'
```

- Rebuild and switch to change the system configuration (in the configuration directory):

```
nh os switch
```

OR

```
sudo nixos-rebuild switch --flake '.#desktop'
```

- Connect to internet (Change what's inside the brackets with your info).

```
nmcli device wifi connect [SSID] password [passphrase]
```

## Secrets

This repo uses `sops-nix` for encrypted secrets, including the desktop user password. See [`docs/sops-setup.md`](docs/sops-setup.md) for the step-by-step guide.

## Structure

- `flake.nix` discovers NixOS hosts from `hosts/*` and Home Manager users from `home/users/*.nix`.
- `hosts/<name>/configuration.nix` contains host-specific system settings.
- `profiles/` contains shared defaults imported by hosts.
- `profiles/nixos/minimal.nix` and `profiles/home/minimal.nix` provide safer public defaults for examples.
- `modules/` contains reusable NixOS modules exposed under `myConfig`.
- `home/` contains reusable Home Manager modules exposed under `myHomeConfig`.
- `hosts/example` and `home/users/example.nix` are the recommended starting points for users testing this repo.
- `ci/font-flake-fallback` provides a public font fallback for unauthenticated builds.
- `lib/` contains helper functions used to create hosts and home configurations.

## Private Font

The public default uses a local fallback flake that exposes `tx02` as JetBrains Mono. To use the private font flake locally, override the input:

```bash
nh os switch -- --override-input font-flake github:redyf/font-flake
nh home switch -- --override-input font-flake github:redyf/font-flake
```

## Installation

> [!CAUTION]
> `desktop` and `selene` are my personal machines. Do not install them directly
> on your hardware unless you have reviewed every host-specific setting,
> generated your own hardware config, and understand the disk layout.
> Deploying someone else's NixOS host can make a machine unbootable or destroy data.

If you want to test this repository, start with the safe example outputs:

```bash
nix build '.#nixosConfigurations.example.config.system.build.toplevel'
nix build '.#homeConfigurations.example.activationPackage'
```

The example host uses username `example` and initial password `nixos`. Treat it as
a learning target, not a final install profile.

I'll guide you through the Installation, but first make sure to download the Minimal ISO image available at [NixOS](https://nixos.org/download#nixos-iso) and make a bootable drive with it. I suggest using [Rufus](https://rufus.ie/en/) for the task as it's a great software,
and an ethernet cable to make things easier. We shall begin!

<details>
    <summary>Installation Steps</summary>

<strong>

Only follow these steps after using the bootable drive, changing BIOS boot priority and getting into the installation!

</strong>

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
rm /mnt/etc/nixos/hosts/desktop/hardware-configuration.nix
# generate the config and take some files
nixos-generate-config --root /mnt
rm /mnt/etc/nixos/configuration.nix
mv /mnt/etc/nixos/hardware-configuration.nix /mnt/etc/nixos/hosts/desktop/
# make sure you're in this path
cd /mnt/etc/nixos
# Install my personal desktop config only after adapting hardware and secrets:
nixos-install --flake '.#desktop'
# Obs:
If you'd like to use my config as a template, copy `hosts/example` and `home/users/example.nix`, then update the matching metadata in `hosts/<name>/meta.nix`.
```

</details>
<hr>

Disko is also available for formatting partitions (Only for advanced users)

<details>
<summary>Disko</summary>

Disko commands are destructive. Always pass the target disk explicitly and verify it with `lsblk` first.

If you save disko's config file in **./disks/default.nix**, and run the following command:

```nix
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko ./disks/default.nix --arg device '/dev/nvme0n1'
```

you will partition, format and mount the disk for /dev/nvme0n1 (change as needed).

</details>

<hr>

## NixOS Raspberry PI5 Installation (Not working anymore because raspberry-pi-nix was archived)

### Requirements

- rpi-imager
- sd-card
- Raspberry-PI5
- Another device to connect remotely (PC, Laptop, etc)
- Ethernet connection

### Installation Steps

1. **Open rpi-imager** and select your device, then Raspberry Pi OS and sd-card.
2. **Customize settings** to your needs, like defining a user/hostname and enabling ssh.
3. **Insert the sd-card** in your Raspberry PI5 and boot.

4. **Install Nix** on it by running the following command:

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

5. **Install Cachix client** by running:

```bash
nix-env -iA cachix -f https://cachix.org/api/v1/install
```

6. **Start using the binary cache** by running:

```bash
cachix use nix-community
```

7. **Clone the following repo**:

```bash
https://github.com/nix-community/raspberry-pi-nix.git
```

8. **Customize `flake.nix`** to match your needs, like changing hostname, timezones, etc.

9. **Build an image** suitable for flashing to an sd-card by running:

```
nix build '.#nixosConfigurations.rpi-example.config.system.build.sdImage'
```

10. **Connect to your main machine** with ssh and copy the image to it using scp. You can use the following commands:

```
scp /path/to/file username@a:/path/to/destination
```

or

```
scp username@b:/path/to/file /path/to/destination
```

11. **Decompress the image with zstd**, this is going to generate a .img file.

```bash
sudo zstd -d result/sd-image/nixos-sd-image-24.05.20240619.dd457de-aarch64-linux.img.zst
```

11. **Copy the image to your sd-card**:

```bash
sudo dd bs=4M if=result/sd-image/nixos-sd-image-24.05.20240619.dd457de-aarch64-linux.img of=/dev/mmcblk0 conv=fsync oflag=direct status=progress
```

12. **Boot the Raspberry-PI5 with the sd-card and you should be good to go**

All references are written below. I wouldn't be able to install it without them! I really appreciate their hard work, make sure to give them a star.

<hr>

## All references/credits for the NixOS Raspberry-PI 5 setup:

- [Raspberry PI 5 support](https://github.com/NixOS/nixpkgs/issues/260754)
- [NixOS on ARM/Raspberry Pi 5](https://wiki.nixos.org/wiki/NixOS_on_ARM/Raspberry_Pi_5)
- [Pi 5 support](https://github.com/nix-community/raspberry-pi-nix/issues/13)
- [raspberry-pi-nix](https://github.com/nix-community/raspberry-pi-nix)
- [raspberry-pi-nix binary cache](https://app.cachix.org/cache/raspberry-pi-nix)
- [nix-rpi5](https://gitlab.com/vriska/nix-rpi5)
- [raspberrypi/firmware](https://github.com/raspberrypi/firmware)

## Shoutout to:

- [AlphaTechnolog](https://github.com/AlphaTechnolog/nixdots)
- [Eriim's](https://github.com/erictossell/nixflakes)
- [IogaMaster](https://github.com/IogaMaster)
- [linuxmobile](https://github.com/linuxmobile)
- [NotAShelf](https://github.com/NotAShelf/nyx)
- [notusknot](https://github.com/notusknot)
- [Siduck76](https://github.com/siduck76/nvchad/)
- [Sioodmy](https://github.com/sioodmy/dotfiles)
- [Stephenstechtalks](https://github.com/stephenstechtalks)
- [ZerotoNix](https://zero-to-nix.com)
- [NobbZ](https://github.com/NobbZ)

<hr>

## Conclusion

That should be all! If you have any problem, feel free to make an issue in the github repo. (https://github.com/Redyf/nixdots/issues).

The code is licensed under the MIT license, so you can use or distribute the code however you like. If you have any questions, contact me on Discord: `redyf`.
