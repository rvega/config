#! /usr/bin/python

import sys
import fileinput
import subprocess

##
# Set the sample rate and buffer size for all sound cards, the DSP graph, and
# all jack applications in pipewire.


##
# Replace values in all config files.
def set_parameters(buffer_size, sample_rate):
    replace('./config/pipewire/pipewire.conf', 'default.clock.rate ',
            '    default.clock.rate = {0}'.format(sample_rate))
    replace('./config/pipewire/pipewire.conf', 'default.clock.allowed-rates ',
            '    default.clock.allowed-rates = [{0}]'.format(sample_rate))

    replace('./config/pipewire/pipewire.conf', 'default.clock.quantum ',
            '    default.clock.quantum = {0}'.format(buffer_size))
    replace('./config/pipewire/pipewire.conf', 'default.clock.min-quantum ',
            '    default.clock.min-quantum = {0}'.format(buffer_size))
    replace('./config/pipewire/pipewire.conf', 'default.clock.max-quantum ',
            '    default.clock.max-quantum = {0}'.format(buffer_size))

    replace('./config/pipewire/jack.conf', 'node.latency ',
            '     node.latency = {0}/{1}'.format(buffer_size, sample_rate))

    replace('./config/wireplumber/main.lua.d/50-alsa-config.lua',
            'api.alsa.period-size',
            '      ["api.alsa.period-size"] = {0},'.format(buffer_size))
    replace('./config/wireplumber/main.lua.d/50-alsa-config.lua',
            'api.alsa.period-num',
            '      ["api.alsa.period-num"] = {0},'.format(4))

    replace('./config/wireplumber/main.lua.d/50-alsa-config.lua', 'audio.rate',
            '      ["audio.rate"] = {0},'.format(sample_rate))
    replace('./config/wireplumber/main.lua.d/50-alsa-config.lua',
            'audio.allowed-rates',
            '      ["audio.allowed-rates"] = "{0}",'.format(sample_rate))


def set_defaults():
    replace('./config/pipewire/pipewire.conf', 'default.clock.rate ',
            '    #default.clock.rate = 48000')
    replace('./config/pipewire/pipewire.conf', 'default.clock.allowed-rates ',
            '    #default.clock.allowed-rates = [ 48000 ]')

    replace('./config/pipewire/pipewire.conf', 'default.clock.quantum ',
            '    #default.clock.quantum = 1024')
    replace('./config/pipewire/pipewire.conf', 'default.clock.min-quantum ',
            '    #default.clock.min-quantum = 32')
    replace('./config/pipewire/pipewire.conf', 'default.clock.max-quantum ',
            '    #default.clock.max-quantum = 2048')

    replace('./config/pipewire/jack.conf', 'node.latency ',
            '     #node.latency = 1024/48000')

    replace('./config/wireplumber/main.lua.d/50-alsa-config.lua',
            'api.alsa.period-size', '      --["api.alsa.period-size"] = 1024,')
    replace('./config/wireplumber/main.lua.d/50-alsa-config.lua',
            'api.alsa.period-num', '      --["api.alsa.period-num"] = 32,')

    replace('./config/wireplumber/main.lua.d/50-alsa-config.lua', 'audio.rate',
            '      --["audio.rate"] = 44100,')
    replace('./config/wireplumber/main.lua.d/50-alsa-config.lua',
            'audio.allowed-rates',
            '      --["audio.allowed-rates"] = "44100, 48000, 96000",')


##
# Replaces a line in a file
def replace(file_name, search, replace):
    for line in fileinput.input(file_name, inplace=True):
        if search in line:
            print(replace)
        else:
            print(line, end='')


##
# Run a command and return output
def run_command(command, doPrint):
    output = subprocess.run(command.split(' '),
                            stdout=subprocess.PIPE).stdout.decode('utf-8')
    if doPrint:
        print('-----')
        print(command)
        print(output)

    return output


##
# Print help message
def help():
    print(("Usage:\n"
           "   set_latency.py [buffer_size] [sample_rate]\n"
           "Or:\n"
           "   set_latency.py defaults\n"))


##
# Check if command line parameters are correct
def main(args):
    if len(args) == 2 and args[1] == 'defaults':
        print("Setting default sample rate and buffer size")
        set_defaults()
    elif len(args) == 3:
        buffer_size = int(args[1])
        sample_rate = int(args[2])
        print("Setting sample rate {0} and buffer size {1}".format(
            sample_rate, buffer_size))
        set_parameters(buffer_size, sample_rate)
    else:
        help()
        exit()

    run_command(
        "systemctl --user restart pipewire-pulse.service pipewire.service wireplumber.service",
        True)


if __name__ == "__main__":
    main(sys.argv)
