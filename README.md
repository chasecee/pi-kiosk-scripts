# Raspberry Pi Chromium Kiosk Setup README

This README provides a guide on setting up a Raspberry Pi to automatically launch Chromium in kiosk mode, displaying a specified webpage on boot. You can clone this repo or just use it as a guide to set it up yourself.

## Prerequisites

- Raspberry Pi (tested on Pi Zero 2 W)
- Raspberry Pi OS with desktop environment
- Basic familiarity with terminal and command line

## Step-by-Step Guide

### Initial Setup

1. **Install Raspberry Pi OS** :

- Use Raspberry Pi Imager to flash Raspberry Pi OS (with desktop) to an SD card.
- Boot your Raspberry Pi with this SD card.
- Follow the setup wizard (connect to Wi-Fi, update software, etc.).

2. **Enable SSH (Optional)** :

- For remote access, enable SSH on your Pi.

### Install Necessary Packages

1. **Install Chromium and Unclutter** :

- Open a terminal.
- Update and install Chromium:

```bash
sudo apt-get update
sudo apt-get install chromium-browser
```

- Install `unclutter` to hide the mouse cursor:

```bash
sudo apt-get install unclutter
```

### Configure Autostart (Attempted Method)

1. **Autostart Setup** :

- Edit the LXDE autostart script:

```bash
sudo nano /etc/xdg/lxsession/LXDE-pi/autostart
```

- Add the following to launch Chromium in kiosk mode:

```bash
@xset s off
@xset -dpms
@xset s noblank
@unclutter -idle 0.1 -root
@chromium-browser --kiosk --noerrdialogs --disable-translate --disable-infobars --disable-features=TranslateUI --incognito "http://your-web-page.com"
```

- Replace `"http://your-web-page.com"` with your desired URL.

### Cron Job Setup (Alternative Method)

1. **Create a Startup Script** :

- Create a script in `/home/pi/pi-kiosk-scripts/`:

```bash
mkdir -p /home/pi/pi-kiosk-scripts
nano /home/pi/pi-kiosk-scripts/start_chromium.sh
```

- Or use the script from this repo
- Add the following content to the script:

```bash
#!/bin/bash
export DISPLAY=:0
xset s off
xset -dpms
xset s noblank
unclutter -idle 0.1 -root &
chromium-browser --kiosk --noerrdialogs --no-restore --disable-translate --disable-infobars --disable-features=TranslateUI --incognito "http://your-web-page.com"
```

- Make the script executable:

```bash
chmod +x /home/pi/pi-kiosk-scripts/start_chromium.sh
```

2. **Set Up Cron Job** :

- Edit the crontab file:

```bash
crontab -e
```

- Add the following line to run the script at boot:

```bash
@reboot sleep 60 && /home/pi/pi-kiosk-scripts/start_chromium.sh
```

### Troubleshooting

- **Logs** : Add logging to your script for troubleshooting.
- **Manual Testing** : After reboot, test the script manually.
- **Cron Logs** : Check `cron` logs (`grep CRON /var/log/syslog`) for issues.
- **Display Issues** : Ensure the script is executed when the graphical environment is ready.

## Final Notes

- This setup was tailored for a Raspberry Pi Zero 2 W running Raspberry Pi OS with desktop.
- Adjustments may be necessary for different hardware or software versions.
- This guide assumes a basic level of comfort with command-line operations and text file editing on the Raspberry Pi.
