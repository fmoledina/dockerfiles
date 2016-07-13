MON_IP=$(giddyup ip myip)
CEPH_PUBLIC_NETWORK=$(ipcalc $(ip a | grep "$(giddyup ip myip)" \
  | grep -oE '([0-9]{1,3}\.){3}[0-9]{1,3}/[0-9]{1,2}') | grep -E '^Network:' \
  | awk '{print $2}')

export MON_IP
export CEPH_PUBLIC_NETWORK
