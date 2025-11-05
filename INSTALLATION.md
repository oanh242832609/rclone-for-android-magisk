# Installation Guide

## Overview

This module has been updated to automatically download the latest beta version of rclone during installation and includes KernelSU webroot support for easy configuration.

## What's New

### Automatic Beta Version Download
- The module no longer includes a pre-compiled rclone binary
- During installation, it automatically downloads the latest beta version from https://beta.rclone.org
- Supports multiple architectures: arm64, arm-v7, x86_64, x86
- Always ensures you have the newest features and bug fixes

### KernelSU WebRoot Support
- Web-based configuration interface for KernelSU users
- Easy access to module information and settings
- Quick links to common operations
- Modern, responsive UI

## Installation Steps

### 1. Prerequisites
- Android device with root access (Magisk or KernelSU)
- Internet connection (required for downloading rclone binary)
- Cloud storage account

### 2. Install Module

#### Using Magisk Manager:
1. Open Magisk Manager
2. Tap on "Modules" in the bottom navigation
3. Tap on "Install from storage"
4. Select the downloaded module ZIP file
5. Wait for installation to complete (this will download rclone beta)
6. Reboot your device

#### Using KernelSU:
1. Open KernelSU Manager
2. Navigate to "Modules" section
3. Tap "Install" button
4. Select the downloaded module ZIP file
5. Wait for installation to complete (this will download rclone beta)
6. Reboot your device

### 3. First-Time Configuration

After reboot, you need to configure rclone:

#### Option A: Using Terminal (Recommended)
```bash
# Open terminal or SSH into your device
su

# Run rclone configuration wizard
rclonew config

# Follow the interactive prompts to add your cloud storage
```

#### Option B: Manual Configuration
1. Create the directory: `/sdcard/.rclone/`
2. Create or edit the file: `/sdcard/.rclone/rclone.conf`
3. Add your cloud storage configuration (see examples below)
4. Remount: `rclonew remount`

### 4. Verify Installation

Check if rclone is working:
```bash
# Check rclone version
rclone version

# List configured remotes
rclone listremotes

# Check mounted remotes
mount | grep rclone
```

## Configuration Examples

### Google Drive
```ini
[gdrive]
type = drive
scope = drive
token = {"access_token":"...","token_type":"Bearer","refresh_token":"...","expiry":"..."}
```

### Dropbox
```ini
[dropbox]
type = dropbox
token = {"access_token":"...","token_type":"bearer","expiry":"..."}
```

### OneDrive
```ini
[onedrive]
type = onedrive
token = {"access_token":"...","token_type":"Bearer","refresh_token":"...","expiry":"..."}
drive_id = ...
drive_type = personal
```

## Advanced Configuration

### Enable Web Services

Create `/sdcard/.rclone/.global.param`:
```bash
# Enable HTTP web UI
HTTP=1
HTTP_ADDR=127.0.0.1:38762

# Enable FTP server
FTP=1
FTP_ADDR=127.0.0.1:38763

# Enable SFTP server
SFTP=1
SFTP_ADDR=127.0.0.1:38722
SFTP_USER=admin
SFTP_PASS=password

# Bind to SD card for easy access
BINDSD=1

# Network check before mounting
NETCHK=1
NETCHK_ADDR=google.com
```

### Per-Remote Configuration

Create `/sdcard/.rclone/.remotename.param` to customize specific remotes:
```bash
# Cache settings
CACHEMODE=writes
CHUNKSIZE=5M
CHUNKTOTAL=10G

# Performance
BUFFERSIZE=16M
READAHEAD=256k

# Mount options
READONLY=0
BINDSD=1
SDBINDPOINT=MyCloud

# Auto-sync settings
SDSYNCDIRS=DCIM:Pictures:Documents
SYNC_WIFI=1
SYNC_CHARGE=0
SYNC_BATTLVL=20
```

## Accessing Your Cloud Storage

After successful configuration and remount:

- **Root Mount Point**: `/mnt/cloud/remotename/`
- **SD Card Access**: `/sdcard/Cloud/remotename/`
- **File Managers**: Most file managers can browse to these locations

## KernelSU WebRoot Access

If you're using KernelSU:

1. Open KernelSU Manager app
2. Navigate to "Modules"
3. Find "rclone-mount" module
4. Tap on "WebRoot" or "Web UI" option
5. The web interface will open showing:
   - Module status and information
   - Quick action buttons
   - Configuration paths
   - Terminal command reference
   - Service management options

Alternatively, open a browser and navigate to:
```
file:///data/adb/modules/com.piyushgarg.rclone/webroot/index.html
```

## Useful Commands

```bash
# Configure remotes
rclonew config

# Remount all remotes
rclonew remount

# Unmount all remotes
rclonew unmount

# Disable a specific remote
rclonew disable remotename

# Check version
rclone version

# List remotes
rclone listremotes

# Check what's mounted
mount | grep cloud
```

## Troubleshooting

### Module installed but rclone not working
**Solution**: Check `/sdcard/.rclone/rclone.log` for errors. Ensure internet connection was available during installation.

### "No rclone binary found" error
**Solution**: The download might have failed. Reinstall the module with internet connection.

### Remotes not mounting after reboot
**Solution**: 
1. Check if config exists: `ls -la /sdcard/.rclone/rclone.conf`
2. Verify config is valid: `rclone listremotes`
3. Check logs: `cat /sdcard/.rclone/rclone.log`
4. Try manual remount: `rclonew remount`

### Unsupported architecture error
**Solution**: This module supports arm64, arm-v7, x86_64, and x86. If you have a different architecture, the module cannot be used on your device.

### Can't access files from file manager
**Solution**: 
1. Ensure BINDSD=1 in configuration
2. Check if mount is successful: `mount | grep cloud`
3. Verify permissions: `ls -la /mnt/cloud/`
4. Try accessing through: `/sdcard/Cloud/`

## Updating the Module

To update to a newer version:
1. Download the new version
2. Install over the old version (no need to uninstall)
3. Reboot
4. The new beta version of rclone will be downloaded automatically

## Getting Help

- Check the logs: `/sdcard/.rclone/rclone.log`
- Review rclone documentation: https://rclone.org/docs/
- Check module README: [README.md](README.md)
- Russian documentation: [README.ru.md](README.ru.md)

## Notes

- The rclone binary is downloaded during installation, not included in the module
- Internet connection is required during installation
- First boot after installation may take longer as rclone downloads
- The module will use the latest beta version, which may have new features but could be less stable than stable releases
- Your configuration files are never modified or deleted during updates
