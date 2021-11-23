FROM debian:buster

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y
RUN apt-get dist-upgrade -y
RUN apt-get install -y wget apt-utils

RUN wget http://download.proxmox.com/debian/proxmox-ve-release-6.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg

RUN echo "deb http://download.proxmox.com/debian/pbs buster pbs-no-subscription" >/etc/apt/sources.list.d/pbs.list
RUN apt-get update -y

RUN apt-get install -y proxmox-backup-server

# Add default configs
ADD /pbs/ /etc/proxmox-backup/

VOLUME /etc/proxmox-backup
VOLUME /var/log/proxmox-backup
VOLUME /var/lib/proxmox-backup

RUN apt-get install -y runit

ADD runit/ /runit/
CMD ["runsvdir", "/runit"]
