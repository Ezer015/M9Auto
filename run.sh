#!/bin/bash

BASE_DIR="$(dirname "$0")"
ENV_FILE="$BASE_DIR/.env"
LOG_FILE="$BASE_DIR/.log"

TIME_INTERVAL=10

# Check required files
[[ ! -f "$ENV_FILE" ]] && {
    echo "Environment file not found: $ENV_FILE"
    exit 1
}
[[ ! -f "$LOG_FILE" ]] && touch "$LOG_FILE"

source "$BASE_DIR/.env"

log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >>"$LOG_FILE"
}

log_message "Starting Waydroid..."
waydroid session start &

# Wait for session to be running
while true; do
    sleep "$TIME_INTERVAL"
    SESSION=$(waydroid status | grep 'Session' | cut -f2)
    [[ "$SESSION" == RUNNING* ]] && break

    log_message "Session: $SESSION"
    waydroid session stop
    waydroid session start &
done

sleep "$TIME_INTERVAL"
log_message "Running M9A CLI..."

"$M9A_CLI" -d | while IFS= read -r line; do
    # Remove ANSI escape sequences and check patterns
    clean_line=$(echo "$line" | sed 's/\x1B\[[0-9;]*[JKmsu]//g')
    if [[ $line =~ ^(on_maafw_notify:\ )(.*) ]] ||
        [[ $clean_line =~ ^(\[[0-9]{4}-[0-9]{1,2}-[0-9]{1,2}\ [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}\.[0-9]+\])(.*) ]]; then
        log_message "${BASH_REMATCH[2]}"
    fi
done

log_message "Stopping Waydroid..."
waydroid session stop

# Update last run time
CURR_TIME=$(date '+%Y-%m-%d %H:%M:%S')
sed -i "s/^PREV_TIME=.*/PREV_TIME=\"$CURR_TIME\"/" "$ENV_FILE"
