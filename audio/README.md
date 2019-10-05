# Alsa mixer settings:

Set mixer settings with alsamixer or xfce4-mixer and store them with `sudo alsactl store`. 
Load them later with `alsactl -L restore`

# snd-aloop

Requires the snd-aloop module to be loaded. Add "snd-aloop" to /et c/modules-load.d/modules.conf

# Real time tweaks:

All of these were taken form the Arch wiki on pro audio. https://wiki.archlinux.org/index.php/Pro_Audio

1. Set the threadirqs kernel parameter.  add `GRUB_CMDLINE_LINUX_DEFAULT="threadirqs"` in `/etc/default/grub` and then do `sudo update-grub`. Verify with `cat /proc/cmdline`.
Measuring with PreSonus 1818VSL at 96KHz and 256 block size, latency went down from 343 samples to 302.

2. Set cpu scaling to performance. See ../../cpu

3. Install linux-rt kernel

4. Change rt irq frequency: 
    `echo 2048 > /sys/class/rtc/rtc0/max_user_freq`
    `echo 2048 > /proc/sys/dev/hpet/max-user-freq`
