# So-called "Documentation"

Some mini "documentation", but it's more just like tiny little guides for people who just want to quickly start/create/manage some things. This is not documentation related to the actual uBlue, KDE, Kinoite, Fedora, etc. projects.

For those cases, refer to the following instead:

- [Universal Blue](https://universal-blue.org/)'s homepage
    - [FAQ](https://universal-blue.org/faq/)
    - [Introduction](https://universal-blue.org/introduction/)
    - [Cheatsheet](https://universal-blue.org/cheatsheet/just/)
- [Fedora Kinoite](https://fedoraproject.org/kinoite/)'s homepage
    - [Kinoite Community](https://fedoraproject.org/kinoite/community/)
    - [Fedora Kinoite User Guide](https://docs.fedoraproject.org/en-US/fedora-kinoite/)
- [Fedora's Documentation](https://docs.fedoraproject.org/en-US/)
- [Distrobox](https://distrobox.it/)
- [KDE Community](https://kde.org/)
    - [KDE Support](https://kde.org/support/)

<small>This means I have to capitalize stuff now. Sorry.</small>

## Contents

- [Setting up an Arch and Fedora distroboxes](#setting-up-an-arch-and-fedora-distroboxes)
- [ThinkPad T480 Fingerprint Setup](#thinkpad-t480-fingerprint-setup)
- [Colored papirus icons](#colored-papirus-icons)


## Setting up an Arch and Fedora distroboxes

Preparing some distroboxes for extra packages I decide to install later, you could also try Nix/Fleek but I've tried it myself with no luck.

Setting up the distroboxes
```bash
# arch and fedora
distrobox-create -n fedora -i fedora:39
distrobox-create -n arch -i archlinux:latest
```

Configuring Fedora with rpmfusion
```bash
# enter the fedora box, it will take a while if it's the first time you're running this command
distrobox-enter fedora
# add rpmfusion
sudo dnf install 'dnf-command(config-manager)'
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm && sudo dnf config-manager --enable fedora-cisco-openh264
# refresh and install extra packages
sudo dnf groupupdate core
# exits the fedora distrobox back into your host. use "exit" when you're done and want to get out of a box
exit
```

Configuring Arch with paru [invalid instructions]
```bash
# enter the arch box, it will take a while if it's the first time you're running this command
distrobox-enter arch
# install text editor, add multilib repo and update
sudo pacman -Syu nano
sudo nano /etc/pacman.conf
# i don't know how to automate this, but scroll down until you hit the part that
# says "repositories". add the following after the [extra] part:
#
# [multilib]
# Include = /etc/pacman.d/mirrorlist
#
# press ctrl + X and hit enter to save.
sudo pacman -Syu
# install necessary packages for paru
sudo pacman -S --needed base-devel git
# clone paru repo and cd into it
git clone https://aur.archlinux.org/paru.git && cd paru
# build and install it
makepkg -si
```

## ThinkPad T480 Fingerprint Setup

> ![TIP]
> This is included as a just script! Run `just setup-t480-fingerprint`

Short guide taken and modified from [borcean's gist](https://gist.github.com/borcean/f32c47f6cc52cee33dfc2265ce63f777).

Installing the Copr repository and `python3-validity`
```bash
# downloads the copr repo
cd /etc/yum.repos.d/
sudo wget https://copr.fedorainfracloud.org/coprs/sneexy/python-validity/repo/fedora-$(rpm -E %fedora)/sneexy-python-validity-fedora-$(rpm -E %fedora).repo
# override and install fprintd packages
rpm-ostree override remove fprintd fprintd-pam --install open-fprintd --install fprintd-clients --install fprintd-clients-pam --install python3-validity
```

Configuring fingerprint reader
```bash
# pre-prep fingerprint reader
sudo validity-sensors-firmware
sudo python3 /usr/share/python-validity/playground/factory-reset.py
# enabling and starting services
sudo systemctl enable python3-validity open-fprintd-resume open-fprintd-suspend
sudo systemctl start python3-validity
```

Enroll and test your reader
```bash
fprintd-enroll
fprintd-verify
```

Enabling fingerprint authentication
```bash
# configures current authentication methods to use fingerprint and apply
sudo authselect current
sudo authselect enable-feature with-fingerprint
sudo authselect apply-changes
```

## Colored papirus icons

> ![TIP]
> This is included as a just script! Run `just colored-papirus-icons`

An alternative way to set up colored papirus icons. This is because custom projects like [catppuccin's papirus-folder](https://github.com/catppuccin/papirus-folders) require that you directly modify the papirus folders (located in `/usr/`, which is read-only) which is both unsupported with Atomic desktops and is also just an incredibly hacky/janky way of doing this.

The method we'll use is [papirus-colors](https://github.com/luisbocanegra/papirus-colors/), which will simply make a recolored version of some icons (such as folders) from your accent color set from your Plasma theme, then installs it as a local icon pack and only applying the custom folders/symbolic icons on top of papirus!

Setup is *very* simple. Just clone and run the script:
```bash
# clone the repository to tmp
git clone https://github.com/luisbocanegra/papirus-colors/ /tmp/papirus-colors
# make sure it's executable
chmod +x /tmp/papirus-colors/places_icons_mod.sh
# run the script
/tmp/papirus-colors/places_icons_mod.sh
```

Once it's done, just go into your System Settings and set the new "Papirus Colors" pack!
