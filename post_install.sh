#!/bin/sh

# Initialise defaults
FILE_NAME=$(curl -s https://api.github.com/repos/lidarr/Lidarr/releases | jq -r '[[.[] | select(.draft != true) | select(.prerelease == true)][0] | .assets | .[] | select(.name | endswith(".linux.tar.gz")) | .name][0]')
DOWNLOAD=$(curl -s https://api.github.com/repos/lidarr/Lidarr/releases | jq -r '[[.[] | select(.draft != true) | select(.prerelease == true)][0] | .assets | .[] | select(.name | endswith(".linux.tar.gz")) | .browser_download_url][0]')
  
fetch -o /usr/local/share "${DOWNLOAD}"
tar -xzvf /usr/local/share/${FILE_NAME} -C /usr/local/share
rm /usr/local/share/"${FILE_NAME}"

pw user add lidarr -c lidarr -u 353 -d /nonexistent -s /usr/bin/nologin

chmod u+x /usr/local/etc/rc.d/lidarr
sysrc "lidarr_enable=YES"
