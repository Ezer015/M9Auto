#!/bin/bash

BASE_DIR="$(dirname "$0")"
ENV_FILE="$BASE_DIR/.env"
LOG_FILE="$BASE_DIR/.log"
RUN_SCRIPT="$BASE_DIR/run.sh"

# Check required files
[[ ! -f "$ENV_FILE" ]] && {
    echo "Environment file not found: $ENV_FILE"
    exit 1
}
[[ ! -f "$RUN_SCRIPT" ]] && {
    echo "Run script not found: $RUN_SCRIPT"
    exit 1
}
[[ ! -f "$LOG_FILE" ]] && touch "$LOG_FILE"

# shellcheck source=.env
source "$ENV_FILE"

DAILY_RUN_TIME="05:00:00"
CURR_TIME="$(date +%H:%M:%S)"
TODAY="$(date +%Y-%m-%d)"
YESTERDAY="$(date -d "yesterday" +%Y-%m-%d)"

log_message() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" >>"$LOG_FILE"
}

log_message "M9Auto Started."

# Calculate reference time point
if [[ "$CURR_TIME" < "$DAILY_RUN_TIME" ]]; then
    CHECK_TIME="$YESTERDAY $DAILY_RUN_TIME"
else
    CHECK_TIME="$TODAY $DAILY_RUN_TIME"
fi

# Execute if last run time is earlier than reference time
if [[ "$PREV_TIME" < "$CHECK_TIME" ]]; then
    bash "$RUN_SCRIPT" &>>"$LOG_FILE"
fi

log_message "M9Auto Accomplished."
