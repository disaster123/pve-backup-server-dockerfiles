FROM debian:bookworm

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y
RUN apt-get dist-upgrade -y
RUN apt-get install -y wget apt-utils

# no idea why but this fails if it is installed along with proxmox-backup-server
RUN apt-get install -y ifupdown2

RUN wget https://enterprise.proxmox.com/debian/proxmox-release-bookworm.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-8.x.gpg

RUN echo "deb http://download.proxmox.com/debian/pbs bookworm pbs-no-subscription" >/etc/apt/sources.list.d/pbs.list
RUN apt-get update -y

RUN apt-get install -y proxmox-backup-server=3.3.2-1

# Add default configs
ADD /pbs/ /etc/proxmox-backup/

VOLUME /etc/proxmox-backup
VOLUME /var/log/proxmox-backup
VOLUME /var/lib/proxmox-backup

RUN apt-get install -y runit

ADD runit/ /runit/
CMD ["runsvdir", "/runit"]
