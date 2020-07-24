#!/usr/local/bin/bash
# This file contains the install script for lidarr

#init jail
initplugin "$1"

# Check if dataset for completed download and it parent dataset exist, create if they do not.
createmount "$1" "${global_dataset_downloads}"
createmount "$1" "${global_dataset_downloads}"/complete /mnt/fetched

# Check if dataset for media library and the dataset for movies exist, create if they do not.
createmount "$1" "${global_dataset_media}"
createmount "$1" "${global_dataset_media}"/music /mnt/music

createmount "$1" chown -R lidarr:lidarr /usr/local/share/Lidarr /config
iocage exec "$1" service lidarr start

exitplugin "$1"
