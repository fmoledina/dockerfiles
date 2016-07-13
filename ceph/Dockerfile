FROM ceph/daemon:latest
MAINTAINER Till Wiese <mail-github.com@till-wiese.de>

RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y ipcalc curl \
  && curl -sLo /usr/local/bin/giddyup $(curl -s https://api.github.com/repos/cloudnautique/giddyup/releases/latest \
    | grep -E '"browser_download_url.*giddyup"'| head -1 | cut -d\" -f4) \
  && chmod 755 /usr/local/bin/giddyup

COPY ["inject_envs.sh", "/usr/local/sbin/"]
RUN /usr/local/sbin/inject_envs.sh

ENTRYPOINT ["/bin/bash"]
