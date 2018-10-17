# arch-install

Info on installing and ricing arch linux + dot files backup

Baseline: arch-linux-base-devel + openbox + lightdm + rxvt-unicode + vim + git + ntfs-3g + nvidia

`git clone https://github.com/akindofcode/arch-install.git`

### sudo with no password

sudo visudo. Make wheel group can perform sudo without asking password. Example in /etc/sudoers.

	%wheel ALL=(ALL) NOPASSWD: ALL

### remove fsck

remove fsck from HOOKS=(...) in /etc/mkinitpcio.conf

`sudo mkinitcpio -p linux`

### ignore package update

sudo vim /etc/pacman.conf

add:

`IgnorePkg = sublime-text`

### Locale and keymap

uncomment line "en_GB.UTF-8" from /etc/locale.gen

	sudo locale-gen
	sudo echo LANG=en_GB.UTF-8 > /etc/locale.conf
	sudo localectl set-keymap es
	sudo localetcl set-x11-keymap es

### fix locale

`export LC_CTYPE=$LANG`

### nvidia

Fix screen tearing: in nvidia-settings 'Force Coposition Pipeline' (server display configuration - advanced)

<http://www.thelinuxrain.com/articles/got-tearing-with-proprietary-nvidia-try-this>

Disable second screen and save

### xrandr

#first screen only

`xrandr --output DVI-I-1 --auto --output DVI-D-0 --off`

#second screen only

`xrandr --output DVI-I-1 --off --output DVI-D-0 --auto`

#extend

`xrandr --output DVI-I-1 --auto --primary --output DVI-D-0 --auto --left-of`

#mirror

`xrandr --output DVI-I-1 --auto --output DVI-D-0 --auto --same-as DVI-I-1`

### openbox theming

Openbox wiki: http://openbox.org/wiki/Help:Contents#Configuration

Window border width:

Let's say you use the waldorf theme with openbox. You go to /usr/share/themes/waldorf/openbox-3/themerc and search the line

	border.Width: 1

### wallpaper

`nitrogen ~/wallpapers`

convert to jpg

`mogrify -format jpg *.png`

### pipelines, toys...

/.bin

You can set your environment for Openbox in the ~/.config/openbox/environment

Just add

	PATH="$HOME/.bin:$PATH"; export PATH

### Fonts

Place windows fonts in /fonts/WindowsFonts before running script 005. Check vivaldi fonts.

New fonts can be installed to /.local/share/fonts or /usr/share/fonts

`fc-cache -fv`

### GRUB

<https://wiki.archlinux.org/index.php/GRUB/Tips_and_tricks>

### Silent Boot

GRUB -> e -> quiet vga=current vt.global_cursor_default=0 udev.log_priority=3

add to /etc/default/grub:

	GRUB_CMDLINE_LINUX_DEFAULT="nvidia-drm.modeset=1 quiet vga=current vt.global_cursor_default=0 udev.log_priority=3"

regenerate grub.cfg file:

`sudo grub-mkconfig -o /boot/grub/grub.cfg`

### Hide Grub

`packer -S --noedit grub-silent`

- Reinstall GRUB first:
  
`sudo grub-install --target=i386-pc /dev/sdf`
 
- Then; look at "/etc/default/grub.silent" sample file
  and make necessary changes to "/etc/default/grub".
 
	GRUB_DEFAULT=0
	GRUB_TIMEOUT=0
	GRUB_RECORDFAIL_TIMEOUT=$GRUB_TIMEOUT
	GRUB_CMDLINE_LINUX_DEFAULT="nvidia-drm.modeset=1 quiet loglevel=3 vga=current rd.systemd.show_status=false vt.global_cursor_default=0 udev.log_priority=3"

Hide GRUB unless the Shift key is held down copy file /etc/grub.d/31_hold_shift

	GRUB_FORCE_HIDDEN_MENU="true"

- Finally, regenerate grub.cfg file:

`# grub-mkconfig -o /boot/grub/grub.cfg`

Make GRUB remeber last chosen option:

	GRUB_DEFAULT=saved
	GRUB_SAVEDEFAULT=true

### autologin without login manager

`cp /etc/X11/xinit/xinitrc ~/.xinitrc`

`~/.xinitrc`

`exec openbox-session`

For Bash, add the following to the bottom of ~/.bash_profile. If the file does not exist, copy a skeleton version from /etc/skel/.bash_profile. 

For Zsh, add it to ~/.zprofile.

	if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	  exec startx
	fi

`touch ~/.hushlogin`

/etc/systemd/system/getty@tty1.service.d/override.conf

	[Service]
	Type=simple	
	ExecStart=
	ExecStart=-/usr/bin/agetty --noissue --skip-login --login-options "-f chema" %I 38400 linux

Disable lightdm login manager

`sudo systemctl disable display-manager.service`

`sudo pacman -Rd lightdm lightdm-gtk-greeter`


### Maintenance

`du /var/cache/pacman/pkg -sh`

Recommended way to clean package cache in arch linux

<https://www.ostechnix.com/recommended-way-clean-package-cache-arch-linux/>

`sudo ls /var/cache/pacman/pkg/ | wc -l`

`du -sh /var/cache/pacman/pkg/`

Keep only one most recent version:

`sudo paccache -rk 1`

To remove all cached versions of uninstalled packages:

`sudo paccache -ruk0`

### Music

Beets configured

play [query] to create playlist and play
W-c  -> cava
W-l  -> show lyrics to current song

Plugins: 

copyartifacts

<https://github.com/sbarakat/beets-copyartifacts#development>

if copyartifacts doesn't work replace /usr/lib/python3.6/site-packages/beetsplug/copyartifacts.py
with <https://raw.githubusercontent.com/sbarakat/beets-copyartifacts/master/beetsplug/copyartifacts.py>

fetchart

<http://beets.readthedocs.io/en/v1.4.6/plugins/fetchart.html>

`beet fetchart -f`

Add Music to /etc/fstab

	/dev/sdd1 /run/media/chema/Music ntfs-3g uid=chema gid=users 0 0

### lightdm not starting

[LightDM]
   logind-check-graphical=true

### fastest boot

`systemd-analyze blame`

This told me that the systemd timers ‘mandb.timer’was slowing down my boot time because they were executed on every reboot. 
That because the timer was set to run at midnight, and if you turn off your PC the timer will run again and again.

To check all the active timers you’ll write:

`systemctl list-timers --all`

The fix is very simple, move to the directory /etc/systemd/system/:

`cd /etc/systemd/system/`

Then copy the original timers file:

`sudo cp /usr/lib/systemd/system/man-db.timer .`

`sudo cp /usr/lib/systemd/system/updatedb.timer .`

Now edit them (as root), changing the ‘OnCalendar=daily’ to ‘OnCalendar=weekly’:

`sudo nano man-db.timer`

So ‘man-db.timer’ goes from:

	[Unit]
	Description=Daily man-db cache update
	[Timer]
	OnCalendar=daily
	AccuracySec=1d
	Persistent=true

To:

	[Unit]
	Description=Daily man-db cache update
	[Timer]
	OnCalendar=weekly
	AccuracySec=1d
	Persistent=true


At your next reboot the boot time will be faster.

You can check the timers enabled in your system using this command:

`systemctl list-timers --all`

### ssh

copy sshd_config to /etc/ssh

`sudo systemctl edit sshd.socket`

	[Socket]
	ListenStream=43333
	FreeBind=true

Launch sshd service

`sudo systemctl enable sshd.socket`

`sudo systemctl start sshd.socket`

`ssh -p 43333 chema@192.168.0.11`

### mps-youtube

Once you install mps-youtube, launch it with:

`mpsyt`

Then type h to see the options. For quick usage, you can just do:

	/[query]

to search for something, then type the number ID of the video to listen to its sound, or type:

	i [video-number]

to see its information, and type:

	d [video-number]

to download it. If just listening is not enough for you, here is the trick:

	set player mpv
	set show_video True
	set max_res 1080
	set fullscreen True