#!/bin/bash
set -x
set -e
set -o pipefail

if [ -n "${RANCHER}" ]
then
  MON_IP=$(giddyup ip myip 2>/dev/null)
  CEPH_PUBLIC_NETWORK=$(ipcalc $(ip a | grep "$(giddyup ip myip)" \
    | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}/[0-9]{1,2}') | grep -E '^Network:' \
    | awk '{print $2}')
  export CEPH_PUBLIC_NETWORK
  export MON_IP
fi

exec /entrypoint.sh "$@"
