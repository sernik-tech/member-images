<div align="center">
    <h1>Images</h1>
    <h3>By members of Sernik</h3>
</div>

<div align="center">

[![build-ublue](https://github.com/sernik-tech/member-images/actions/workflows/build.yml/badge.svg)](https://github.com/sernik-tech/member-images/actions/workflows/build.yml)

</div>

Custom [Universal Blue](https://universal-blue.org/) Powered Images, built with [BlueBuild](https://blue-build.org/). Built by Sernik members for their own use-cases.

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

<details>
<summary>

### Mazurek

</summary>

sneexy's custom hyprland based image mostly for himself. comes mostly preconfigured!... but not really recommended for anyone else.

> [!IMPORTANT]
> after installing, on first boot you may find yourself stuck at a blank screen. just wait for a few seconds, and then reboot by either pressing the power button or by logging into another tty and running `systemctl reboot`.

> ![NOTE]
> if you're *rebasing* from another image, do note that you won't get the custom configurations right after installation. a simple fix is to quickly log into a tty and run `just mazurek` to quickly get yourself set up, then rebooting/logging in and out.

> ![NOTE]
> this image is mostly configured for personal use. you can use this image if you want to, but some things either may not work or just aren't compatible. along with extra customizations and settings you may not prefer.

- fill this list out aaaa

</details>

## Installation

> [!WARNING]  
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

> [!IMPORTANT]  
> Replace `$IMAGE_NAME` in these commands with the appropriate image name in [packages](https://github.com/orgs/sernik-tech/packages?repo_name=member-images) (Alternatively found in the [recipes](https://github.com/sernik-tech/member-images/tree/live/config/recipes)).

To rebase an existing atomic Fedora installation to the latest build:

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

The `latest` tag will automatically point to the latest build. That build will still always use the Fedora version specified in `recipe.yml`, so you won't get accidentally updated to the next major version.

### ISO

Refer to [BlueBuild's "Installing an image based on Universal Blue"](https://blue-build.org/learn/universal-blue/#fresh-install-from-an-iso) to learn how to generate an ISO with the image you want to use. The required tools for it should be pre-installed on any Universal Blue based image.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/sernik-tech/$IMAGE_NAME
```

## Extra notes

> [!NOTE]
> <b>TODO:</b> Update our docs and update all references to BlueBuild and such.

Refer to the [BlueBuild documentation](https://blue-build.org/learn/getting-started/) to learn on how to customize your image.

We have our own ["documentation"](https://github.com/sernik-tech/member-images/blob/live/sernik/README.md) if you want to refer to them, maintained by us. They serve more as mini-guides rather than full blown documentation though. Also includes what this repository is for and how to participate if you're a Sernik member.

For more information about the project this repository is based on, check out the [Universal Blue homepage](https://universal-blue.org/) and the [BlueBuild homepage](https://blue-build.org/).

You can refer to both the main [BlueBuild GitHub](https://github.com/blue-build/) and [Universal Blue GitHub](https://github.com/ublue-os/) if you want to see what more than be done.
