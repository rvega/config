#!/bin/bash

# Copyright 2018, 2019, 2020 Azure Zanculmarktum
# All rights reserved.
#
# Redistribution and use of this script, with or without modification, is
# permitted provided that the following conditions are met:
#
# 1. Redistributions of this script must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
#
#  THIS SOFTWARE IS PROVIDED BY THE AUTHOR "AS IS" AND ANY EXPRESS OR IMPLIED
#  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
#  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO
#  EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
#  SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
#  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
#  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
#  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
#  OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
#  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# Dependencies:
#  openssl

# Usage:
#  $ ./megafetch.sh https://mega.nz/#!abcdefgh!1234567890abcdefghijklmnopqrstuvwxyzABCDEFG
#  http://gfs208n103.userstorage.mega.co.nz/dl/-abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890A
#  file.name
#  abcefghijklmnopqrstuvwxyz0123456
#  1234567890abcdef0000000000000000
#  $ wget -O file.name http://gfs208n103.userstorage.mega.co.nz/dl/-abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890A
#  $ cat file.name | openssl enc -d -aes-128-ctr -K abcefghijklmnopqrstuvwxyz0123456 -iv 1234567890abcdef0000000000000000 > file.name.new
#  $ mv -f file.name.new file.name

URL=""

if [[ $1 =~ ^https?:\/\/mega(\.co)?\.nz ]]; then
	URL="$1"
fi

if [[ ! $URL ]]; then
	echo "Usage: ${0##*/} url" >&2
	exit 1
fi

CURL="curl -Y 1 -y 10"

missing=false
for cmd in openssl; do
	if [[ ! $(command -v "$cmd" 2>&1) ]]; then
		missing=true
		echo "${0##*/}: $cmd: command not found" >&2
	fi
done
if $missing; then
	exit 1
fi

if [[ $URL =~ .*/file/[^#]*#[^#]* ]]; then
	id="${URL#*file/}"; id="${id%%#*}"
	key="${URL##*file/}"; key="${key##*#}"
else
	id="${URL#*!}"; id="${id%%!*}"
	key="${URL##*!}"
fi

raw_hex=$(echo "${key}=" | tr '\-_' '+/' | tr -d ',' | base64 -d -i 2>/dev/null | od -v -An -t x1 | tr -d '\n ')
hex=$(printf "%016x" \
	$(( 0x${raw_hex:0:16} ^ 0x${raw_hex:32:16} )) \
	$(( 0x${raw_hex:16:16} ^ 0x${raw_hex:48:16} ))
)

json=$($CURL -s -H 'Content-Type: application/json' -d '[{"a":"g", "g":"1", "p":"'"$id"'"}]' 'https://g.api.mega.co.nz/cs?id=&ak=') || exit 1; json="${json#"[{"}"; json="${json%"}]"}"
file_url="${json##*'"g":'}"; file_url="${file_url%%,*}"; file_url="${file_url//'"'/}"

json=$($CURL -s -H 'Content-Type: application/json' -d '[{"a":"g", "p":"'"$id"'"}]' 'https://g.api.mega.co.nz/cs?id=&ak=') || exit 1
at="${json##*'"at":'}"; at="${at%%,*}"; at="${at//'"'/}"

json=$(echo "${at}==" | tr '\-_' '+/' | tr -d ',' | openssl enc -a -A -d -aes-128-cbc -K "$hex" -iv "00000000000000000000000000000000" -nopad | tr -d '\0'); json="${json#"MEGA{"}"; json="${json%"}"}"
file_name="${json##*'"n":'}"
if [[ $file_name == *,* ]]; then
	file_name="${file_name%%,*}"
fi
file_name="${file_name//'"'/}"

#$CURL -s "$file_url" | openssl enc -d -aes-128-ctr -K "$hex" -iv "${raw_hex:32:16}0000000000000000" > "$file_name"

echo "$file_url"
echo "$file_name"
echo "$hex"
echo "${raw_hex:32:16}0000000000000000"
