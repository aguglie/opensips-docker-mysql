#!/bin/bash
rm -rf /var/run/rsyslogd.pid

HOST_IP=$(ip route get 8.8.8.8 | head -n +1 | tr -s " " | cut -d " " -f 7)

sed -i "s/listen=.*/listen=udp:${HOST_IP}:5060/g" /usr/local/etc/opensips/opensips.cfg

service rsyslog start

#/usr/local/sbin/opensipsctl start

#tail -f /var/log/opensips.log
/usr/local/sbin/opensips -M 8 -m 256 -F -f /etc/opensips/opensips.cfg
