#!/bin/bash
set -e

echo ""
echo "### installing mopidy ###"
echo ""

sudo pacman -S mopidy
trizen -S --noedit --noconfig mopidy-spotify
trizen -S --noedit --noconfig mopidy-iris
trizen -S --noedit --noconfig mopidy-local-sqlite
sudo pip2 uninstall tornado
sudo pip2 install tornado==4.5.3 


mkdir -p ~/.config/mopidy
cp dots/.config/mopidy/mopidy.conf ~/.config/mopidy

echo "### mopidy configured ###"

echo "setting up systemd --user mopidy service."
systemctl --user enable mopidy
systemctl --user start mopidy
echo "### mopidy setup complete ###"

echo "### installing mopidysonglisten service ###"

systemctl --user enable mopidysonglisten
systemctl --user start mopidysonglisten

echo "### mopidysonglisten installed ###"

echo "run mopidy local scan in order to scan music library"