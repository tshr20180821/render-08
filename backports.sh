#!/bin/bash

set +x

echo "${1}" | tee -a "${2}"
curl -sS -m 10 "https://packages.debian.org/bookworm-backports/${1}" | grep '<h1>' | grep "${1}" | cut -c 14- | tee -a "${2}"
sleep 2s
