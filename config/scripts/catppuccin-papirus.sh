#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

# Set colors here
FLAVOUR=mocha
ACCENT=green

# Create icon directory
mkdir -p /usr/share/icons

git clone https://github.com/catppuccin/papirus-folders.git /tmp/papirus-folders
cp -r /tmp/papirus-folders/src/* /usr/share/icons/Papirus
chmod +x /tmp/papirus-folders/papirus-folders
/tmp/papirus-folders/papirus-folders -t Papirus-Dark -C cat-$FLAVOUR-$ACCENT

# Latte
./papirus-folders -C cat-latte-rosewater --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /usr/share/icons/Papirus-Catppuccin-Latte-Rosewater
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Rosewater@g' /usr/share/icons/Papirus-Catppuccin-Latte-Rosewater/index.theme

./papirus-folders -C cat-latte-flamingo --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /usr/share/icons/Papirus-Catppuccin-Latte-Flamingo
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Flamingo@g' /usr/share/icons/Papirus-Catppuccin-Latte-Flamingo/index.theme

./papirus-folders -C cat-latte-pink --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /usr/share/icons/Papirus-Catppuccin-Latte-Pink
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Pink@g' /usr/share/icons/Papirus-Catppuccin-Latte-Pink/index.theme

./papirus-folders -C cat-latte-mauve --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /usr/share/icons/Papirus-Catppuccin-Latte-Mauve
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Mauve@g' /usr/share/icons/Papirus-Catppuccin-Latte-Mauve/index.theme

./papirus-folders -C cat-latte-red --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /usr/share/icons/Papirus-Catppuccin-Latte-Red
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Red@g' /usr/share/icons/Papirus-Catppuccin-Latte-Red/index.theme

./papirus-folders -C cat-latte-maroon --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /usr/share/icons/Papirus-Catppuccin-Latte-Maroon
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Maroon@g' /usr/share/icons/Papirus-Catppuccin-Latte-Maroon/index.theme

./papirus-folders -C cat-latte-peach --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /usr/share/icons/Papirus-Catppuccin-Latte-Peach
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Peach@g' /usr/share/icons/Papirus-Catppuccin-Latte-Peach/index.theme

./papirus-folders -C cat-latte-yellow --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /usr/share/icons/Papirus-Catppuccin-Latte-Yellow
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Yellow@g' /usr/share/icons/Papirus-Catppuccin-Latte-Yellow/index.theme

./papirus-folders -C cat-latte-green --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /usr/share/icons/Papirus-Catppuccin-Latte-Green
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Green@g' /usr/share/icons/Papirus-Catppuccin-Latte-Green/index.theme

./papirus-folders -C cat-latte-teal --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /usr/share/icons/Papirus-Catppuccin-Latte-Teal
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Teal@g' /usr/share/icons/Papirus-Catppuccin-Latte-Teal/index.theme

./papirus-folders -C cat-latte-sky --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /usr/share/icons/Papirus-Catppuccin-Latte-Sky
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Sky@g' /usr/share/icons/Papirus-Catppuccin-Latte-Sky/index.theme

./papirus-folders -C cat-latte-sapphire --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /usr/share/icons/Papirus-Catppuccin-Latte-Sapphire
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Sapphire@g' /usr/share/icons/Papirus-Catppuccin-Latte-Sapphire/index.theme

./papirus-folders -C cat-latte-blue --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /usr/share/icons/Papirus-Catppuccin-Latte-Blue
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Blue@g' /usr/share/icons/Papirus-Catppuccin-Latte-Blue/index.theme

./papirus-folders -C cat-latte-lavender --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /usr/share/icons/Papirus-Catppuccin-Latte-Lavender
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Lavender@g' /usr/share/icons/Papirus-Catppuccin-Latte-Lavender/index.theme

# Mocha
./papirus-folders -C cat-mocha-rosewater --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /usr/share/icons/Papirus-Catppuccin-Mocha-Rosewater
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Rosewater@g' /usr/share/icons/Papirus-Catppuccin-Mocha-Rosewater/index.theme

./papirus-folders -C cat-mocha-flamingo --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /usr/share/icons/Papirus-Catppuccin-Mocha-Flamingo
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Flamingo@g' /usr/share/icons/Papirus-Catppuccin-Mocha-Flamingo/index.theme

./papirus-folders -C cat-mocha-pink --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /usr/share/icons/Papirus-Catppuccin-Mocha-Pink
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Pink@g' /usr/share/icons/Papirus-Catppuccin-Mocha-Pink/index.theme

./papirus-folders -C cat-mocha-mauve --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /usr/share/icons/Papirus-Catppuccin-Mocha-Mauve
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Mauve@g' /usr/share/icons/Papirus-Catppuccin-Mocha-Mauve/index.theme

./papirus-folders -C cat-mocha-red --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /usr/share/icons/Papirus-Catppuccin-Mocha-Red
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Red@g' /usr/share/icons/Papirus-Catppuccin-Mocha-Red/index.theme

./papirus-folders -C cat-mocha-maroon --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /usr/share/icons/Papirus-Catppuccin-Mocha-Maroon
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Maroon@g' /usr/share/icons/Papirus-Catppuccin-Mocha-Maroon/index.theme

./papirus-folders -C cat-mocha-peach --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /usr/share/icons/Papirus-Catppuccin-Mocha-Peach
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Peach@g' /usr/share/icons/Papirus-Catppuccin-Mocha-Peach/index.theme

./papirus-folders -C cat-mocha-yellow --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /usr/share/icons/Papirus-Catppuccin-Mocha-Yellow
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Yellow@g' /usr/share/icons/Papirus-Catppuccin-Mocha-Yellow/index.theme

./papirus-folders -C cat-mocha-green --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /usr/share/icons/Papirus-Catppuccin-Mocha-Green
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Green@g' /usr/share/icons/Papirus-Catppuccin-Mocha-Green/index.theme

./papirus-folders -C cat-mocha-teal --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /usr/share/icons/Papirus-Catppuccin-Mocha-Teal
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Teal@g' /usr/share/icons/Papirus-Catppuccin-Mocha-Teal/index.theme

./papirus-folders -C cat-mocha-sky --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /usr/share/icons/Papirus-Catppuccin-Mocha-Sky
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Sky@g' /usr/share/icons/Papirus-Catppuccin-Mocha-Sky/index.theme

./papirus-folders -C cat-mocha-sapphire --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /usr/share/icons/Papirus-Catppuccin-Mocha-Sapphire
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Sapphire@g' /usr/share/icons/Papirus-Catppuccin-Mocha-Sapphire/index.theme

./papirus-folders -C cat-mocha-blue --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /usr/share/icons/Papirus-Catppuccin-Mocha-Blue
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Blue@g' /usr/share/icons/Papirus-Catppuccin-Mocha-Blue/index.theme

./papirus-folders -C cat-mocha-lavender --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /usr/share/icons/Papirus-Catppuccin-Mocha-Lavender
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Lavender@g' /usr/share/icons/Papirus-Catppuccin-Mocha-Lavender/index.theme
