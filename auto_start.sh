BASE_DIR=$(dirname $0)

. $BASE_DIR/.env

CURR_TIME=$(date +%H:%M:%S)
TODAY=$(date +%Y-%m-%d)
YESTERDAY=$(date -d "yesterday" +%Y-%m-%d)

echo "[$TODAY $CURR_TIME] M9Auto Started." >> $BASE_DIR/.log
if [[ "$CURR_TIME" < "05:00:00" ]]; then
    if [[ "$PREV_TIME" < "$YESTERDAY 05:00:00" ]]; then
        $BASE_DIR/run.sh
    fi
else
    if [[ "$PREV_TIME" < "$TODAY 05:00:00" ]]; then
        $BASE_DIR/run.sh
    fi
fi
echo [$(date +"%Y-%m-%d %H:%M:%S")] "M9Auto Accomplished." >> $BASE_DIR/.log
