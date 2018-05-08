#!/bin/sh

install_dir="$( cd "$( dirname "$0" )" && pwd )"

# if an argument is given it is used to select which fonts to install
prefix="$1"
font_dir="/usr/share/fonts/"

# Copy all fonts to global fonts directory
echo "Copying fonts..."
find "$install_dir" \( -name "$prefix*.ttf" \) -type f -print0 | xargs -0 -n1 -I % sudo cp "%" "$font_dir/TTF/"
find "$install_dir" \( -name "$prefix*.otf" \) -type f -print0 | xargs -0 -n1 -I % sudo cp "%" "$font_dir/OTF/"

# Reset font cache
if which fc-cache >/dev/null 2>&1 ; then
    echo "Resetting font cache, this may take a moment..."
    fc-cache -f "$font_dir"
fi

echo "Powerline fonts installed to $font_dir"
