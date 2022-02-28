#! /usr/bin/python

import sys
import subprocess
import time

##
# Set the sample rate and buffer size for a list of sound cards and for the DSP process in pipewire.

##
# The names of the audio cards that will be affected
card_names = ['HDA Intel PCH', 'Model 12']


##
# Main function
def main(buffer_size, sample_rate):
    run_command(
        "pw-metadata -n settings 0 clock.force-rate {0}".format(sample_rate))
    run_command("pw-metadata -n settings 0 clock.force-quantum {0}".format(
        buffer_size))

    ids = get_node_ids()
    for node_id in ids:
        set_buffer_size(node_id, buffer_size)
        set_sample_rate(node_id, sample_rate)


##
# Sets the buffer size of a Node
def set_buffer_size(node_id, buffer_size):
    command = "pw-cli s {0} Props '{{ params = [ \"api.alsa.period-num\" {1} ] }}'".format(
        node_id, buffer_size)
    run_command(command)
    command = "pw-cli s {0} Props '{{ params = [ \"api.alsa.period-size\" 2 ] }}'".format(
        node_id)
    run_command(command)


##
# Sets the sample rate of a Node
def set_sample_rate(node_id, sample_rate):
    command = "pw-cli s {0} Props '{{ params = [ \"audio.rate\" {1} ] }}'".format(
        node_id, sample_rate)
    run_command(command)


##
# Find the ids of pipewire nodes that are audio sinks or audio sources and
# which names are in the card_names array
def get_node_ids():
    info = run_command('pw-cli ls Node', False)
    valid_types = ['Audio/Sink']
    ids = []
    current_id = ''
    current_name = ''
    current_type = ''
    for line in info.splitlines():
        line = line.strip()
        if line.startswith('id'):
            if current_name in card_names and current_type in valid_types and current_id != '':
                ids.append(current_id)
            current_name = ''
            current_type = ''
            current_id = line.split(',')[0][2:].strip()

        elif line.startswith('node.nick'):
            current_name = line.split('=')[1].strip(' "')

        elif line.startswith('media.class'):
            current_type = line.split('=')[1].strip(' "')

    if current_name in card_names and current_type in valid_types and current_id != '':
        ids.append(current_id)

    return ids


##
# Run a command and return output
def run_command(command, doPrint=True):
    time.sleep(2)
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
    print("Usage:\n\tset_latency.py [buffer_size] [sample_rate]")


##
# Check if command line parameters are correct
if __name__ == "__main__":
    args = sys.argv
    try:
        buffer_size = int(args[1])
        sample_rate = int(args[2])
    except:
        help()
        exit()

    main(buffer_size, sample_rate)
