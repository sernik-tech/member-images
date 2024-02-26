<div align="center">
    <h1>Images</h1>
    <h3>By members of Sernik</h3>
</div>

<div align="center">

[![build-ublue](https://github.com/sernik-tech/member-images/actions/workflows/build.yml/badge.svg)](https://github.com/sernik-tech/member-images/actions/workflows/build.yml)

</div>

Custom [Universal Blue](https://universal-blue.org/) Images. Built by Sernik members for their own use-cases.

This repository by default supports signing.

###### Repository ran and maintained by [@sneexy-boi](https://github.com/sneexy-boi), owned by [@Rexogamer](https://github.com/Rexogamer).

## Images

<details>
<summary>

### Wuzetka

</summary>

sneexy's custom image for himself. comes with a bunch of applications and stuff preinstalled out of the box.

- custom sddm [config](https://github.com/sernik-tech/member-images/tree/live/config/files/sneexy/usr/etc/sddm.conf.d) and [theme](https://github.com/aczw/sddm-theme-corners/)
- customized [yafti](https://github.com/ublue-os/yafti) installer
- some [modern unix](https://github.com/ibraheemdev/modern-unix) utilities/replacements and zsh installed
- some [akmods](https://github.com/sernik-tech/member-images/blob/live/config/common/sneexy/akmods.yml)
- [some personal configurations](https://github.com/sernik-tech/member-images/tree/live/config/files/sneexy/usr/etc/systemd/resolved.conf.d)

</details>

## Installation

> [!WARNING]  
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

> [!IMPORTANT]  
> Replace `$IMAGE_NAME` in these commands with the appropriate image name in [packages](https://github.com/orgs/sernik-tech/packages?repo_name=member-images) (Alternatively found in the [recipes](https://github.com/sernik-tech/member-images/tree/live/config/recipes)).

To rebase an existing Silverblue/Kinoite installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/sernik-tech/$IMAGE_NAME:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/sernik-tech/$IMAGE_NAME:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

This repository builds date tags as well, so if you want to rebase to a particular day's build:

```
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/sernik-tech/$IMAGE_NAME:20230403
```

This repository by default also supports signing.

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

### ISO

This repository makes use of the [`startingpoint`](https://github.com/ublue-os/startingpoint) ISO GitHub Action. Builds are manually ran and an ISO will be produced under the [properly tagged release](https://github.com/sernik-tech/member-images/releases/tag/auto-iso). The ISO will include entries for members custom images (<i>If</i> they prefer that they show up in the ISO).

## Extra notes

Refer to "[The Tinkerer's Guide](https://universal-blue.org/tinker/make-your-own/)" on Universal Blue's website to learn how to (<i>properly</i>) customize your image

We have our own ["documentation"](https://github.com/sernik-tech/member-images/blob/live/sernik/README.md) if you want to refer to them, maintained by us. They serve more as mini-guides rather than full blown documentation though. Also includes what this repository is for and how to participate if you're a Sernik member.

for more information about the project this custom image is based on, check out the [uBlue homepage](https://universal-blue.org/) and the [main uBlue repo](https://github.com/ublue-os/main/)

You can refer to the main [Universal Blue GitHub](https://github.com/ublue-os/) if you want to see what more than be done.
