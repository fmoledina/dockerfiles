#!/bin/bash
set -x
set -e
set -o pipefail

if [ -n "${RANCHER}" ]
then
  MON_IP=$(giddyup ip myip 2>/dev/null|| printf '')

  if [ -n "${MON_IP}" ]
  then
    CEPH_PUBLIC_NETWORK=$(ipcalc $(ip a | grep "$(giddyup ip myip)" \
      | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}/[0-9]{1,2}') | grep -E '^Network:' \
      | awk '{print $2}' || printf '')
    export CEPH_PUBLIC_NETWORK
    export MON_IP
  fi
fi

exec /entrypoint.sh "$@"
