#!/bin/bash

# R.deVos 2015

# Test to test a delay timer for use with dahsing  list widget
# updating the widget cost time with a raspberry pi.

export TIMER_FILE="/tmp/timer.tmp"

echo doeing something
echo "add text to list of widget...."

# mag age in seconds
export MAX_AGE=4

if test -f "$TIMER_FILE" && test $(($(date +%s)-$(date -r ${TIMER_FILE} +%s))) -gt $(($MAX_AGE+20)); then
	echo "removing old timer file $TIMER_FILE"
	rm "$TIMER_FILE"
fi


if test -f "$TIMER_FILE"; then
	touch $TIMER_FILE
	echo "already running......"
	exit 0
fi

touch $TIMER_FILE
{

while test $(($(date +%s)-$(date -r ${TIMER_FILE} +%s))) -le $MAX_AGE
do
	sleep 1s
	echo $(($(date +%s)-$(date -r ${TIMER_FILE} +%s)))
	echo -n "."
done
rm "${TIMER_FILE}"

echo ""

echo starting
echo "updating widget"

} &

exit 0

