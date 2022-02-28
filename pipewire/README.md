# Using Pipewire in Manjaro

This are very superficial notes of what I've done in my system. For real documentation see the [pipewire wiki](https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/home).

## Install packages. 

Look at the Makefile in this directory. `make install`

## Configuration files.

They are in `/usr/share/pipewire` and `/usr/share/wireplumber` by default. To edit them you must copy them to `~/.config/pipewire` and `~/.config/wireplumber`. I copied them to this directory instead and created simlinks to `~/.config`. See Makefile `make link`.

## Running daemons.

`systemctl --user enable --now pipewire-pulse.service pipewire.service wireplumber.service`

## Configuring sound card profiles.

Use `pavuctl` to set your default sound card and choose the "pro-audio" profile for multi-channel sound cards. This will enable all of the inputs/outputs instead of aggregating to single 5.1 or stereo ports.

## Setting Sample Rate and Buffer Size.

### Via config files:

These parameters can/should be set in a few places:

* The ones used by pipewire's DSP graph in `config/pipewire/pipewire.conf`.
* The ones used by hardware devices in `config/wireplumber/main.lua.d/50-alsa-config.lua`.
* The ones used by jack applications in `config/pipewire/jack.conf`.
* [Per application](https://gitlab.freedesktop.org/pipewire/pipewire/-/wikis/Config-JACK#per-application-latency)

See the `set_latency.py` script. Notice I'm setting num-periods to 4, that's what works with my sound card.

You can check if the actual hardware parameters were changed with: `cat /proc/asound/card0/pcm0p/sub0/hw_params`. And the applications' parameters with: `pw-top`.

### At runtime:

According to pipewire wiki, you can set the samplerate and buffer sizes with the following commands during runtime. See the `set_latency_runtime.py` script.
```
# For the DSP Graph and all Jack apps:
pw-metadata -n settings 0 clock.force-rate <sample_rate>
pw-metadata -n settings 0 clock.force-quantum <buffer_size>

# For a particular sound card, first get the card id:
pw-cli ls Node

# And then set the properties of that card by id:
pw-cli s <id> Props '{ params = [ "api.alsa.period-num" <buffer_size> ] }'
pw-cli s <id> Props '{ params = [ "api.alsa.period-size" 2 ] }'
pw-cli s <id> Props '{ params = [ "audio.rate" <sample_rate> ] }'
```
But this is only sets the parameters for some applications, in my experience so I'm not using this.

