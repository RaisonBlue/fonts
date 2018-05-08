#!/bin/sh

# Set source and target directories
install_dir="$( cd "$( dirname "$0" )" && pwd )"

# if an argument is given it is used to select which fonts to uninstall
prefix="$1"

  font_dir="/usr/share/fonts"
  if test ! -d "$font_dir" ; then
    echo "It seems there are no powerline fonts installed on your system. Uninstall not needed."
    exit 0
  fi

# Remove all fonts from user fonts directory
echo "Removing fonts..."
find "$install_dir" \( -name "$prefix*.ttf" \) -type f -print0 | xargs -n1 -0 -I % sh -c "sudo rm -f \"\$0/\${1##*/}\"" "$font_dir/TTF/" %
find "$install_dir" \( -name "$prefix*.otf" \) -type f -print0 | xargs -n1 -0 -I % sh -c "sudo rm -f \"\$0/\${1##*/}\"" "$font_dir/OTF/" %

# Reset font cache
if which fc-cache >/dev/null 2>&1 ; then
    echo "Resetting font cache, this may take a moment..."
    fc-cache -f "$font_dir"
fi

echo "Powerline fonts uninstalled from $font_dir"
