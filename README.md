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

sneexy's heavily opinionated image. uses KDE Plasma with a custom configuration and comes with a handful of applications preinstalled that you probably don't want.

preconfigured with a custom sddm theme *(no system settings kcm)*, custom desktop theme and layout (Catppuccin Mocha Green!), akmods and forced dns settings.

</details>

<details>
<summary>

### Mazurek

</summary>

sneexy's *other* heavily opinionated image. uses Hyprland with a full set of customized dotfiles (Catppuccin Mocha Green!) and handful of applications that you probably don't want.

> **⚠️ Important:** after installing, on first boot you may find yourself stuck at a blank screen. just wait for a few seconds, and then reboot by either pressing the power button or by logging into another tty and running `systemctl reboot`.

> **ℹ️ Note:** if you're *rebasing* from another image, do note that you won't get the custom configurations right after installation. a simple fix is to quickly log into a tty and run `just mazurek` to quickly get yourself set up, then rebooting/logging in and out.

> **ℹ️ Note:** this image is mostly configured for personal use. you can use this image if you want to, but some things either may not work or just aren't compatible. along with extra customizations and settings you may not prefer.

> **🛑 Caution:** i am not actively working on this image, and due to the many weird workarounds that this uses some things may be broken or may not work. i sadly can't really fix anything weird here so this image is paused until they either fix these without me having to use workarounds or until i decide to just repurposed the image/this name. (maybe a modified gnome/cosmic image?)

comes with hyprland, full set of custom applications, average riced window manager type stuff. [dotfiles here](https://git.gay/sneexy/mazurek-dots) for those who just want the configuration (which is probably more recommended than using this image).

</details>

## Installation

> [!WARNING]  
> [This is an experimental feature](https://www.fedoraproject.org/wiki/Changes/OstreeNativeContainerStable), try at your own discretion.

> [!IMPORTANT]  
> Type `IMAGE_NAME=<image_name>` into your console, replacing `<image_name>` with an available image found in [packages](https://github.com/orgs/sernik-tech/packages?repo_name=member-images), before running these commands.

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

Refer to the [BlueBuild documentation](https://blue-build.org/learn/getting-started/) to learn on how to customize your image.

We have our own ["documentation"](https://github.com/sernik-tech/member-images/blob/live/sernik/README.md) if you want to refer to them, maintained by us. They serve more as mini-guides rather than full blown documentation though. Also includes what this repository is for and how to participate if you're a Sernik member.

For more information about the project this repository is based on, check out the [Universal Blue homepage](https://universal-blue.org/) and the [BlueBuild homepage](https://blue-build.org/).

You can refer to both the main [BlueBuild GitHub](https://github.com/blue-build/) and [Universal Blue GitHub](https://github.com/ublue-os/) if you want to see what more than be done.
