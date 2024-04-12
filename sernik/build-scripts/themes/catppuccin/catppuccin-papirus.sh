#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

dnf install -y wget sed

# dirs
mkdir -p /tmp/papirus-catppuccin/usr/share/icons

cd /tmp
dnf install -y papirus-icon-theme

# grab catppuccin theme then manually create all different colored icons and install them
git clone https://github.com/catppuccin/papirus-folders.git
cd papirus-folders
cp -r src/* /usr/share/icons/Papirus
chmod +x papirus-folders

# Latte
./papirus-folders -C cat-latte-rosewater --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Rosewater
sed -i 's@Name=Papirus-Light@Name=Papirus-Latte-Rosewater@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Rosewater/index.theme

./papirus-folders -C cat-latte-flamingo --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Flamingo
sed -i 's@Name=Papirus-Light@Name=Papirus-Latte-Flamingo@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Flamingo/index.theme

./papirus-folders -C cat-latte-pink --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Pink
sed -i 's@Name=Papirus-Light@Name=Papirus-Latte-Pink@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Pink/index.theme

./papirus-folders -C cat-latte-mauve --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Mauve
sed -i 's@Name=Papirus-Light@Name=Papirus-Latte-Mauve@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Mauve/index.theme

./papirus-folders -C cat-latte-red --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Red
sed -i 's@Name=Papirus-Light@Name=Papirus-Latte-Red@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Red/index.theme

./papirus-folders -C cat-latte-maroon --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Maroon
sed -i 's@Name=Papirus-Light@Name=Papirus-Latte-Maroon@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Maroon/index.theme

./papirus-folders -C cat-latte-peach --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Peach
sed -i 's@Name=Papirus-Light@Name=Papirus-Latte-Peach@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Peach/index.theme

./papirus-folders -C cat-latte-yellow --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Yellow
sed -i 's@Name=Papirus-Light@Name=Papirus-Latte-Yellow@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Yellow/index.theme

./papirus-folders -C cat-latte-green --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Green
sed -i 's@Name=Papirus-Light@Name=Papirus-Latte-Green@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Green/index.theme

./papirus-folders -C cat-latte-teal --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Teal
sed -i 's@Name=Papirus-Light@Name=Papirus-Latte-Teal@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Teal/index.theme

./papirus-folders -C cat-latte-sky --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Sky
sed -i 's@Name=Papirus-Light@Name=Papirus-Latte-Sky@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Sky/index.theme

./papirus-folders -C cat-latte-sapphire --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Sapphire
sed -i 's@Name=Papirus-Light@Name=Papirus-Latte-Sapphire@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Sapphire/index.theme

./papirus-folders -C cat-latte-blue --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Blue
sed -i 's@Name=Papirus-Light@Name=Papirus-Latte-Blue@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Blue/index.theme

./papirus-folders -C cat-latte-lavender --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Lavender
sed -i 's@Name=Papirus-Light@Name=Papirus-Latte-Lavender@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Latte-Lavender/index.theme
# Frappe
./papirus-folders -C cat-frappe-rosewater --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Rosewater
sed -i 's@Name=Papirus-Dark@Name=Papirus-Frappe-Rosewater@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Rosewater/index.theme

./papirus-folders -C cat-frappe-flamingo --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Flamingo
sed -i 's@Name=Papirus-Dark@Name=Papirus-Frappe-Flamingo@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Flamingo/index.theme

./papirus-folders -C cat-frappe-pink --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Pink
sed -i 's@Name=Papirus-Dark@Name=Papirus-Frappe-Pink@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Pink/index.theme

./papirus-folders -C cat-frappe-mauve --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Mauve
sed -i 's@Name=Papirus-Dark@Name=Papirus-Frappe-Mauve@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Mauve/index.theme

./papirus-folders -C cat-frappe-red --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Red
sed -i 's@Name=Papirus-Dark@Name=Papirus-Frappe-Red@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Red/index.theme

./papirus-folders -C cat-frappe-maroon --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Maroon
sed -i 's@Name=Papirus-Dark@Name=Papirus-Frappe-Maroon@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Maroon/index.theme

./papirus-folders -C cat-frappe-peach --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Peach
sed -i 's@Name=Papirus-Dark@Name=Papirus-Frappe-Peach@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Peach/index.theme

./papirus-folders -C cat-frappe-yellow --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Yellow
sed -i 's@Name=Papirus-Dark@Name=Papirus-Frappe-Yellow@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Yellow/index.theme

./papirus-folders -C cat-frappe-green --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Green
sed -i 's@Name=Papirus-Dark@Name=Papirus-Frappe-Green@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Green/index.theme

./papirus-folders -C cat-frappe-teal --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Teal
sed -i 's@Name=Papirus-Dark@Name=Papirus-Frappe-Teal@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Teal/index.theme

./papirus-folders -C cat-frappe-sky --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Sky
sed -i 's@Name=Papirus-Dark@Name=Papirus-Frappe-Sky@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Sky/index.theme

./papirus-folders -C cat-frappe-sapphire --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Sapphire
sed -i 's@Name=Papirus-Dark@Name=Papirus-Frappe-Sapphire@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Sapphire/index.theme

./papirus-folders -C cat-frappe-blue --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Blue
sed -i 's@Name=Papirus-Dark@Name=Papirus-Frappe-Blue@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Blue/index.theme

./papirus-folders -C cat-frappe-lavender --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Lavender
sed -i 's@Name=Papirus-Dark@Name=Papirus-Frappe-Lavender@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Frappe-Lavender/index.theme
# Macchiato
./papirus-folders -C cat-macchiato-rosewater --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Rosewater
sed -i 's@Name=Papirus-Dark@Name=Papirus-Macchiato-Rosewater@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Rosewater/index.theme

./papirus-folders -C cat-macchiato-flamingo --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Flamingo
sed -i 's@Name=Papirus-Dark@Name=Papirus-Macchiato-Flamingo@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Flamingo/index.theme

./papirus-folders -C cat-macchiato-pink --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Pink
sed -i 's@Name=Papirus-Dark@Name=Papirus-Macchiato-Pink@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Pink/index.theme

./papirus-folders -C cat-macchiato-mauve --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Mauve
sed -i 's@Name=Papirus-Dark@Name=Papirus-Macchiato-Mauve@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Mauve/index.theme

./papirus-folders -C cat-macchiato-red --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Red
sed -i 's@Name=Papirus-Dark@Name=Papirus-Macchiato-Red@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Red/index.theme

./papirus-folders -C cat-macchiato-maroon --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Maroon
sed -i 's@Name=Papirus-Dark@Name=Papirus-Macchiato-Maroon@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Maroon/index.theme

./papirus-folders -C cat-macchiato-peach --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Peach
sed -i 's@Name=Papirus-Dark@Name=Papirus-Macchiato-Peach@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Peach/index.theme

./papirus-folders -C cat-macchiato-yellow --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Yellow
sed -i 's@Name=Papirus-Dark@Name=Papirus-Macchiato-Yellow@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Yellow/index.theme

./papirus-folders -C cat-macchiato-green --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Green
sed -i 's@Name=Papirus-Dark@Name=Papirus-Macchiato-Green@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Green/index.theme

./papirus-folders -C cat-macchiato-teal --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Teal
sed -i 's@Name=Papirus-Dark@Name=Papirus-Macchiato-Teal@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Teal/index.theme

./papirus-folders -C cat-macchiato-sky --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Sky
sed -i 's@Name=Papirus-Dark@Name=Papirus-Macchiato-Sky@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Sky/index.theme

./papirus-folders -C cat-macchiato-sapphire --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Sapphire
sed -i 's@Name=Papirus-Dark@Name=Papirus-Macchiato-Sapphire@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Sapphire/index.theme

./papirus-folders -C cat-macchiato-blue --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Blue
sed -i 's@Name=Papirus-Dark@Name=Papirus-Macchiato-Blue@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Blue/index.theme

./papirus-folders -C cat-macchiato-lavender --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Lavender
sed -i 's@Name=Papirus-Dark@Name=Papirus-Macchiato-Lavender@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Macchiato-Lavender/index.theme
# Mocha
./papirus-folders -C cat-mocha-rosewater --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Rosewater
sed -i 's@Name=Papirus-Dark@Name=Papirus-Mocha-Rosewater@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Rosewater/index.theme

./papirus-folders -C cat-mocha-flamingo --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Flamingo
sed -i 's@Name=Papirus-Dark@Name=Papirus-Mocha-Flamingo@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Flamingo/index.theme

./papirus-folders -C cat-mocha-pink --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Pink
sed -i 's@Name=Papirus-Dark@Name=Papirus-Mocha-Pink@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Pink/index.theme

./papirus-folders -C cat-mocha-mauve --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Mauve
sed -i 's@Name=Papirus-Dark@Name=Papirus-Mocha-Mauve@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Mauve/index.theme

./papirus-folders -C cat-mocha-red --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Red
sed -i 's@Name=Papirus-Dark@Name=Papirus-Mocha-Red@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Red/index.theme

./papirus-folders -C cat-mocha-maroon --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Maroon
sed -i 's@Name=Papirus-Dark@Name=Papirus-Mocha-Maroon@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Maroon/index.theme

./papirus-folders -C cat-mocha-peach --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Peach
sed -i 's@Name=Papirus-Dark@Name=Papirus-Mocha-Peach@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Peach/index.theme

./papirus-folders -C cat-mocha-yellow --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Yellow
sed -i 's@Name=Papirus-Dark@Name=Papirus-Mocha-Yellow@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Yellow/index.theme

./papirus-folders -C cat-mocha-green --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Green
sed -i 's@Name=Papirus-Dark@Name=Papirus-Mocha-Green@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Green/index.theme

./papirus-folders -C cat-mocha-teal --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Teal
sed -i 's@Name=Papirus-Dark@Name=Papirus-Mocha-Teal@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Teal/index.theme

./papirus-folders -C cat-mocha-sky --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Sky
sed -i 's@Name=Papirus-Dark@Name=Papirus-Mocha-Sky@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Sky/index.theme

./papirus-folders -C cat-mocha-sapphire --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Sapphire
sed -i 's@Name=Papirus-Dark@Name=Papirus-Mocha-Sapphire@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Sapphire/index.theme

./papirus-folders -C cat-mocha-blue --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Blue
sed -i 's@Name=Papirus-Dark@Name=Papirus-Mocha-Blue@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Blue/index.theme

./papirus-folders -C cat-mocha-lavender --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Lavender
sed -i 's@Name=Papirus-Dark@Name=Papirus-Mocha-Lavender@g' /tmp/papirus-catppuccin/usr/share/icons/Papirus-Mocha-Lavender/index.theme
