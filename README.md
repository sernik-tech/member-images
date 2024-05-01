<div align="center">
    <h1>Images</h1>
    <h3>By members of Sernik</h3>
</div>

<div align="center">

[![build](https://github.com/sernik-tech/member-images/actions/workflows/build.yml/badge.svg)](https://github.com/sernik-tech/member-images/actions/workflows/build.yml) [![containers](https://github.com/sernik-tech/member-images/actions/workflows/containers.yml/badge.svg)](https://github.com/sernik-tech/member-images/actions/workflows/containers.yml)

</div>

Custom [Universal Blue](https://universal-blue.org/) Powered Images, built with [BlueBuild](https://blue-build.org/). Built by Sernik members for their own use-cases.

This repository by default supports signing.

###### Repository ran and maintained by [@sneexy-boi](https://github.com/sneexy-boi), owned by [@Rexogamer](https://github.com/Rexogamer).

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

Refer to [BlueBuild's "Installing an image based on Universal Blue"](https://blue-build.org/learn/universal-blue/#fresh-install-from-an-iso) to learn how to generate an ISO with the image you want to use.

If you already use a Universal Blue based image, or have podman installed:
```bash
IMAGE_NAME=<name of image, from https://github.com/orgs/sernik-tech/packages?repo_name=member-images>
IMAGE_VARIANT=Silverblue
# ^ should match the varient of your image (changes the first time/boot medium installer)
sudo podman run --rm --privileged --volume .:/isogenerator/output --security-opt label=disable --pull=newer \
-e IMAGE_REPO="ghcr.io/sernik-tech" -e IMAGE_NAME="$IMAGE_NAME" -e IMAGE_TAG="latest" -e VARIANT="$IMAGE_VARIANT" \
ghcr.io/ublue-os/isogenerator:39
```

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/sernik-tech/$IMAGE_NAME
```

## Extra notes

Refer to the [BlueBuild documentation](https://blue-build.org/learn/getting-started/) to learn on how to customize your image.

For more information about the project this repository is based on, check out the [Universal Blue homepage](https://universal-blue.org/) and the [BlueBuild homepage](https://blue-build.org/).

You can refer to both the main [BlueBuild GitHub](https://github.com/blue-build/) and [Universal Blue GitHub](https://github.com/ublue-os/) if you want to see what more than be done.
