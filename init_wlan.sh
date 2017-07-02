#!/system/bin/sh

for i in 1 2 3; do
    # sleep first to avoid issue when called after conn_init
    sleep 1
    if [ ! -f /sys/devices/platform/wcnss_wlan.0/net/wlan0/address ]; then
        echo sta > /sys/module/wlan/parameters/fwpath
    else
        break
    fi
done

if [ ! -f /sys/devices/platform/wcnss_wlan.0/net/wlan0/address ]; then
    # Driver is in a broken state, give it a few seconds and try to reload
    echo 1 > /dev/wcnss_wlan
    sleep 2
    echo sta > /sys/module/wlan/parameters/fwpath
fi
