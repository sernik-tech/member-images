<div align="center">
    <h1>Images</h1>
    <h3>By members of Sernik</h3>
</div>

<div align="center">

[![build-ublue](https://github.com/sernik-tech/member-images/actions/workflows/build.yml/badge.svg)](https://github.com/sernik-tech/member-images/actions/workflows/build.yml)

</div>

Custom [Universal Blue](https://universal-blue.org/) Images. Built by Sernik members for their own use-cases.

This repository by default also supports signing.

###### Repo owned by [@sneexy-boi](https://github.com/sneexy-boi).

## Images

<details>
<summary>

### Sneexy's slice

</summary>

custom image for myself, used with my thinkpad t480. a very vanilla kinoite-ublue out of the box install because i do all customizations myself post-install. :bowtie:

what this includes:

- a mostly simple and average Kinoite out of the box experience
  - some icons and themes preinstalled out of the box
- customized [yafti](https://github.com/ublue-os/yafti) installer
  - options to install more kde apps, gnome apps, gaming, internet/chat, utilities, all as flatpaks
- some [modern unix](https://github.com/ibraheemdev/modern-unix) utilities/replacements and zsh installed
- some [akmods](https://github.com/ublue-os/akmods)
  - [v4l2loopback](https://github.com/umlaeute/v4l2loopback)
  - [winesync](https://repo.or.cz/linux/zf.git/shortlog/refs/heads/winesync4)
  - [xone](https://github.com/BoukeHaarsma23/xonedo/)
  - [xpadneo](https://github.com/atar-axis/xpadneo)
- custom [justfiles](https://github.com/casey/just) scripts
  - some taken from [bazzite](https://github.com/ublue-os/bazzite)
    - waydroid cleaning, initialization, and waydroid_script helper scripts
    - patch 64bit garry mod's
    - add user to input group
    - enable virtualization/install qemu and virt-manager
    - install scrcpy
    - add and remove virtual audio channels/sinks
  - some of my own
    - thinkpad t480 fingerprint setup helper
    - discord/vesktop rpc fix
    - fix flatpak theme issues
- **some personal configurations (you may not want)**
  - forced systemd-resolved dns settings *(due to personal internet issues)*
  - uBlue's `laptop` bling

<details>
<summary>

## Installation for Sneexy's slice

</summary>

<b><i>This image is included in the ISO.</i></b>

to rebase an existing Silverblue/Kinoite installation to the latest build:

- first rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/sernik-tech/sneexys-slice:latest
  ```
- reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/sernik-tech/sneexys-slice:latest
  ```
- reboot again to complete the installation
  ```
  systemctl reboot
  ```

this repository builds date tags as well, so if you want to rebase to a particular day's build:

```
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/sernik-tech/sneexys-slice:20230403
```

the `latest` tag will automatically point to the latest build. that build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

</details>

</details>

### ISO

This repository makes use of the [`startingpoint`](https://github.com/ublue-os/startingpoint) ISO GitHub Action. Builds are manually ran and an ISO will be produced under the [properly tagged release](https://github.com/sernik-tech/member-images/releases/tag/auto-iso). The ISO will include entries for members custom images (<i>If</i> they prefer that they show up in the ISO).

## Extra notes

Refer to "[The Tinkerer's Guide](https://universal-blue.org/tinker/make-your-own/)" on Universal Blue's website to learn how to (<i>properly</i>) customize your image

We have our own ["documentation"](https://github.com/sneexy-boi/sernik/blob/live/docs.md) if you want to refer to them, maintained by us. They serve more as mini-guides rather than full blown documentation though. Also includes how to modify this Readme yourself if you're a Sernik member.

for more information about the project this custom image is based on, check out the [uBlue homepage](https://universal-blue.org/) and the [main uBlue repo](https://github.com/ublue-os/main/)

You can refer to the main [Universal Blue GitHub](https://github.com/ublue-os/) if you want to see what more than be done.

<details>
<summary>Template to add your image to the "Images" list</summary>

<b>You don't have to add your own image to the list if you don't want to.</b>

You can use the template below if you wish, or just make anything you want.

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
