# CAF (Cloud Assistant Framework)

Co-design permanent, active, stateful, reliable cloud proxies with your web app.

See http://www.cafjs.com 

## A placeholder for firmware changes needed to run caf_ardrone in the ArDrone 2.0

** UNDER CONSTRUCTION**

This repository has submodules, after cloning use:

    git submodule update --init 


Goals:

- Connect the drone as a client of a wpa protected network (see https://github.com/daraosn/ardrone-wpa2).
- Enable dns queries in the drone (cross-compile libresolv.so)
- Enable a gps dongle (like USGlobalSat ND100S) accessible via gpsd (cross-compile gpsd and add kernel modules for usb serial- see http://www.drone-rk.org/wiki/ARDrone)
- Use udev rules to conditionally start the drone in `caf_ardrone` mode if a particular USB dongle is present. It is difficult to recover the drone if wifi gets messed up, and removing the dongle provides a simple way to boot normally.
- Synchronize local clock with ntp (i.e., cross-compile ntpclient http://doolittle.icarus.com/ntpclient/)
- Start a node.js daemon (like https://github.com/cafjs/caf_hellodrone_cli.git) that will push video streams and execute atomically bundles of commands with precise timing. See https://github.com/felixge/node-cross-compiler.git for cross-compiling node.js.
- Automatically restart a crashed node.js daemon with `mon` (see https://github.com/visionmedia/mon.git). Note that there is very little free memory in the drone and we aggressively force garbage collections by starting node with option `--expose_gc`. We also overprovision virtual memory (i.e., setting `overcommit_ratio`). This risky strategy occasionally fails and we use `mon` to restart the daemon...
- Periodically scan local wifi networks to improve indoors location capabilities.

The installation process will check that the current firmware version matches the target one (currently 2.3.3, to upgrade download from  http://durrans.com/ardrone/firmware/2.3.3/, place the plf file in the `/update` directory  -by, for example, using ftp- and reboot). If it matches it just untars a patch file in the root directory (see `applyTar.sh`). To create that tar file, some customization is needed (for example, npm install the daemon with your changes in `/data/caf` or set your wpa password and essid in `/etc/wpa_supplicant.conf`), and this is done with the script `buildTar.sh`. The name of the new tar file is `/tmp/changes.tar.gz`.

**WARNING**

This repository does not currently provide an easy and bullet-proof way to upgrade your drone. This is all work in progress, and it is very likely that scripts will leave your drone in a corrupted state from which it will be very difficult to recover. You have been warned... 

