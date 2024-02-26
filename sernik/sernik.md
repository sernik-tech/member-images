# Sernik member's guide to participating

> ![NOTE]
> This readme is sort of an oversimplification of the actual [original documentation from BlueBuild](https://blue-build.org/learn/getting-started/). I'd recommend reading through that *first* and referring to it if you're confused on something here that isn't clear (and also mention to Sneexy about it), as these docs are made to work with the way we have the folder structure set up here.

# Contents

- [How do I access this repository and modify things?](#how-do-i-access-this-repository-and-modify-things)
- [Managing the repository](#managing-the-repository)
- [Making your own custom image](#making-your-own-custom-image)
    - [Folder structure](#folder-structure)
    - [Copying the configuration and modifying it](#copying-the-configuration-and-modifying-it)
    - [Modifying `recipe.yml`](#modifying-recipe.yml)
    - [Customizing the modules](#customizing-the-modules)
    - [Modify the Action](#modify-the-action)
    - [ISO](#iso)
- [Modifying the README](#modifying-the-readme)

## How do I access this repository and modify things?

Ask another Sernik Member who has activity on this repository.

- [@sneexy_boi](https://github.com/Sneexy) is mostly active and can give users permissions to this repository.
- [@Rexogamer](https://github.com/Rexogamer) can make you a part of the sernik-tech organization.

## Managing the repository

> [!IMPORTANT]
> Do <b><i>NOT</i></b> modify the `template` branch. All changes should be done in the `live` branch. Template acts as a branch to stay upstream with BlueBuild that we then PR into `live`.

When making commits, it doesn't really matter how they look or how they're made, but we would prefer if you followed the [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/) specs. Again, not important, It just Makes Things Look Nicer And Clean™️

For example:
- Commits related to your images
    ```
    chore(wuzetka): rep lace rpm-ostree packages with flatpaks
    feat(kutia): add custom repo
    ```
## Making your own custom image

Refer to [BlueBuild's documentation](https://blue-build.org/learn/getting-started/) to learn how to customize your image.

> [!NOTE]
> Currently, their documentation is bare and mostly incomplete. In fact, most of the repository and project is pretty empty right now.

We have example configurations over under [`recipes/silverblue`](https://github.com/sernik-tech/member-images/tree/live/config/recipes/silverblue) and [`recipes/kinoite`](https://github.com/sernik-tech/member-images/tree/live/config/recipes/kinoite) for both Silverblue (GNOME) and Kinoite (KDE Plasma) based images respectfully.

### Folder Structure

For reference, our folder structure is built like this:
```
 config
├──  common
│   └──  <your_preferred_username>
│       ├──  akmods.yml
│       ├──  bling.yml
│       └── <etc. etc.>
├──  files
│   └──  <your_preferred_username>
│       └──  usr
│           └── <default files which you can include in your image>
├──  recipes
│   └──  <your_preferred_username>
│       └──  recipe.yml
└──  scripts
    └── <all scripts you want to include can just be dumped directly into here,
        we recommending using example.sh as a base>
```

- `common` is where you put your modules that you can use to configure your image.
- `files` is where you put any system/configuration related files to be put inside of your image.
- `recipes` is where the file that you use to specify how to create your image goes. Because of the folder structure we have, you probably won't really touch this folder often except for changing the image name and Fedora version.
- `scripts` is where you can dump any scripts you made to be run during the creation of your image. We recommend using `example.sh` as a base.

> [!NOTE]
> If you're planning to make multiple images for yourself, then feel free to use a folder structure like so:
> ```
>  config
> ├──  common
> │   └──  <your preferred username>
> │       ├──  <your image name>
> │       │   ├──  akmods.yml
> │       │   ├──  bling.yml
> │       │   └── <etc.>
> │       └──  <your image name>
> │           ├──  akmods.yml
> │           ├──  bling.yml
> │           └── <etc.>
> ├──  files
> │   └──  <your preferred username>
> │       ├──  <your image name>
> │       │   └──  usr
> │       │       └── <etc>
> │       └──  <your image name>
> │           └──  usr
> │               └── <etc>
> ├──  recipes
> │   └──  <your preferred username>
> │       ├──  recipe-<image name>.yml
> │       └──  recipe-<image name>.yml
> └──  scripts
>     └── <left unchanged here but if you want, you can make a new folder>
> ```

### Copying the configuration and modifying it

Remember, Kinoite is KDE Plasma and Silverblue is GNOME.

Copy all the folders for `kinoite` or `silverblue` inside of `common`, `files` and `recipes` and paste them again under a new folder name. We recommend using your preferred username to avoid confusion with others.

You should now have your own folders in `common`, `files` and `recipes`, similar to the folder structure in the section above.

### Modifying `recipe.yml`

> **BlueBuild Documentation:** [recipe.yml](https://blue-build.org/reference/recipe/)

> [!NOTE]
> For the rest of this, We'll be focusing on the Silverblue example configuration but the Kinoite one should be pretty similar to understand. You can also always refer to the actual [BlueBuild documentation](https://blue-build.org/learn/getting-started/).

To start off, let's modify your `recipe.yml`. This file specifies what is run in what order, what is configured, and which modules should be used. You should be able to locate this in `recipes/<your folder name>/recipe.yml`.

At the top of the file, you should see this:
```yml
# image will be published to ghcr.io/sernik-tech/<name>
name: sernik-silverblue
# description will be included in the image's metadata
description: Sernik's Silverblue Template image
```

Replace `sernik-silverblue` with the name you'd prefer to give to your *image*, and the description can be anything. Can also be left blank with `""` if preferred.

You should see lines like this:
```yml
modules:
  # Put files inside of the image
  - from-file: common/silverblue/files.yml

  # Installs default repositories and rpm-ostree packages
  - from-file: common/silverblue/rpm-ostree.yml

  # Installs default repositories and Flatpak packages
  - from-file: common/silverblue/flatpaks.yml

  <etc.>

  # This sets up the proper policy & signing files for signed images to work fully
  # It's recommended *not* to remove this.
  - type: signing
```

Replace the location of these lines with the proper locations to your folders. For example, `common/silverblue/files.yml` should be pointing to `common/<your folder name>/files.yml`. Leave `type: signing` alone.

### Customizing the modules

> **BlueBuild Documentation:** [akmods](https://blue-build.org/reference/modules/akmods/), [bling](https://blue-build.org/reference/modules/bling/), [default-flatpaks](https://blue-build.org/reference/modules/default-flatpaks/), [files](https://blue-build.org/reference/modules/files/), [fonts](https://blue-build.org/reference/modules/fonts/), [gschema-overrides](https://blue-build.org/reference/modules/gschema-overrides/), [rpm-ostree](https://blue-build.org/reference/modules/rpm-ostree/), [script](https://blue-build.org/reference/modules/script/), [signing](https://blue-build.org/reference/modules/signing/), [systemd](https://blue-build.org/reference/modules/systemd/), [yafti](https://blue-build.org/reference/modules/yafti/)

Head into `common/<your folder name>`. In there, you'll find many modules:

- `akmods.yml` handles [akmods](https://github.com/ublue-os/akmods) which are kernel modules you can install,
- `bling.yml` is extra [scripts and modules](https://github.com/ublue-os/bling) you can install on your image,
- `files.yml` allows files to be copied into `/usr/` on your image,
- `flatpaks.yml` specifies what Flatpaks to be installed,
- `fonts.yml`  specifies what fonts to be installed (from Google Fonts and Nerd Fonts),
- `rpm-ostree.yml` specifies what packages to be installed (with rpm-ostree),
- `script.yml` allows which scripts to be run in image creation,
- `yafti.yml` defines what to be shown in a "[yafti](https://github.com/ublue-os/yafti)" installer.

By default, they are mostly pre-configured to fit the image of the example (e.g. default Flatpaks and rpm-ostree packages for Kinoite and Silverblue are different). Refer to the documentation in the links above, which explain which each module can do and how to be configured.

### Modify the Action

Once you're finished modifying your own image to your own needs, you'll now need to modify the GitHub Action used to build the images.

Open and edit `.github/workflows/build.yml`. You'll find a section like below:
```yml
recipe:
# !! Add your recipes here
    - recipes/sneexy/recipe.yml
    <etc>
```

Add your own image to the list of `recipe`s. It should look like `- recipes/<your folder name>/recipe.yml` (Or, `- recipes/<your folder name>/<recipe name>.yml` if you're doing a multi-image configuration).

Once it's added to the list, save and commit it then push it upstream. GitHub should detect the change and immediately start building the images! If it doesn't, you can just navigate to the [action](https://github.com/sernik-tech/member-images/actions/workflows/build.yml) manually and manually start it by clicking `Run workflow` in the top right and doing it on the `live` branch.

### ISO

If you want to add your image to the ISO, edit the file `boot_menu.yml` located in the root directory and just add 2 lines to the bottom of the file:
```
- label: <image-name-here>
  info: <Description of my image>
```

After you've modified the file, manually run the [release-iso](https://github.com/sernik-tech/member-images/actions/workflows/release-iso.yml) action, preferably after the `build-ublue` action has finished.

### Modifying the README

If you want to add any extra info to the README's or anything, such as this documentation, feel free to do so!

<i>If</i> you want to add your own image to the list on the main README, feel free to do so as well. You don't have to follow a format or anything, just a description is fine.
