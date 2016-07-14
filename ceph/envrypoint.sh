#!/bin/bash
set -x
set -e
set -o pipefail

if [ -n "${RANCHER}" ]
then
  MON_IP=${MON_IP:-}
  # Wait until giddyup returns an IP
  while [ -z "${MON_IP}" ]
  do
    MON_IP=$(giddyup ip myip 2>/dev/null)
  done

  # Then wait for network readiness
  while [ "$(ip a | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}\/[0-9]{1,2}')" ]
  do
    CEPH_PUBLIC_NETWORK=$(ipcalc $(ip a | grep "${MON_IP}" \
      | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}\/[0-9]{1,2}') | grep -E '^Network:' \
      | awk '{print $2}')
  done 
  export CEPH_PUBLIC_NETWORK
  export MON_IP
fi

exec /entrypoint.sh "$@"
