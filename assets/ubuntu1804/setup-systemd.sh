#!/bin/bash
echo "dash dash/sh boolean false" | debconf-set-selections
DEBIAN_FRONTEND=noninteractive dpkg-reconfigure -p low dash

rm -f /etc/systemd/system/*.wants/*

cd /lib/systemd/system/sysinit.target.wants/
for i in *
do
 [ $i == systemd-tmpfiles-setup.service ] || rm -f $i
done

rm -f /lib/systemd/system/multi-user.target.wants/*
cd /lib/systemd/system/multi-user.target.wants/
ln -s ../dbus.service
rm -f /lib/systemd/system/local-fs.target.wants/*
rm -f /lib/systemd/system/sockets.target.wants/*udev*
rm -f /lib/systemd/system/sockets.target.wants/*initctl*

