# So-called "Documentation"

Some documentation for our images. If you're looking for actual documentation related to anything about Universal Blue, Fedora, Immutable desktops, etc. Refer to the following instead:

- [Universal Blue](https://universal-blue.org/)'s homepage
    - [FAQ](https://universal-blue.org/faq/)
    - [Introduction](https://universal-blue.org/introduction/)
    - [Cheatsheet](https://universal-blue.org/cheatsheet/just/)
- [Fedora Kinoite](https://fedoraproject.org/kinoite/)'s homepage
    - [Kinoite Community](https://fedoraproject.org/kinoite/community/)
    - [Fedora Kinoite User Guide](https://docs.fedoraproject.org/en-US/fedora-kinoite/)
- [Fedora Silverblue](https://fedoraproject.org/silverblue/)'s homepage
    - [Silverblue Community](https://fedoraproject.org/silverblue/community/)
    - [Fedora Silverblue User Guide](https://docs.fedoraproject.org/en-US/fedora-silverblue/)
- [Fedora's Documentation](https://docs.fedoraproject.org/en-US/)
- [Distrobox](https://distrobox.it/)
- [KDE Community](https://kde.org/)
    - [KDE Support](https://kde.org/support/)

## Contents

- [Tips](#tips)
    - [Setting up Distrobox and having some fun](#setting-up-distrobox-and-having-some-fun)
    - [ThinkPad T480 Fingerprint Setup](#thinkpad-t480-fingerprint-setup)
    - [Colored papirus icons](#colored-papirus-icons)
- [Sernik member's guide to participating](#sernik-members-guide-to-participating)


## Tips

## Setting up Distrobox and having some fun

[Distrobox](https://distrobox.it/) is a utility that can provide near perfect integration and performance of any Linux distro on your uBlue image! Distroboxes can be used to install pacakges you'd prefer not to layer onto your image, for development or testing purposes, or even gaming.

For this, we'll setup an Ubuntu and Fedora distrobox:
```bash
# note: custom optimized ubuntu distrobox image is based on LTS.
# to fetch latest ubuntu, replace the link with "quay.io/toolbx/ubuntu-toolbox:latest"
distrobox create --image ghcr.io/ublue-os/ubuntu-toolbox:latest --name ubuntu --pull
distrobox create --image ghcr.io/ublue-os/fedora-toolbox:latest --name fedora --pull
```

Now, we'll enter Ubuntu and for this example we'll install and export VSCodium:
```bash
# this will take a short bit if it's the first time you've run this command
distrobox enter ubuntu
# average vscodium install setup for ubuntu, taken from https://vscodium.com/
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list

sudo apt update && sudo apt install codium
# of course, we can run the command to launch it and it ✨ magically ✨ integrates with your desktop
codium
# ...and we can *export* it and have it integrated within your application launcher for ease of access!
# this command only works within the distrobox/container it's installed in
distrobox-export --app codium
```

Neat! Now, we'll try installing some fun CLI tools within the Fedora distrobox:
```bash
distrobox enter fedora
# we'll just install fastfetch and cava here
sudo dnf install fastfetch cava
# once they're installed, run them, and you can see that they run perfectly fine!
fastfetch
cava
# and of course, like exporting apps, we can export the commands to run on our host!
distrobox-export --bin /usr/bin/fastfetch
distrobox-export --bin /usr/bin/cava
# exit the container and run the commands, they work!
```

Refer to [Distrobox's](https://distrobox.it/) homepage for more documentation and info.

It's recommended to use a terminal dedicated for containers/Distroboxes such as [Boxi](https://boxi.dev/).

## ThinkPad T480 Fingerprint Setup

Short guide taken and modified from [borcean's gist](https://gist.github.com/borcean/f32c47f6cc52cee33dfc2265ce63f777), using my own Copr repository updated to work with Immutable flavors.

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

## Sernik member's guide to participating

## Managing the repository

> [!IMPORTANT]
> Do <b><i>NOT</i></b> modify the `template` branch. The way forked custom Universal Blue images work is that all modifications done by us should be done via the `live` branch, the `template` branch stays vanilla and gets synced with upstream, so we can cleanly rebase the `live` branch onto the `template` branch and keep it up to date!

## Making your own custom image

Refer to "[The Tinkerer's Guide](https://universal-blue.org/tinker/make-your-own/)" on Universal Blue's website to learn how to (<i>properly</i>) customize your image.

We have an (...I'll admit, *poorly* documented) example configuration over under [`recipes/example`](https://github.com/sernik-tech/member-images/tree/live/config/recipes/example) for both Kinoite (KDE Plasma) and Silverblue (GNOME) based customizations/image. All of the files should link back to each other and have been properly linked so it *should* make following them and learning what they do much easier.

If you have any questions, refer to the [documentation](https://universal-blue.org/tinker/modification/), original [`startingpoint`](https://github.com/ublue-os/startingpoint) repository, or ask any other members (maybe [@sneexy_boi](https://github.com/sneexy_boi) would be your best shot) if you have any questions about something!

## Modifying the README

If you want to add any extra info to the README's or anything, such as this documentation, feel free to do so!

If you want to add your own image to the list on the main README, feel free to use the template provided below by seeing the entire raw thing and copy pasting it then modifying it to fit your needs. It doesn't have to be the template, it can really be anything, but it serves as a decent starting point to add it.

> ![NOTE]
> You <i>don't have to</i> add your image to the README if you don't want to.

<details>
<summary>

### A members custom image

</summary>

This is a brief introduction about the image. Something about what it does or what it's for. Or not. Anything can be here to be honest.

What this totally real image includes:

- Very generic/Highly customized Silverblue/Kinoite/Whatever install
- A customized [yafti](https://github.com/ublue-os/yafti) installer
  - More options of applications to install post-install, all as Flatpaks
- Some [modern unix](https://github.com/ibraheemdev/modern-unix) utilities
- Some [akmods](https://github.com/ublue-os/akmods)
  - [v4l2loopback](https://github.com/umlaeute/v4l2loopback)
  - [winesync](https://repo.or.cz/linux/zf.git/shortlog/refs/heads/winesync4)
  - [xone](https://github.com/BoukeHaarsma23/xonedo/)
  - [xpadneo](https://github.com/atar-axis/xpadneo)
- Changes from Arch Linux
  - Free Windows activator
- **Personal changes**
  - Paid CatGPT API Key included
  - Expired cheese

<details>
<summary>

## Installation for dummy

<!--- You don't have to, but we'd prefer if you included the name of your image in the "Installation" header *just* so it's easier to tell a difference between which section is which. --->

</summary>

<!---
REMEMBER to change these commands below so they redirect to your image!
Example: [...]ghcr.io/sernik-tech/NAME_OF_YOUR_IMAGE_HERE[...]
--->

To rebase an existing Silverblue/Kinoite installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/sernik-tech/dummy:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/sernik-tech/dummy:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

This repository builds date tags as well, so if you want to rebase to a particular day's build:

```
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/sernik-tech/dummy:20230403
```

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

</details>

</details>
