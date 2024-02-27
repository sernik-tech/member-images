# So-called "Documentation"

Some documentation for our Sernik Members. Sorta like mini-guides, if you will.

**If you're looking for how to participate and make your own custom image as a Sernik member, refer to the [`examples`](https://github.com/sernik-tech/member-images/tree/examples) branch, which contains templates and documentation about how it all works.**

If you're looking for actual documentation related to anything about Universal Blue, Fedora, Immutable desktops, etc. Refer to the following instead:

- [BlueBuild](https://blue-build.org/)'s homepage
    - [GitHub](https://github.com/blue-build/)
- [Universal Blue](https://universal-blue.org/)'s homepage
    - [FAQ](https://universal-blue.org/faq/)
    - [Introduction](https://universal-blue.org/introduction/)
- [Fedora Kinoite](https://fedoraproject.org/kinoite/)'s homepage
    - [Kinoite Community](https://fedoraproject.org/kinoite/community/)
    - [Fedora Kinoite User Guide](https://docs.fedoraproject.org/en-US/fedora-kinoite/)
- [Fedora Silverblue](https://fedoraproject.org/silverblue/)'s homepage
    - [Silverblue Community](https://fedoraproject.org/silverblue/community/)
    - [Fedora Silverblue User Guide](https://docs.fedoraproject.org/en-US/fedora-silverblue/)
- [Distrobox](https://distrobox.it/)

## Contents

- [Tips](#tips)
    - [Distrobox](#setting-up-distrobox)
        - [Ubuntu (with VSCodium)](#ubuntu-with-vscodium)
        - [Fedora (with some CLI tools)](#fedora-with-some-cli-tools)
        - [Installing Steam and Lutris](#installing-steam-and-lutris)
        - [Installing OBS Studio](#installing-obs-studio-another-way)
    - [ThinkPad T480 Fingerprint Setup](#thinkpad-t480-fingerprint-setup)
- [Extra known resources](#extra-known-resources)

## Tips

## Distrobox

[Distrobox](https://distrobox.it/) is a utility that provides containers with near-perfect integration with your host system that lets you install different packages and utilities from different Linux distros on your host. It serves as a great way to install packages when you don't want to layer too many packages with `rpm-ostree` on your system or need a development box can be made temporarily and quickly thrown away when no longer needed, along with many other use cases.

I recommend checking out [their documentation](https://distrobox.it/usage/usage/) (and extra [useful tips](https://distrobox.it/useful_tips/)) as they do give great documentation and examples on how to use Distrobox. Here are just some simple examples that can familiarize yourself with the basics of what you'd most likely do with Distrobox.

If you prefer, you can use a terminal dedicated for containers/Distroboxes such as [Boxi](https://boxi.dev/) or [ptyxis](https://gitlab.gnome.org/chergert/ptyxis).


### Ubuntu (with VSCodium and ADB)

We'll set up an Ubuntu container here along with installing [VSCodium](https://vscodium.com/) and ADB, then exporting them to show up natively in your host without much effort.

> ![NOTE]
> The commands below uses uBlue's special customized toolbox images which have been heavily optimized specifically for Distrobox usage. For the Ubuntu image, it's based on the latest available version of Ubuntu LTS. If you don't want this, just specifies `ubuntu` instead of `ubuntu-toolbox` for the image.

Now, let's make the container:
```bash
distrobox create -i ubuntu-toolbox -n ubuntu # alternatively, replace the value after `-n` to give the container a different name, for example, `devbox`
distrobox enter ubuntu # name of your container, this will take a while for the first time to initialize everything
```

Once you're inside of the container, We'll install ADB, try it, then export it:
```bash
sudo apt install adb
# plug in your android device, of course
adb devices # this should work! and your device should be asking if your computer should get developer access
distrobox-export --bin /usr/bin/adb # export adb to work in your host CLI without being inside of the container.

# note that `--bin` HAS to point to the absolute location of where the software is installed in, but most of the
# time, it'll usually (if not always) be in `/usr/bin/<executable name, the one used when launching from CLI>`
```

Now we'll just follow the VSCodium installation instructions as normally for Ubuntu/Debian installation:
```bash
# taken directly from https://vscodium.com/#install-on-debian-ubuntu-deb-package
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list

sudo apt update && sudo apt install codium
```

Once VSCodium is installed, we can try launching it and then exporting it:
```bash
# of course, assuming we're still inside of the Ubuntu container
codium # this should work and open vscodium! congrats
distrobox-export --app codium # exports the desktop entry for vscodium, allowing you to launch it from your application launcher natively
```

### Fedora (with some CLI applications)

With Fedora, we'll install some command line based tools and export them to our host.

First, create the container:
```bash
distrobox create -i fedora-toolbox -n fedora # again, replace the value after `-n` with anything you'd like as a container name
distrobox enter fedora
```

Now we install some of said tools:
```bash
sudo dnf install dnf-plugins-core btop tldr yt-dlp cava
sudo dnf copr enable zeno/scrcpy # optional bit, but we're throwing in scrcpy as well just to show that it works
sudo dnf install scrcpy
```

Of course, if you want, you can run them to see that they work! Even `btop`, which also shows all processes on your host system! So now, we're going to export all of them:
```bash
distrobox-export --bin /usr/bin/btop
distrobox-export --bin /usr/bin/cava
distrobox-export --bin /usr/bin/tldr
distrobox-export --bin /usr/bin/yt-dlp
distrobox-export --bin /usr/bin/scrcpy # optional, if you installed scrcpy
distrobox-export --app scrcpy # also exporting as an app since it does come with a desktop entry
```

### Installing Steam and Lutris

> [!NOTE]
> One may not prefer to install Steam in a container, and that's fine, the [Flatpak](https://flathub.org/apps/com.valvesoftware.Steam) option is still a route for this.

For this one, we're going to use [`bazzite-arch`](https://github.com/ublue-os/bazzite-arch), which is a special Arch Linux based container image with a bunch of gaming applications and utilities installed.

We'll just quickly get the container all set up:
```bash
distrobox create --unshare-netns --nvidia --image ghcr.io/ublue-os/bazzite-arch --name bazzite-arch -Y
distrobox enter bazzite-arch
```

> [!NOTE]
> If you image uses GNOME instead of KDE Plasma, replace the URL `ghcr.io/ublue-os/bazzite-arch` in the command above with `ghcr.io/ublue-os/bazzite-arch-gnome` which has extra packages to properly work with GNOME.

And since it already comes with everything out of the box, we're just going to export the applications:
```bash
distrobox-export --app steam
distrobox-export --app lutris
distrobox-export --app protontricks
mkdir -p ~/.steam && distrobox-export --bin /usr/bin/steamcmd --export-path ~/.steam && mv ~/.steam/steamcmd ~/.steam/steamcmd.sh
```

### Installing OBS Studio

Yep. There's a container for OBS Studio over at [`obs-studio-portable`](https://github.com/ublue-os/obs-studio-portable).

> [!NOTE]
> This container comes with OBS Studio and a *lot* of plugins. Although it's curated and not made to just be a giant mess, if you don't prefer this, there's always the [Flatpak](https://flathub.org/apps/com.obsproject.Studio). There's also [GPU Screen Recorder](https://flathub.org/apps/com.dec05eba.gpu_screen_recorder) if you're looking for something light.

> [!WARNING]
> `bazzite-arch` already comes with OBS Studio, although it's not as customized as this specialized container. Depending on your wants or needs, `bazzite-arch`'s OBS may be good enough for you.

Pull:
```bash
distrobox create --image ghcr.io/ublue-os/obs-studio-portable:latest --name obs --pull
distrobox enter obs
```

Then export:
```bash
distrobox-export --app /opt/obs-portable/obs-portable

# below command only works if you aren't inside of the container
distrobox enter --name obs -- /opt/obs-portable/obs-portable # use this to execute obs studio manually if there are any issues
```

## ThinkPad T480 Fingerprint Setup

Short guide taken and modified from [borcean's gist](https://gist.github.com/borcean/f32c47f6cc52cee33dfc2265ce63f777), using my own Copr repository updated to work with Immutable flavors.

Installing the Copr repository and `python3-validity`:
```bash
# downloads the copr repo
cd /etc/yum.repos.d/
sudo wget https://copr.fedorainfracloud.org/coprs/sneexy/python-validity/repo/fedora-$(rpm -E %fedora)/sneexy-python-validity-fedora-$(rpm -E %fedora).repo
# override and install fprintd packages
rpm-ostree override remove fprintd fprintd-pam --install open-fprintd --install fprintd-clients --install fprintd-clients-pam --install python3-validity
```

Configuring the fingerprint reader:
```bash
# pre-prep fingerprint reader
sudo validity-sensors-firmware
sudo python3 /usr/share/python-validity/playground/factory-reset.py
# enabling and starting services
sudo systemctl enable python3-validity open-fprintd-resume open-fprintd-suspend
sudo systemctl start python3-validity
```

Enroll and test your reader:
```bash
fprintd-enroll
fprintd-verify
```

Enabling fingerprint authentication:
```bash
# configures current authentication methods to use fingerprint and apply
sudo authselect current
sudo authselect enable-feature with-fingerprint
sudo authselect apply-changes
```

## Extra known resources

- [boxkit](https://github.com/ublue-os/boxkit) (Make your own custom distrobox container images)
    - [ubuntu-toolbox](https://github.com/ublue-os/toolboxes/tree/main/toolboxes/ubuntu-toolbox) (Default choice for the Ubuntu distrobox)
    - [fedora-toolbox](https://github.com/ublue-os/toolboxes/tree/main/toolboxes/fedora-toolbox) (Default choice for the Fedora distrobox)
    - [bazzite-arch](https://github.com/ublue-os/bazzite-arch) (Arch based distrobox container ready for gaming)
    - [obs-studio-portable](https://github.com/ublue-os/obs-studio-portable) (Ubuntu distrobox with OBS studio preinstalled with extra plugins)
    - [davincibox](https://github.com/zelikos/davincibox) (Container with everything set up for running DaVinci Resolve)
- [Bazzite](https://github.com/ublue-os/bazzite) (uBlue's container based gaming distro)
    - [`bazzite` Copr repository](https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite/)
    - [`bazzite-multilib` Copr repository](https://copr.fedorainfracloud.org/coprs/kylegospo/bazzite-multilib/)
- [`python-validity` Copr repository](https://copr.fedorainfracloud.org/coprs/sneexy/python-validity/) (Fingerprint reader drivers for some devices)
