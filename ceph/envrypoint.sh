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
  # Trying to find a randomly happening error (about 2/3 of the tries) somewhere in the CEPH_PUBLIC_NETWORK calculation
  A=$(ip a | grep "$(giddyup ip myip)")
  B=$(echo "$A"| grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}/[0-9]{1,2}')
  C=$(ipcalc $B)
  D=$(echo "$C" | grep -E '^Network:')
  E=$(echo "$D" | awk '{print $2}')
  echo "$E"
  export CEPH_PUBLIC_NETWORK
  export MON_IP
fi

exec /entrypoint.sh "$@"
