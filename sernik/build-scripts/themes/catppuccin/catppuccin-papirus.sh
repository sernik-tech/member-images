#!/usr/bin/env bash

# Tell build process to exit if there are any errors.
set -euo pipefail

dnf install -y git wget sed papirus-icon-theme

# dirs
mkdir -p /tmp/catppuccin-papirus/usr/share/icons

cd /tmp

# grab catppuccin theme then manually create all different colored icons and install them
git clone https://github.com/catppuccin/papirus-folders.git
cd papirus-folders
cp -r src/* /usr/share/icons/Papirus
chmod +x papirus-folders

# Latte
./papirus-folders -C cat-latte-rosewater --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Rosewater
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Rosewater@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Rosewater/index.theme

./papirus-folders -C cat-latte-flamingo --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Flamingo
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Flamingo@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Flamingo/index.theme

./papirus-folders -C cat-latte-pink --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Pink
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Pink@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Pink/index.theme

./papirus-folders -C cat-latte-mauve --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Mauve
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Mauve@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Mauve/index.theme

./papirus-folders -C cat-latte-red --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Red
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Red@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Red/index.theme

./papirus-folders -C cat-latte-maroon --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Maroon
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Maroon@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Maroon/index.theme

./papirus-folders -C cat-latte-peach --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Peach
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Peach@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Peach/index.theme

./papirus-folders -C cat-latte-yellow --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Yellow
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Yellow@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Yellow/index.theme

./papirus-folders -C cat-latte-green --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Green
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Green@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Green/index.theme

./papirus-folders -C cat-latte-teal --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Teal
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Teal@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Teal/index.theme

./papirus-folders -C cat-latte-sky --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Sky
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Sky@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Sky/index.theme

./papirus-folders -C cat-latte-sapphire --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Sapphire
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Sapphire@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Sapphire/index.theme

./papirus-folders -C cat-latte-blue --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Blue
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Blue@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Blue/index.theme

./papirus-folders -C cat-latte-lavender --theme Papirus-Light
cp -r /usr/share/icons/Papirus-Light /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Lavender
sed -i 's@Name=Papirus-Light@Name=Papirus-Catppuccin-Latte-Lavender@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Latte-Lavender/index.theme
# Frappe
./papirus-folders -C cat-frappe-rosewater --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Rosewater
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Frappe-Rosewater@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Rosewater/index.theme

./papirus-folders -C cat-frappe-flamingo --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Flamingo
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Frappe-Flamingo@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Flamingo/index.theme

./papirus-folders -C cat-frappe-pink --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Pink
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Frappe-Pink@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Pink/index.theme

./papirus-folders -C cat-frappe-mauve --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Mauve
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Frappe-Mauve@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Mauve/index.theme

./papirus-folders -C cat-frappe-red --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Red
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Frappe-Red@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Red/index.theme

./papirus-folders -C cat-frappe-maroon --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Maroon
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Frappe-Maroon@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Maroon/index.theme

./papirus-folders -C cat-frappe-peach --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Peach
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Frappe-Peach@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Peach/index.theme

./papirus-folders -C cat-frappe-yellow --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Yellow
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Frappe-Yellow@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Yellow/index.theme

./papirus-folders -C cat-frappe-green --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Green
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Frappe-Green@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Green/index.theme

./papirus-folders -C cat-frappe-teal --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Teal
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Frappe-Teal@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Teal/index.theme

./papirus-folders -C cat-frappe-sky --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Sky
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Frappe-Sky@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Sky/index.theme

./papirus-folders -C cat-frappe-sapphire --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Sapphire
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Frappe-Sapphire@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Sapphire/index.theme

./papirus-folders -C cat-frappe-blue --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Blue
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Frappe-Blue@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Blue/index.theme

./papirus-folders -C cat-frappe-lavender --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Lavender
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Frappe-Lavender@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Frappe-Lavender/index.theme
# Macchiato
./papirus-folders -C cat-macchiato-rosewater --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Rosewater
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Macchiato-Rosewater@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Rosewater/index.theme

./papirus-folders -C cat-macchiato-flamingo --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Flamingo
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Macchiato-Flamingo@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Flamingo/index.theme

./papirus-folders -C cat-macchiato-pink --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Pink
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Macchiato-Pink@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Pink/index.theme

./papirus-folders -C cat-macchiato-mauve --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Mauve
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Macchiato-Mauve@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Mauve/index.theme

./papirus-folders -C cat-macchiato-red --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Red
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Macchiato-Red@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Red/index.theme

./papirus-folders -C cat-macchiato-maroon --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Maroon
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Macchiato-Maroon@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Maroon/index.theme

./papirus-folders -C cat-macchiato-peach --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Peach
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Macchiato-Peach@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Peach/index.theme

./papirus-folders -C cat-macchiato-yellow --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Yellow
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Macchiato-Yellow@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Yellow/index.theme

./papirus-folders -C cat-macchiato-green --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Green
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Macchiato-Green@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Green/index.theme

./papirus-folders -C cat-macchiato-teal --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Teal
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Macchiato-Teal@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Teal/index.theme

./papirus-folders -C cat-macchiato-sky --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Sky
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Macchiato-Sky@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Sky/index.theme

./papirus-folders -C cat-macchiato-sapphire --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Sapphire
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Macchiato-Sapphire@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Sapphire/index.theme

./papirus-folders -C cat-macchiato-blue --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Blue
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Macchiato-Blue@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Blue/index.theme

./papirus-folders -C cat-macchiato-lavender --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Lavender
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Macchiato-Lavender@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Macchiato-Lavender/index.theme
# Mocha
./papirus-folders -C cat-mocha-rosewater --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Rosewater
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Rosewater@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Rosewater/index.theme

./papirus-folders -C cat-mocha-flamingo --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Flamingo
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Flamingo@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Flamingo/index.theme

./papirus-folders -C cat-mocha-pink --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Pink
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Pink@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Pink/index.theme

./papirus-folders -C cat-mocha-mauve --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Mauve
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Mauve@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Mauve/index.theme

./papirus-folders -C cat-mocha-red --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Red
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Red@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Red/index.theme

./papirus-folders -C cat-mocha-maroon --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Maroon
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Maroon@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Maroon/index.theme

./papirus-folders -C cat-mocha-peach --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Peach
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Peach@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Peach/index.theme

./papirus-folders -C cat-mocha-yellow --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Yellow
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Yellow@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Yellow/index.theme

./papirus-folders -C cat-mocha-green --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Green
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Green@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Green/index.theme

./papirus-folders -C cat-mocha-teal --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Teal
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Teal@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Teal/index.theme

./papirus-folders -C cat-mocha-sky --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Sky
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Sky@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Sky/index.theme

./papirus-folders -C cat-mocha-sapphire --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Sapphire
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Sapphire@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Sapphire/index.theme

./papirus-folders -C cat-mocha-blue --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Blue
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Blue@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Blue/index.theme

./papirus-folders -C cat-mocha-lavender --theme Papirus-Dark
cp -r /usr/share/icons/Papirus-Dark /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Lavender
sed -i 's@Name=Papirus-Dark@Name=Papirus-Catppuccin-Mocha-Lavender@g' /tmp/catppuccin-papirus/usr/share/icons/Papirus-Catppuccin-Mocha-Lavender/index.theme
