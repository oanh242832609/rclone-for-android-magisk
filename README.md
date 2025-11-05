# rclone-for-android-magisk

A Magisk/KernelSU module for mounting cloud storage on Android using rclone.

> **Документация на русском**: [README.ru.md](README.ru.md) | **Russian Documentation**: [README.ru.md](README.ru.md)

## ✨ Features

- 🚀 **Automatic Beta Version Download**: Automatically downloads the latest beta version of rclone during installation
- 🌐 **KernelSU WebRoot Support**: Web-based configuration interface for KernelSU users
- 📦 **Multi-Architecture Support**: Supports arm64, arm-v7, x86_64, and x86 architectures
- ☁️ **Cloud Storage Mounting**: Mount multiple cloud storage providers (Google Drive, Dropbox, OneDrive, etc.)
- 🔄 **Automatic Syncing**: Built-in sync daemon for automatic file uploads
- 🎯 **Easy Configuration**: Simple configuration through terminal or web interface

## 📋 Requirements

- Android device with root access (Magisk or KernelSU)
- Internet connection during installation (to download rclone binary)
- Cloud storage account (Google Drive, Dropbox, OneDrive, etc.)

## 🔧 Installation

1. Download the latest release from the [Releases](https://github.com/oanh242832609/rclone-for-android-magisk/releases) page
2. Install the module through Magisk Manager or KernelSU
3. Reboot your device
4. Configure rclone using terminal: `rclonew config`
5. Or create a configuration file at `/sdcard/.rclone/rclone.conf`

## 🌐 Web Interface (KernelSU)

If you're using KernelSU, you can access the web configuration interface:

1. Open KernelSU Manager
2. Navigate to the module's webroot page
3. Or directly access the configuration at `/data/adb/modules/com.piyushgarg.rclone/webroot/index.html`

## 📝 Configuration

### Quick Start

```bash
# Configure your cloud storage remotes
rclonew config

# Remount all configured remotes
rclonew remount

# Check status
rclonew

# Unmount all remotes
rclonew unmount
```

### Configuration File

Create or edit `/sdcard/.rclone/rclone.conf` with your cloud storage credentials.

Example configuration:
```ini
[gdrive]
type = drive
client_id = your_client_id
client_secret = your_client_secret
token = {"access_token":"..."}
```

### Advanced Configuration

You can customize mount parameters by creating `.param` files:

- Global parameters: `/sdcard/.rclone/.global.param`
- Remote-specific parameters: `/sdcard/.rclone/.remote_name.param`

Example parameters:
```bash
# Enable HTTP service
HTTP=1
HTTP_ADDR=127.0.0.1:38762

# Enable FTP service
FTP=1
FTP_ADDR=127.0.0.1:38763

# Bind to SD card
BINDSD=1

# Set cache mode
CACHEMODE=writes
```

## 📂 Directory Structure

- `/mnt/cloud/` - Root mount point for all cloud remotes
- `/sdcard/Cloud/` - SD card accessible mount point
- `/sdcard/.rclone/` - Configuration and log files
- `/data/rclone/cache/` - Cache directory
- `/data/adb/modules/com.piyushgarg.rclone/webroot/` - Web interface (KernelSU)

## 🔄 Automatic Syncing

The module includes a sync daemon that can automatically upload files from your device to cloud storage.

To enable syncing for a remote, create a parameter file:
```bash
# /sdcard/.rclone/.remote_name.param
SDSYNCDIRS=DCIM:Pictures:Documents
SYNC_WIFI=1
SYNC_CHARGE=0
SYNC_BATTLVL=20
```

## 🛠️ Troubleshooting

### Module not working after reboot
- Check if `/sdcard/.rclone/rclone.conf` exists
- Check logs at `/sdcard/.rclone/rclone.log`
- Try remounting: `rclonew remount`

### Remotes not mounting
- Verify your internet connection
- Check rclone configuration: `rclone config`
- Look for error messages in the log file

### Installation fails
- Ensure you have internet connection during installation
- Check if your architecture is supported
- Try reinstalling the module

## 🤝 Credits

- Original module by [piyushgarg](https://github.com/piyushgarg)
- [Rclone](https://rclone.org/) by Nick Craig-Wood
- Beta version integration and KSU webroot support added

## 📄 License

This project follows the original licensing terms.

## 🔗 Links

- [Rclone Official Website](https://rclone.org/)
- [Rclone Documentation](https://rclone.org/docs/)
- [Rclone Beta Releases](https://beta.rclone.org/)
- [Magisk](https://github.com/topjohnwu/Magisk)
- [KernelSU](https://github.com/tiann/KernelSU)
