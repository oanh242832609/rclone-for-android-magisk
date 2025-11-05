# Changelog

## v1.17 (2024-11-05)

### New Features
- ✨ Automatic download of latest beta version of rclone during installation
- ✨ Added KernelSU webroot support for web-based configuration
- ✨ Added customize.sh for better installation experience
- ✨ Support for multiple architectures (arm64, arm-v7, amd64, x86)

### Improvements
- 📦 Module now downloads rclone binary during installation instead of bundling it
- 🌐 Web UI accessible through KernelSU webroot at `/data/adb/modules/com.piyushgarg.rclone/webroot`
- 📝 Improved module description with beta version information
- 🔄 Updated module version to reflect new capabilities

### Technical Changes
- Added `customize.sh` installation script
- Added webroot directory with configuration web interface
- Updated module.prop with new version and description
- Added update.json for module update support

## v1.16 (Previous Version)

### Features
- Initial release with static rclone binary
- Basic mount functionality
- Service script for automatic mounting
- Support for multiple remotes
- Sync daemon for automatic uploads
