FROM ceph/daemon:latest
MAINTAINER Till Wiese <mail-github.com@till-wiese.de>

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y ipcalc curl \
  && curl -sLo /usr/local/bin/giddyup $(curl -s https://api.github.com/repos/cloudnautique/giddyup/releases/latest \
    | grep -E '"browser_download_url.*giddyup"'| head -1 | cut -d\" -f4) \
  && chmod 755 /usr/local/bin/giddyup

COPY ["ceph_envs.sh", "/etc/profile.d/"]
RUN cat /etc/profile.d/ceph_envs.sh >> /etc/bash.bashrc

ENTRYPOINT ["/bin/bash"]
