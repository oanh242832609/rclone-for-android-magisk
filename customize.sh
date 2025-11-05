#!/system/bin/sh

# Magisk Module Installer Script
# This script runs during module installation

SKIPUNZIP=0

print_modname() {
  ui_print "*******************************"
  ui_print "    rclone-mount Module        "
  ui_print "  with Beta Version Support    "
  ui_print "*******************************"
}

on_install() {
  ui_print "- Installing rclone module..."
  
  # Detect architecture
  ARCH=$(getprop ro.product.cpu.abi)
  ui_print "- Detected architecture: $ARCH"
  
  case $ARCH in
    arm64-v8a|arm64)
      RCLONE_ARCH="arm64"
      ;;
    armeabi-v7a|armeabi)
      RCLONE_ARCH="arm-v7"
      ;;
    x86_64)
      RCLONE_ARCH="amd64"
      ;;
    x86)
      RCLONE_ARCH="386"
      ;;
    *)
      ui_print "! Unsupported architecture: $ARCH"
      exit 1
      ;;
  esac
  
  ui_print "- Using rclone architecture: $RCLONE_ARCH"
  
  # Download latest beta version
  ui_print "- Downloading latest rclone beta version..."
  
  RCLONE_URL="https://beta.rclone.org/rclone-beta-latest-linux-${RCLONE_ARCH}.zip"
  DOWNLOAD_DIR="/data/local/tmp"
  RCLONE_ZIP="${DOWNLOAD_DIR}/rclone-beta-latest.zip"
  
  # Download rclone
  if ! curl -L -o "$RCLONE_ZIP" "$RCLONE_URL" 2>&1; then
    ui_print "! curl failed, trying with wget..."
    if ! wget -O "$RCLONE_ZIP" "$RCLONE_URL" 2>&1; then
      ui_print "! Download failed. Please check your internet connection."
      exit 1
    fi
  fi
  
  ui_print "- Extracting rclone binary..."
  
  # Extract rclone binary
  unzip -o "$RCLONE_ZIP" -d "$DOWNLOAD_DIR" 2>&1 | grep -v "Archive:"
  
  # Find the rclone binary in the extracted folder
  RCLONE_BIN=$(find "$DOWNLOAD_DIR" -name "rclone" -type f | head -n 1)
  
  if [ -z "$RCLONE_BIN" ]; then
    ui_print "! Failed to find rclone binary in downloaded archive"
    exit 1
  fi
  
  # Copy rclone binary to module directory
  cp -f "$RCLONE_BIN" "$MODPATH/rclone"
  chmod 755 "$MODPATH/rclone"
  
  # Get rclone version
  RCLONE_VERSION=$("$MODPATH/rclone" version 2>&1 | head -n 1 | awk '{print $2}')
  
  if [ -z "$RCLONE_VERSION" ]; then
    ui_print "! Warning: Could not determine rclone version"
    RCLONE_VERSION="beta-latest"
  else
    ui_print "- Installed rclone version: $RCLONE_VERSION"
  fi
  
  # Update module.prop with new version
  sed -i "s/^BinVer=.*/BinVer=$RCLONE_VERSION/" "$MODPATH/module.prop"
  
  # Cleanup
  rm -f "$RCLONE_ZIP"
  rm -rf "$DOWNLOAD_DIR/rclone-"*
  
  ui_print "- Creating directory structure..."
  
  # Create necessary directories
  mkdir -p "$MODPATH/.config/rclone"
  mkdir -p "$MODPATH/.cache/rclone/bisync"
  
  # Create placeholder files if they don't exist
  [ ! -f "$MODPATH/.config/rclone/placeholder" ] && echo "" > "$MODPATH/.config/rclone/placeholder"
  [ ! -f "$MODPATH/.cache/rclone/bisync/placeholder" ] && echo "" > "$MODPATH/.cache/rclone/bisync/placeholder"
  
  ui_print "- Installation completed successfully!"
  ui_print ""
  ui_print "- Please configure rclone:"
  ui_print "  1. Create /sdcard/.rclone/rclone.conf"
  ui_print "  2. Or run 'rclonew config' from terminal"
  ui_print ""
  ui_print "- For KSU users: Web UI available at"
  ui_print "  /data/adb/modules/com.piyushgarg.rclone/webroot"
}

set_permissions() {
  # Set permissions
  set_perm_recursive $MODPATH 0 0 0755 0644
  set_perm $MODPATH/rclone 0 0 0755
  set_perm $MODPATH/fusermount 0 0 0755
  set_perm $MODPATH/inotifywait 0 0 0755
  set_perm $MODPATH/rclonew 0 0 0755
  set_perm $MODPATH/service.sh 0 0 0755
  set_perm $MODPATH/syncd.sh 0 0 0755
  set_perm $MODPATH/fusermount-wrapper.sh 0 0 0755
  
  # Set permissions for webroot if it exists
  if [ -d "$MODPATH/webroot" ]; then
    set_perm_recursive $MODPATH/webroot 0 0 0755 0644
  fi
}
