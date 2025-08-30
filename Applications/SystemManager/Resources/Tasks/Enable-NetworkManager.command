#!/usr/bin/env bash

NMCFG="/etc/NetworkManager/NetworkManager.conf";
NMCFGT="/tmp/nm_$$.txt";

cat << EOF > $NMCFGT
[main]
plugins=ifupdown,keyfile

[ifupdown]
managed=true
EOF

NCFG="/etc/network/interfaces";
NCFGT="/tmp/net_$$.txt";

cat << EOF > $NCFGT
# This file describes the network interfaces available on your system
# and how to activate them. For more information, see interfaces(5).

source /etc/network/interfaces.d/*

# The loopback network interface
auto lo
iface lo inet loopback
EOF

CMD="systemctl stop NetworkManager; \
systemctl stop networking; \
cp $NMCFGT $NMCFG; \
cp $NCFGT $NCFG; \
systemctl start networking; \
systemctl start NetworkManager"

#echo "$CMD"

clear
echo "******************"
echo "**  WARNING!!!  **"
echo "******************"
echo ""
echo " this command will reset $NMCFG and $NCFG files"
echo ""
echo " press <ENTER> to continue, <CTRL-C> to cancel"
read DD

sudo sh -c "$CMD"

sleep 2
nmcli device wifi >/dev/null
nmtui connect
