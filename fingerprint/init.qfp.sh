#!/vendor/bin/sh

QTI_VFS_DIR=/data/vendor/misc/qti_fp
VFS_CALIB_PATH=$QTI_VFS_DIR/vfs_calib.dat
VFS_CALIB_SRC=/vendor/etc/qti_fp/vfs_calib.dat

# Update prop if not already set.
init_prop() {
    PROP=`getprop $1`
    if [[ -z "$PROP" ]]
    then
      setprop $1 "$2"
    fi
}

# Clear prop
clear_prop() {
  setprop $1 ""
}

UPDATE_VFS=`getprop persist.vendor.qfp.update_vfs_calib`

# Copy if file doesn't exist or if the persist flag is set.
if [[ ! -f $VFS_CALIB_PATH || $UPDATE_VFS -eq 1 ]]; then
    log -p v "QFP: Updating vfs_calib.dat"
    mkdir -p $QTI_VFS_DIR
    chmod 0777 $QTI_VFS_DIR
    cp $VFS_CALIB_SRC $VFS_CALIB_PATH
    chmod 0777 $VFS_CALIB_PATH
    chown system:system $VFS_CALIB_PATH
    # Clear the flag after the initial copy.
    clear_prop persist.vendor.qfp.update_vfs_calib
fi

init_prop persist.vendor.qfp.enable_pv "12 0 0"
init_prop persist.vendor.qfp.enable_setprop 0

# If enable_setprop is 0 (disabled), delete the set props and use the hardcoded.
if [[ `getprop persist.vendor.qfp.enable_setprop` -eq 0 ]]; then
  clear_prop persist.vendor.qfp
  clear_prop persist.vendor.qfp.enable_intr2
  clear_prop persist.vendor.qfp.enable_fd
  clear_prop persist.vendor.qfp.enable_td
  clear_prop persist.vendor.qfp.enable_ntz
  clear_prop persist.vendor.qfp.fd_events_src
  clear_prop persist.vendor.qfp.tz_srv_name
  clear_prop persist.vendor.qfp.tz_dev_name
  clear_prop persist.vendor.qfp.vfs_info
fi

# Default to debug log level
init_prop log.tag.QFP 3
