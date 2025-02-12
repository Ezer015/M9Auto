BASE_DIR=$(dirname $0)
TIME_INTERVAL=10

. $BASE_DIR/.env

echo [$(date +"%Y-%m-%d %H:%M:%S")] "Starting Waydroid..." >> $BASE_DIR/.log
waydroid session start &
sleep $TIME_INTERVAL
SESSION=$(waydroid status | grep 'Session' | cut -f2)
while [[ "$SESSION" != RUNNING* ]]
do
    echo [$(date +"%Y-%m-%d %H:%M:%S")] "Session: $SESSION" >> $BASE_DIR/.log
    waydroid session stop

    waydroid session start &
    sleep $TIME_INTERVAL
    SESSION=$(waydroid status | grep 'Session' | cut -f2)
done

sleep $TIME_INTERVAL
echo [$(date +"%Y-%m-%d %H:%M:%S")] "Running M9A CLI..." >> $BASE_DIR/.log
$M9A_CLI -d | cat | \
while IFS= read -r line
do
    if [[ $line =~ ^(on_maafw_notify: )(.*) || $(echo $line | sed 's/\x1B\[[0-9;]*[JKmsu]//g') =~ ^(\[[0-9]{4}-[0-9]{1,2}-[0-9]{1,2} [0-9]{1,2}:[0-9]{1,2}:[0-9]{1,2}.[0-9]+\])(.*) ]]; then
        echo [$(date +"%Y-%m-%d %H:%M:%S")] ${BASH_REMATCH[2]} >> $BASE_DIR/.log
    fi
done

echo [$(date +"%Y-%m-%d %H:%M:%S")] "Stopping Waydroid..." >> $BASE_DIR/.log
waydroid session stop

CURR_TIME=$(date +"%Y-%m-%d %H:%M:%S")
sed -i "s/^PREV_TIME=.*/PREV_TIME=\"$CURR_TIME\"/" "$BASE_DIR/.env"