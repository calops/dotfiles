#!/bin/bash
CONFIG_DIR="$HOME/.slack_status"
CONFIG_FILE="$CONFIG_DIR/config"
IP_FILE="$CONFIG_DIR/last_ip"

# Colors
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
reset=$(tput sgr0)

function print_usage {
    echo "Usage:"
    echo "  $0 setup"
    echo "  $0 set (none|remote|office)"
    echo "  $0 auto"
    echo
    echo "Configuration is defined in ${green}$CONFIG_FILE${reset}."
    exit 1
}

function set_status {
    if [[ -f "$CONFIG_FILE" ]]; then
        source "$CONFIG_FILE"
    else
        echo "${red}No configuration file found at ${yellow}$CONFIG_FILE${reset}"
        echo "Run ${green}$0 setup${reset} to create one"
        exit 1
    fi

    case "$1" in
        none)
            EMOJI=""
            TEXT=""
            ;;
        remote)
            EMOJI=$REMOTE_EMOJI
            TEXT=$REMOTE_TEXT
            ;;
        office)
            EMOJI=$OFFICE_EMOJI
            TEXT=$OFFICE_TEXT
            ;;
        *)
            print_usage
            ;;
    esac

    echo "Updating status to: \"${yellow}$EMOJI ${green}$TEXT${reset}\""

    PROFILE="{\"status_emoji\":\"$EMOJI\",\"status_text\":\"$TEXT\"}"
    RESPONSE=$(curl -s --data token="$TOKEN" --data-urlencode profile="$PROFILE" \
        https://slack.com/api/users.profile.set)

    if echo "$RESPONSE" | grep -q '"ok":true,'; then
        echo "${green}Status updated.${reset}"
    else
        echo "${red}There was a problem updating the status.${reset}"
        echo "Response: $RESPONSE"
    fi
}

function auto_status {
    CLIENT_IP=${SSH_CONNECTION%% *}
    LAST_IP=$([[ -f $IP_FILE ]] && cat $IP_FILE)

    if test "$CLIENT_IP" = "$LAST_IP"; then
        exit 0
    fi

    echo $CLIENT_IP >$IP_FILE

    case $CLIENT_IP in
        195.25.209.241 | 192.168.1.*)
            set_status office
            ;;
        *)
            set_status remote
            ;;
    esac
}

function create_config {
    [[ -d "$CONFIG_DIR" ]] || mkdir "$CONFIG_DIR"
    cat > "$CONFIG_FILE" <<EOF
# Configuration file for slack_status
TOKEN=$TOKEN

REMOTE_EMOJI=":house:"
REMOTE_TEXT="Working remotely"

OFFICE_EMOJI=":office:"
OFFICE_TEXT="Working at the office"
EOF
}

case "$1" in
    setup)
        echo "Slack status updater setup"
        read -r -p "${green}Enter your slack token: ${reset}" TOKEN
        create_config
        echo
        echo "A default configuration has been created at ${green}$CONFIG_FILE${reset}."
        echo "Feel free to edit that file to adapt the statuses to your preferences."
        exit 0
        ;;
    set)
        set_status "$2"
        ;;
    auto)
        auto_status
        ;;
    *)
        print_usage
        ;;
esac
