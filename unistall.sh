#!/bin/bash

echo "script by mim mesmo"
echo "migrando genieacs para docker"

echo "backup Mongo"

cd /tmp
mongodump
sleep 3
ls /tmp | grep dump 
sleep 3

echo "Desabilitando mongo "
systemctl stop mongod
systemctl disable mongod

echo "unistall Genieacs"

npm uninstall -g genieacs
groupadd robson
usermod -g robson genieacs
groupdel genieacs
rm -r  /opt/genieacs
rm -r  /var/log//genieacs
rm -r /root/stunserver
systemctl stop genieacs-fs
systemctl stop genieacs-ui
systemctl stop genieacs-nbi
systemctl stop genieacs-cwmp
systemctl disable genieacs-cwmp
systemctl disable genieacs-ui
systemctl disable genieacs-fs
systemctl disable genieacs-nbi
rm -r /etc/systemd/system/genieacs-fs.service
rm -r /etc/systemd/system/genieacs-ui.service
rm -r /etc/systemd/system/genieacs-nbi.service
rm -r /etc/systemd/system/genieacs-cwmp.service
rm -r /etc/logrotate.d/genieacs

echo "Atualização pós alterações"
apt update -y
apt autoremove -y
apt update -y

echo "fim"
