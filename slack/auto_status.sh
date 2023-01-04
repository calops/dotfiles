#! /bin/bash

IP_FILE=~/.local/share/last_ip

CLIENT_IP=${SSH_CONNECTION%% *}
LAST_IP=$(test -f $IP_FILE && cat $IP_FILE)

if test "$CLIENT_IP" = "$LAST_IP"; then
    exit 0
fi

echo $CLIENT_IP >$IP_FILE

case $CLIENT_IP in
    195.25.209.241 | 192.168.1.*)
        ./slack_status.sh onsite
        ;;
    *)
        ./slack_status.sh remote
        ;;
esac
